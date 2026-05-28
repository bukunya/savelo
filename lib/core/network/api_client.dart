import 'dart:io';
import 'package:dio/dio.dart';
import '../storage/token_storage.dart';

class ApiClient {
  static final ApiClient instance = ApiClient._internal();

  late Dio dio;

  // Since you are using Android Emulator, 10.0.2.2 maps to your machine's localhost:8000
  // If running on a physical device, this should be your computer's local IP address.
  static String get baseUrl {
    if (Platform.isAndroid) {
      // return 'http://10.0.2.2:8000/api';
      return 'http://127.0.0.1:8000/api';
      // return 'https://savelobe.afif.dev/api';
    }
    return 'http://localhost:8000/api';
    // return 'https://savelobe.afif.dev/api';
  }

  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(minutes: 3),
        receiveTimeout: const Duration(minutes: 3),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // Add interceptor to attach Bearer token to requests
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenStorage.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // You could handle global errors here (e.g., 401 Unauthorized -> logout)
          return handler.next(e);
        },
      ),
    );
  }
}
