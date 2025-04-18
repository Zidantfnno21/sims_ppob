import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_popb/feature/auth/login/provider/login_provider.dart';
import 'package:sims_popb/feature/auth/login/widget/custom_email_field.dart';
import 'package:sims_popb/feature/auth/login/widget/custom_password_field.dart';
import 'package:sims_popb/feature/home/widget/async_action_button.dart';

import '../../../data/network/status.dart';
import '../../../utils/resources/assets.dart';
import '../../../utils/widgets/custom_snackbar.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<CustomEmailFieldState> emailFieldKey =
      GlobalKey<CustomEmailFieldState>();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<CustomPasswordFieldState> passwordFieldKey =
      GlobalKey<CustomPasswordFieldState>();

  void _onLoginPressed() {
    emailFieldKey.currentState?.triggerError();
    passwordFieldKey.currentState?.triggerError();

    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      context
          .read<LoginProvider>()
          .login(_emailController.text, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<LoginProvider>(builder: (context, value, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (value.loginResponse.status == Status.error) {
              final msg = value.loginResponse.message;
              CustomSnackbar.showError(context, msg!);
            }
          });

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.instance.logoIcon,
                          height: 30,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'SIMS PPOB',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Masuk atau buat akun untuk memulai',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 40),
                    CustomEmailField(
                        key: emailFieldKey,
                        controller: _emailController,
                        hintText: 'masukan email anda'),
                    const SizedBox(height: 16),
                    CustomPasswordField(
                        key: passwordFieldKey,
                        controller: _passwordController,
                        hintText: 'masukan password anda'),
                    const SizedBox(height: 32),
                    AsyncActionButton(
                        status: value.loginResponse.status,
                        text: 'Login',
                        onPressed: _onLoginPressed),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("belum punya akun? registrasi",style: TextStyle(color: Colors.grey),),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterScreen()),
                            );
                          },
                          child: const Text(
                            " di sini",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
