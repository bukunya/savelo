import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_button.dart';
import 'fp_reset_screen.dart';
import '../../shared/widgets/s_step_progress.dart';

class FpOtpScreen extends StatefulWidget {
  final String email;
  const FpOtpScreen({super.key, required this.email});

  @override
  State<FpOtpScreen> createState() => _FpOtpScreenState();
}

class _FpOtpScreenState extends State<FpOtpScreen> {
  final List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());

  @override
  void dispose() {
    for (var c in _controllers) c.dispose();
    super.dispose();
  }

  Widget _buildOtpCell(BuildContext context, int index) {
    return SizedBox(
      width: 48,
      height: 56,
      child: TextFormField(
        controller: _controllers[index],
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: SColors.sinput, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: SColors.sdarkgreen, width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
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
            const SStepProgress(currentStep: 2),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: SColors.sinput, width: 1.5),
              ),
              child: const Icon(Icons.key_outlined, color: SColors.sdarkgreen),
            ),
            const SizedBox(height: 24),

            const Text(
              "Cek inbox kamu",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: SColors.sdarkgreen,
              ),
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: "Kode 6-digit dikirim ke ",
                style: const TextStyle(color: SColors.sparagraph, fontSize: 14),
                children: [
                  TextSpan(
                    text: widget.email,
                    style: const TextStyle(
                      color: SColors.sbold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) => _buildOtpCell(context, index)),
            ),

            const SizedBox(height: 24),

            Align(
              alignment: Alignment.center,
              child: Text.rich(
                TextSpan(
                  text: "Tidak menerima kode? ",
                  style: TextStyle(color: SColors.sparagraph, fontSize: 14),
                  children: [
                    TextSpan(
                      text: "Kirim ulang (00:42)",
                      style: TextStyle(
                        color: SColors.sdarkgreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            SButton(
              text: "Verifikasi",
              onPressed: () {
                final otp = _controllers.map((c) => c.text).join();
                if (otp.length < 6) return;
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FpResetScreen(email: widget.email, otp: otp),
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
