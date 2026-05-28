import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/destination.dart';
import '../repositories/destinations_repository.dart';
import '../../auth/providers/auth_provider.dart';

final mapPinsProvider = FutureProvider.autoDispose.family<List<MapPin>, String?>((ref, category) async {
  ref.watch(authProvider.select((state) => state.user != null));
  final repository = ref.watch(destinationsRepositoryProvider);
  return repository.getMapPins(city: 'Yogyakarta', category: category);
});

final destinationsProvider = FutureProvider.autoDispose.family<List<DestinationSummary>, String?>((ref, category) async {
  ref.watch(authProvider.select((state) => state.user != null));
  final repository = ref.watch(destinationsRepositoryProvider);
  return repository.getDestinations(city: 'Yogyakarta', category: category);
});

final destinationDetailProvider = FutureProvider.autoDispose.family<DestinationDetail, String>((ref, placeId) async {
  ref.watch(authProvider.select((state) => state.user != null));
  final repository = ref.watch(destinationsRepositoryProvider);
  return repository.getDestinationDetail(placeId);
});
