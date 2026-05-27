import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../models/destination.dart';

final destinationsRepositoryProvider = Provider((ref) => DestinationsRepository());

class DestinationsRepository {
  final Dio _dio = ApiClient.instance.dio;

  Future<List<MapPin>> getMapPins({required String city}) async {
    try {
      final response = await _dio.get('/destinations/map', queryParameters: {'city': city});
      final data = response.data['data']['destinations'] as List;
      return data.map((json) => MapPin.fromJson(json)).toList();
    } on DioException catch (e) {
      _throwFormattedError(e);
      throw Exception('Unreachable');
    }
  }

  Future<List<DestinationSummary>> getDestinations({required String city, String? category}) async {
    try {
      final queryParams = <String, dynamic>{'city': city};
      if (category != null) queryParams['category'] = category;
      
      final response = await _dio.get('/destinations', queryParameters: queryParams);
      final data = response.data['data']['destinations'] as List;
      return data.map((json) => DestinationSummary.fromJson(json)).toList();
    } on DioException catch (e) {
      _throwFormattedError(e);
      throw Exception('Unreachable');
    }
  }

  Future<DestinationDetail> getDestinationDetail(String placeId) async {
    try {
      final response = await _dio.get('/destinations/$placeId');
      return DestinationDetail.fromJson(response.data['data']['destination']);
    } on DioException catch (e) {
      _throwFormattedError(e);
      throw Exception('Unreachable');
    }
  }

  void _throwFormattedError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      final data = e.response?.data;
      if (data['message'] != null) {
        throw Exception(data['message']);
      }
    }
    throw Exception('Terjadi kesalahan koneksi.');
  }
}
