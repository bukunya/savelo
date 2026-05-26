import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/providers/auth_provider.dart';

class AuthGuard {
  /// Checks if the user is logged in. If yes, executes the [onAuthenticated] callback.
  /// If no, navigates to the LoginScreen.
  static void requireLogin(BuildContext context, VoidCallback onAuthenticated) {
    final container = ProviderScope.containerOf(context);
    final isLoggedIn = container.read(authProvider).user != null;

    if (isLoggedIn) {
      onAuthenticated();
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      ).then((_) {
        if (container.read(authProvider).user != null) {
          onAuthenticated();
        }
      });
    }
  }

  /// Returns the target widget if logged in, otherwise returns LoginScreen
  static Widget protectedRoute(BuildContext context, Widget target) {
    final container = ProviderScope.containerOf(context);
    final isLoggedIn = container.read(authProvider).user != null;
    return isLoggedIn ? target : const LoginScreen();
  }
}
