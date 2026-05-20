import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_button.dart';
import '../../shared/widgets/s_input.dart';
import 'fp_success_screen.dart';
import '../../shared/widgets/s_step_progress.dart';

class FpResetScreen extends StatefulWidget {
  const FpResetScreen({super.key});

  @override
  State<FpResetScreen> createState() => _FpResetScreenState();
}

class _FpResetScreenState extends State<FpResetScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _hasMin8 = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validatePassword(String value) {
    setState(() {
      _hasMin8 = value.length >= 8;
      _hasUppercase = value.contains(RegExp(r'[A-Z]'));
      _hasNumber = value.contains(RegExp(r'[0-9]'));
    });
  }

  bool _isFormValid() {
    return _hasMin8 &&
        _hasUppercase &&
        _hasNumber &&
        _passwordController.text.isNotEmpty &&
        _passwordController.text == _confirmPasswordController.text;
  }

  Widget _buildChecklistItem(String text, bool isValid) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: isValid ? Colors.green : SColors.sinput,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: isValid ? Colors.green : SColors.sparagraph,
              fontSize: 12,
            ),
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

            SInput(
              hintText: "Password baru",
              prefixIcon: Icons.lock_outline,
              isPassword: true,
              controller: _passwordController,
              onChanged: _validatePassword,
            ),
            const SizedBox(height: 16),
            SInput(
              hintText: "Konfirmasi password",
              prefixIcon: Icons.lock_outline,
              isPassword: true,
              controller: _confirmPasswordController,
              onChanged: (value) {
                setState(() {}); // Trigger re-build to update button status
              },
            ),

            const SizedBox(height: 16),

            _buildChecklistItem("Min. 8 karakter", _hasMin8),
            _buildChecklistItem("1 huruf besar", _hasUppercase),
            _buildChecklistItem("1 angka", _hasNumber),

            const SizedBox(height: 40),

            SButton(
              text: "Reset Password",
              color: _isFormValid() ? SColors.sdarkgreen : Colors.grey.shade400,
              onPressed: _isFormValid()
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FpSuccessScreen(),
                        ),
                      );
                    }
                  : () {},
            ),
          ],
        ),
      ),
    );
  }
}
