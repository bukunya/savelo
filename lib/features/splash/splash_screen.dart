import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_button.dart';
import '../home/home_screen.dart'; 
import '../auth/providers/auth_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch authProvider to initialize user session from secure storage early
    ref.watch(authProvider);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [SColors.ssplashTop, SColors.ssplashBottom],
              ),
            ),
          ),

          Positioned(
            top: -100,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                color: SColors.stopBubble,
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                color: SColors.sbottomBubble,
                shape: BoxShape.circle,
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 32.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: SColors.smustard, // Gold/yellow background
                      borderRadius: BorderRadius.circular(24), // Rounded
                    ),
                    padding: const EdgeInsets.all(12),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: SColors.sdarkgreen,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'SAVELO',
                    style: TextStyle(
                      color: SColors.ssplashText,
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Save more. Explore more.',
                    style: TextStyle(
                      color: SColors.smustard,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Travel planner pertama yang dimulai dari\nbudget kamu - bukan dari destinasi.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),

                  const Spacer(),
                  SButton(
                    text: 'Mulai Petualangan',
                    color: SColors.smustard,
                    icon: Icons.arrow_forward,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
