import 'package:flutter/material.dart';
import 'core/savelo_colors.dart';
import 'features/splash/splash_screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: SaveloApp()));
}

class SaveloApp extends StatelessWidget {
  const SaveloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SAVELO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: SColors.sbackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: SColors.sdarkgreen,
          primary: SColors.sdarkgreen,
        ),
        fontFamily: 'Inter',
      ),
      home: const SplashScreen(),
    );
  }
}
