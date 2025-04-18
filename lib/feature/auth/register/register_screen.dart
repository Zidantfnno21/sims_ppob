import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_popb/feature/auth/register/provider/register_provider.dart';
import 'package:sims_popb/feature/auth/register/widget/custom_name_field.dart';

import '../../../data/network/status.dart';
import '../../../utils/resources/assets.dart';
import '../../../utils/widgets/custom_snackbar.dart';
import '../login/widget/custom_email_field.dart';
import '../login/widget/custom_password_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<CustomEmailFieldState> emailFieldKey =
    GlobalKey<CustomEmailFieldState>();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<CustomPasswordFieldState> passwordFieldKey =
    GlobalKey<CustomPasswordFieldState>();
  final TextEditingController _confirmationPasswordController = TextEditingController();
  final GlobalKey<CustomPasswordFieldState> confirmationPasswordFieldKey =
    GlobalKey<CustomPasswordFieldState>();
  final TextEditingController _firstNameController = TextEditingController();
  final GlobalKey<CustomNameFieldState> firstNameFieldKey =
    GlobalKey<CustomNameFieldState>();
  final TextEditingController _lastnameController = TextEditingController();
  final GlobalKey<CustomNameFieldState> lastnameFieldKey =
    GlobalKey<CustomNameFieldState>();

  void _onRegisterPressed() {
    emailFieldKey.currentState?.triggerError();
    passwordFieldKey.currentState?.triggerError();
    confirmationPasswordFieldKey.currentState?.triggerError();
    lastnameFieldKey.currentState?.triggerError();
    firstNameFieldKey.currentState?.triggerError();

    final isPasswordMatch =
        _passwordController.text == _confirmationPasswordController.text;

    if (!isPasswordMatch) {
      confirmationPasswordFieldKey.currentState
          ?.triggerError('Password tidak sama');
    } else {
      confirmationPasswordFieldKey.currentState?.triggerError();
    }

    final isValid = _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmationPasswordController.text.isNotEmpty &&
        _firstNameController.text.isNotEmpty &&
        _lastnameController.text.isNotEmpty &&
        isPasswordMatch;

    if(isValid) {
      context.read<RegisterProvider>().register(
        _emailController.text,
        _firstNameController.text,
        _lastnameController.text,
        _passwordController.text,
      );
    }
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<RegisterProvider>(
          builder: (context, value, _) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (value.registrationResponse.status == Status.error) {
                final msg = value.registrationResponse.message;
                CustomSnackbar.showError(context, msg!);
              }
            });

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        'Lengkapi data untuk membuat akun',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 40),

                      CustomEmailField(
                          key: emailFieldKey,
                          controller: _emailController,
                          hintText: 'masukan email anda'),

                      const SizedBox(height: 16),

                      CustomNameField(
                          key: firstNameFieldKey,
                          controller: _firstNameController,
                          hintText: 'name depan'),

                      const SizedBox(height: 16),

                      CustomNameField(
                          key: lastnameFieldKey,
                          controller: _lastnameController,
                          hintText: 'name belakang'),

                      const SizedBox(height: 16),

                      CustomPasswordField(
                          key: passwordFieldKey,
                          controller: _passwordController,
                          hintText: 'buat password'),

                      const SizedBox(height: 16),

                      CustomPasswordField(
                          key: confirmationPasswordFieldKey,
                          controller: _confirmationPasswordController,
                          hintText: 'konfirmasi password'),

                      const SizedBox(height: 32),

                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: Consumer<RegisterProvider>(
                          builder: (context, provider, _) {
                            final isLoading = provider.registrationResponse.status == Status.loading;

                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                elevation: 0
                              ),
                              onPressed: isLoading ? null : _onRegisterPressed,
                              child: isLoading
                                  ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                                  : const Text(
                                'Registrasi',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("sudah punya akun? login"),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
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

                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
