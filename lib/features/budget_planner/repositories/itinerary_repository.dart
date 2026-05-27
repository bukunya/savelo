import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../models/itinerary.dart';

final itineraryRepositoryProvider = Provider((ref) => ItineraryRepository());

class ItineraryRepository {
  final Dio _dio = ApiClient.instance.dio;

  Future<ItineraryGenerateData> generateItinerary(Map<String, dynamic> requestBody) async {
    try {
      final response = await _dio.post('/itineraries/generate', data: requestBody);
      return ItineraryGenerateData.fromJson(response.data['data']);
    } on DioException catch (e) {
      _throwFormattedError(e);
      throw Exception('Unreachable');
    }
  }

  Future<ItineraryDetailData> getItineraryDetail(int itineraryId) async {
    try {
      final response = await _dio.get('/itineraries/$itineraryId');
      return ItineraryDetailData.fromJson(response.data['data']);
    } on DioException catch (e) {
      _throwFormattedError(e);
      throw Exception('Unreachable');
    }
  }

  void _throwFormattedError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      final data = e.response?.data;
      if (data is Map && data['message'] != null) {
        throw Exception(data['message']);
      }
    }
    throw Exception('Terjadi kesalahan koneksi.');
  }
}
