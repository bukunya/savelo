import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../models/user.dart';

class AuthRepository {
  final Dio _dio = ApiClient.instance.dio;

  Future<void> register(String name, String email, String password) async {
    try {
      await _dio.post('/auth/register', data: {
        'name': name,
        'email': email,
        'password': password,
      });
    } on DioException catch (e) {
      _throwFormattedError(e);
    }
  }

  Future<AuthResponse> verifyOtp(String email, String otp) async {
    try {
      final response = await _dio.post('/auth/register/verify', data: {
        'email': email,
        'otp': otp,
      });
      return AuthResponse.fromJson(response.data['data']);
    } on DioException catch (e) {
      _throwFormattedError(e);
      throw Exception('Unreachable');
    }
  }

  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      return AuthResponse.fromJson(response.data['data']);
    } on DioException catch (e) {
      _throwFormattedError(e);
      throw Exception('Unreachable');
    }
  }

  Future<void> requestPasswordReset(String email) async {
    try {
      await _dio.post('/auth/forgot-password', data: {
        'email': email,
      });
    } on DioException catch (e) {
      _throwFormattedError(e);
    }
  }

  Future<void> resetPassword(String email, String otp, String password, String passwordConfirmation) async {
    try {
      await _dio.post('/auth/forgot-password/reset', data: {
        'email': email,
        'otp': otp,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });
    } on DioException catch (e) {
      _throwFormattedError(e);
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

class AuthResponse {
  final User user;
  final String token;

  AuthResponse({required this.user, required this.token});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }
}
