import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_button.dart';
import '../../shared/widgets/s_input.dart';
import '../../shared/widgets/s_google_button.dart';
import 'register_screen.dart';
import 'fp_email_screen.dart';
import 'providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  bool _isLoading = false;

  void _handleLogin() async {
    final success = await ref.read(authProvider.notifier).login(
      _emailController.text,
      _passwordController.text,
    );
    
    if (!mounted) return;
    
    if (success) {
      Navigator.pop(context, true);
    } else {
      final error = ref.read(authProvider).error;
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      }
    }
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
              text: ref.watch(authProvider).isLoading ? "Loading..." : "Login",
              onPressed: ref.watch(authProvider).isLoading ? () {} : _handleLogin,
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

            SGoogleButton(onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Google Login akan diimplementasikan nanti.')));
            }),

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
