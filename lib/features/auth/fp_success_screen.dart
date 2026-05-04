import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_button.dart';
import '../../shared/widgets/s_step_progress.dart';

class FpSuccessScreen extends StatelessWidget {
  const FpSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SColors.sbackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Lupa Password",
          style: TextStyle(color: SColors.sbold, fontSize: 16),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: SColors.sbold,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SStepProgress(currentStep: 3),
              const Spacer(),

              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: SColors.sdarkgreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 64),
              ),
              const SizedBox(height: 32),

              const Text(
                "Password berhasil diubah!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: SColors.sdarkgreen,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Sekarang kamu bisa login dengan password baru. Selamat melanjutkan petualangan.",
                textAlign: TextAlign.center,
                style: TextStyle(color: SColors.sparagraph, fontSize: 14),
              ),

              const Spacer(),

              SButton(
                text: "Login Sekarang",
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
