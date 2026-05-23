import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  static final AuthService _instance = AuthService._internal();
  static AuthService get instance => _instance;

  AuthService._internal();

  bool _isLoggedIn = false;
  
  bool get isLoggedIn => _isLoggedIn;

  // Extensible mock login implementation
  Future<bool> login(String username, String password) async {
    // Simulate network delay for real auth implementation later
    await Future.delayed(const Duration(milliseconds: 500));
    
    _isLoggedIn = true;
    notifyListeners();
    return true;
  }

  // Extensible mock logout implementation
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _isLoggedIn = false;
    notifyListeners();
  }
}
