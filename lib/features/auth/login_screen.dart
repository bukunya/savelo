import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_button.dart';
import '../../shared/widgets/s_input.dart';
import '../../shared/widgets/s_google_button.dart';
import 'register_screen.dart';
import 'fp_email_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SColors.sbackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
            const Text(
              "Selamat datang\nkembali, Velofam!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: SColors.sdarkgreen,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Login untuk lanjutkan rencana liburanmu.",
              style: TextStyle(color: SColors.sparagraph, fontSize: 14),
            ),
            const SizedBox(height: 32),

            const SInput(hintText: "Email", prefixIcon: Icons.email_outlined),
            const SizedBox(height: 16),
            const SInput(
              hintText: "Password",
              prefixIcon: Icons.lock_outline,
              isPassword: true,
            ),

            const SizedBox(height: 12),

            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FpEmailScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Lupa password?",
                  style: TextStyle(
                    color: SColors.sdarkgreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            SButton(
              text: "Login",
              onPressed: () {
                // TODO: Handle Login logic
              },
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(child: Divider(color: SColors.sinput, thickness: 1.5)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "atau",
                    style: TextStyle(color: SColors.sparagraph, fontSize: 12),
                  ),
                ),
                Expanded(child: Divider(color: SColors.sinput, thickness: 1.5)),
              ],
            ),

            const SizedBox(height: 24),

            SGoogleButton(onPressed: () {}),

            const SizedBox(height: 32),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Belum punya akun? ",
                  style: TextStyle(color: SColors.sparagraph),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Daftar",
                    style: TextStyle(
                      color: SColors.sdarkgreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
