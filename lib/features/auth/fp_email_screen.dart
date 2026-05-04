import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_button.dart';
import '../../shared/widgets/s_input.dart';
import 'fp_otp_screen.dart';
import '../../shared/widgets/s_step_progress.dart';

class FpEmailScreen extends StatelessWidget {
  const FpEmailScreen({super.key});

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SStepProgress(currentStep: 1),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: SColors.sinput, width: 1.5),
              ),
              child: const Icon(
                Icons.email_outlined,
                color: SColors.sdarkgreen,
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              "Masukkan email kamu",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: SColors.sdarkgreen,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Kami akan kirim kode verifikasi 6-digit ke email yang terdaftar.",
              style: TextStyle(color: SColors.sparagraph, fontSize: 14),
            ),
            const SizedBox(height: 32),

            const SInput(hintText: "Email", prefixIcon: Icons.email_outlined),

            const SizedBox(height: 12),

            const Text(
              "Tidak menerima email dalam 60 detik? Cek folder spam atau coba kirim ulang.",
              style: TextStyle(color: SColors.sparagraph, fontSize: 12),
            ),

            const SizedBox(height: 40),

            SButton(
              text: "Kirim Kode",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FpOtpScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
