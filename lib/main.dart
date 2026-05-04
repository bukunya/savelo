import 'package:flutter/material.dart';
import 'core/savelo_colors.dart';
import 'features/splash/splash_screen.dart';

void main() {
  runApp(const SaveloApp());
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
