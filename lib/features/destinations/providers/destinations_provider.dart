import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/destination.dart';
import '../repositories/destinations_repository.dart';

final mapPinsProvider = FutureProvider<List<MapPin>>((ref) async {
  final repository = ref.watch(destinationsRepositoryProvider);
  return repository.getMapPins(city: 'Yogyakarta');
});

final destinationsProvider = FutureProvider.family<List<DestinationSummary>, String?>((ref, category) async {
  final repository = ref.watch(destinationsRepositoryProvider);
  return repository.getDestinations(city: 'Yogyakarta', category: category);
});

final destinationDetailProvider = FutureProvider.family<DestinationDetail, String>((ref, placeId) async {
  final repository = ref.watch(destinationsRepositoryProvider);
  return repository.getDestinationDetail(placeId);
});
