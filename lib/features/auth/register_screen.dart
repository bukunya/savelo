import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_button.dart';
import '../../shared/widgets/s_input.dart';
import '../../shared/widgets/s_google_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _agreedToTerms = false;

  
  Widget _buildChecklistItem(String text, bool isValid) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: isValid ? SColors.sdarkgreen : SColors.sinput,
          ),
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
              "Buat akun baru",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: SColors.sdarkgreen,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Mulai rencanakan trip yang sesuai budget kamu.",
              style: TextStyle(color: SColors.sparagraph, fontSize: 14),
            ),
            const SizedBox(height: 32),

            
            const SInput(
              hintText: "Nama lengkap",
              prefixIcon: Icons.person_outline,
            ),
            const SizedBox(height: 16),
            const SInput(hintText: "Email", prefixIcon: Icons.email_outlined),
            const SizedBox(height: 16),
            const SInput(
              hintText: "Password",
              prefixIcon: Icons.lock_outline,
              isPassword: true,
            ),

            const SizedBox(height: 16),

            
            _buildChecklistItem("Min. 8 karakter", false),
            _buildChecklistItem("1 huruf besar", false),
            _buildChecklistItem("1 angka", false),

            const SizedBox(height: 24),

            
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: _agreedToTerms,
                    activeColor: SColors.sdarkgreen,
                    side: const BorderSide(color: SColors.sinput, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _agreedToTerms = value ?? false;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: "Saya menyetujui ",
                      style: TextStyle(
                        color: SColors.sparagraph,
                        fontSize: 12,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: "Syarat Layanan",
                          style: TextStyle(
                            color: SColors.sdarkgreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: " & "),
                        TextSpan(
                          text: "Kebijakan Privasi",
                          style: TextStyle(
                            color: SColors.sdarkgreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: " SAVELO."),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            
            SButton(
              text: "Daftar Sekarang",
              onPressed: () {
                // TODO: Handle Register
              },
            ),

            const SizedBox(height: 24),

            
            Row(
              children: [
                Expanded(child: Divider(color: SColors.sinput, thickness: 1.5)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "atau daftar dengan",
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
                  "Sudah punya akun? ",
                  style: TextStyle(color: SColors.sparagraph),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); 
                  },
                  child: const Text(
                    "Login disini",
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
