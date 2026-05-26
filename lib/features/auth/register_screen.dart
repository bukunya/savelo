import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_button.dart';
import '../../shared/widgets/s_input.dart';
import '../../shared/widgets/s_google_button.dart';
import 'providers/auth_provider.dart';
import 'register_otp_screen.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _agreedToTerms = false;

  bool _hasMin8 = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
        _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _agreedToTerms;
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

            
            SInput(
              hintText: "Nama lengkap",
              prefixIcon: Icons.person_outline,
              controller: _nameController,
            ),
            const SizedBox(height: 16),
            SInput(
              hintText: "Email", 
              prefixIcon: Icons.email_outlined,
              controller: _emailController,
            ),
            const SizedBox(height: 16),
            SInput(
              hintText: "Password",
              prefixIcon: Icons.lock_outline,
              isPassword: true,
              controller: _passwordController,
              onChanged: _validatePassword,
            ),

            const SizedBox(height: 16),

            
            _buildChecklistItem("Min. 8 karakter", _hasMin8),
            _buildChecklistItem("1 huruf besar", _hasUppercase),
            _buildChecklistItem("1 angka", _hasNumber),

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
              text: ref.watch(authProvider).isLoading ? "Loading..." : "Daftar Sekarang",
              color: _isFormValid() ? SColors.sdarkgreen : Colors.grey.shade400,
              onPressed: _isFormValid() && !ref.watch(authProvider).isLoading
                  ? () async {
                      final success = await ref.read(authProvider.notifier).register(
                        _nameController.text,
                        _emailController.text,
                        _passwordController.text,
                      );
                      
                      if (success && mounted) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterOtpScreen(email: _emailController.text)));
                      } else if (mounted) {
                        final error = ref.read(authProvider).error;
                        if (error != null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
                        }
                      }
                    }
                  : () {},
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

            
            SGoogleButton(onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Google Login akan diimplementasikan nanti.')));
            }),

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
