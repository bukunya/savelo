import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../models/favorite_destination.dart';

final favoritesRepositoryProvider = Provider((ref) => FavoritesRepository());

class FavoritesRepository {
  final Dio _dio = ApiClient.instance.dio;

  Future<List<FavoriteDestination>> getFavorites() async {
    try {
      final response = await _dio.get('/favorites');
      final data = response.data['data']['destinations'] as List;
      return data.map((json) => FavoriteDestination.fromJson(json)).toList();
    } on DioException catch (e) {
      _throwFormattedError(e);
      throw Exception('Unreachable');
    }
  }

  Future<void> addFavorite(int destinationId) async {
    try {
      await _dio.post(
        '/favorites',
        data: {'destination_id': destinationId},
      );
    } on DioException catch (e) {
      _throwFormattedError(e);
      throw Exception('Unreachable');
    }
  }

  Future<void> removeFavorite(int destinationId) async {
    try {
      await _dio.delete('/favorites/$destinationId');
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
