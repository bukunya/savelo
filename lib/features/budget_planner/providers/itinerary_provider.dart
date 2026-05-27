import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/itinerary.dart';
import '../repositories/itinerary_repository.dart';

final activeTripIdProvider = FutureProvider.autoDispose<int?>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('active_trip_id');
});

final itineraryDetailProvider = FutureProvider.autoDispose.family<ItineraryDetailData, int>((ref, itineraryId) async {
  final repository = ref.watch(itineraryRepositoryProvider);
  return repository.getItineraryDetail(itineraryId);
});
