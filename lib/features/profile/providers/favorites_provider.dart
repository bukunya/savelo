import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/favorite_destination.dart';
import '../repositories/favorites_repository.dart';

final favoritesProvider = AsyncNotifierProvider<FavoritesNotifier, List<FavoriteDestination>>(() {
  return FavoritesNotifier();
});

class FavoritesNotifier extends AsyncNotifier<List<FavoriteDestination>> {
  late final FavoritesRepository _repository;

  @override
  Future<List<FavoriteDestination>> build() async {
    _repository = ref.read(favoritesRepositoryProvider);
    return _repository.getFavorites();
  }

  bool isFavorite(int destinationId) {
    if (!state.hasValue) return false;
    return state.value!.any((dest) => dest.id == destinationId);
  }

  Future<void> toggleFavorite(int destinationId) async {
    if (!state.hasValue) return;
    
    final currentlyFavorite = isFavorite(destinationId);
    final previousState = state;
    
    // Optimistic UI update
    if (currentlyFavorite) {
      state = AsyncData(state.value!.where((d) => d.id != destinationId).toList());
    } else {
      // Optimistically add a dummy FavoriteDestination just so the ID matches isFavorite.
      // The rest of the properties don't matter because the UI checking isFavorite only needs ID.
      final dummy = FavoriteDestination(
        id: destinationId,
        placeId: '',
        name: '',
        slug: '',
        category: 'wisata',
        city: '',
        lat: 0,
        lng: 0,
        photos: [],
      );
      state = AsyncData([...state.value!, dummy]);
    }

    try {
      if (currentlyFavorite) {
        await _repository.removeFavorite(destinationId);
      } else {
        await _repository.addFavorite(destinationId);
        // Need to refetch to get the actual destination object added to the list
        final newList = await _repository.getFavorites();
        state = AsyncData(newList);
      }
    } catch (e, st) {
      // Revert on error
      state = previousState;
      state = AsyncError(e, st);
    }
  }
}
