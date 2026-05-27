import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/destination.dart';
import '../repositories/destinations_repository.dart';

final mapPinsProvider = FutureProvider.autoDispose.family<List<MapPin>, String?>((ref, category) async {
  final repository = ref.watch(destinationsRepositoryProvider);
  return repository.getMapPins(city: 'Yogyakarta', category: category);
});

final destinationsProvider = FutureProvider.autoDispose.family<List<DestinationSummary>, String?>((ref, category) async {
  final repository = ref.watch(destinationsRepositoryProvider);
  return repository.getDestinations(city: 'Yogyakarta', category: category);
});

final destinationDetailProvider = FutureProvider.autoDispose.family<DestinationDetail, String>((ref, placeId) async {
  final repository = ref.watch(destinationsRepositoryProvider);
  return repository.getDestinationDetail(placeId);
});
