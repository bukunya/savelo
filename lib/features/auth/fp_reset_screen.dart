import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_button.dart';
import '../../shared/widgets/s_input.dart';
import 'fp_success_screen.dart';
import '../../shared/widgets/s_step_progress.dart';

class FpResetScreen extends StatelessWidget {
  const FpResetScreen({super.key});

  Widget _buildChecklistItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const Icon(Icons.cancel, size: 16, color: SColors.sinput),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(color: SColors.sparagraph, fontSize: 12),
          ),
        ],
      ),
    );
  }

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
            const SStepProgress(currentStep: 3),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: SColors.sinput, width: 1.5),
              ),
              child: const Icon(Icons.lock_outline, color: SColors.sdarkgreen),
            ),
            const SizedBox(height: 24),

            const Text(
              "Buat password baru",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: SColors.sdarkgreen,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Pastikan password baru beda dari yang lama.",
              style: TextStyle(color: SColors.sparagraph, fontSize: 14),
            ),
            const SizedBox(height: 32),

            const SInput(
              hintText: "Password baru",
              prefixIcon: Icons.lock_outline,
              isPassword: true,
            ),
            const SizedBox(height: 16),
            const SInput(
              hintText: "Konfirmasi password",
              prefixIcon: Icons.lock_outline,
              isPassword: true,
            ),

            const SizedBox(height: 16),

            _buildChecklistItem("Min. 8 karakter"),
            _buildChecklistItem("1 huruf besar"),
            _buildChecklistItem("1 angka"),

            const SizedBox(height: 40),

            SButton(
              text: "Reset Password",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FpSuccessScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
