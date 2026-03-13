import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/providers/auth_provider.dart';
import 'package:automobile/widgets/fields/app_text_field.dart';
import 'package:automobile/widgets/fields/app_password_field.dart';
import 'package:automobile/widgets/buttons/app_elevated_button.dart';
import 'package:automobile/widgets/feedback/app_snackbar.dart';
import 'package:automobile/core/utils/validators.dart';
import 'package:automobile/core/constants/app_constants.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    try {
      await ref.read(authControllerProvider).login(
            _emailController.text.trim(),
            _passwordController.text,
          );
    } catch (e) {
      if (mounted) {
        AppSnackbar.showError(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authLoadingProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.08;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'AutoMobile',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(height: kBaseUnit * 6),
                AppTextField(
                  label: 'Email',
                  hint: 'Enter your email',
                  prefixIcon: Icons.email_outlined,
                  controller: _emailController,
                  validator: Validators.email,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: kBaseUnit * 2),
                AppPasswordField(
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: _passwordController,
                  validator: Validators.password,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: kBaseUnit * 4),
                SizedBox(
                  width: double.infinity,
                  child: AppElevatedButton(
                    label: 'Login',
                    isLoading: isLoading,
                    onPressed: _handleLogin,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
