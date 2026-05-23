import 'package:flutter/material.dart';
import 'auth_service.dart';
import '../features/auth/login_screen.dart';

class AuthGuard {
  /// Checks if the user is logged in. If yes, executes the [onAuthenticated] callback.
  /// If no, navigates to the LoginScreen.
  static void requireLogin(BuildContext context, VoidCallback onAuthenticated) {
    if (AuthService.instance.isLoggedIn) {
      onAuthenticated();
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      ).then((loggedIn) {
        // Optional: If login screen returns true upon successful login, execute callback
        // This is a future enhancement; for now, we just require them to navigate again
        // or we could automatically execute if they log in.
        if (AuthService.instance.isLoggedIn) {
          onAuthenticated();
        }
      });
    }
  }

  /// Returns the target widget if logged in, otherwise returns LoginScreen
  static Widget protectedRoute(Widget target) {
    return AuthService.instance.isLoggedIn ? target : const LoginScreen();
  }
}
