import 'package:flutter/material.dart';
import 'package:auth/auth/register.dart';
import 'package:auth/auth/widgets/auth_header.dart';
import 'package:auth/auth/widgets/auth_shared_widgets.dart';
import 'package:auth/auth/widgets/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const AuthHeader(title: 'Login', backgroundImage: 'assets/bg.png'),
            Expanded(
              child: Transform.translate(
                offset: const Offset(0, -32),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        _buildTextField(
                          'Email',
                          _emailController,
                          isEmail: true,
                        ),
                        _buildTextField(
                          'Password',
                          _passwordController,
                          isPassword: true,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged:
                                  (value) => setState(
                                    () => _rememberMe = value ?? false,
                                  ),
                              activeColor: Colors.orange,
                            ),
                            const Text('Stay logged in?'),
                            const Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        AuthButton(text: 'Login', onPressed: _submitForm),
                        const SizedBox(height: 16),
                        Center(
                          child: AuthLinkText(
                            prefixText: "Don't have an account yet? Register",
                            linkText: " here",
                            onTap:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const RegisterScreen(),
                                  ),
                                ),
                          ),
                        ),
                        const SocialLoginButtons(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isEmail = false,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          controller: controller,
          obscureText: isPassword ? _obscurePassword : false,
          keyboardType: isEmail ? TextInputType.emailAddress : null,
          decoration: InputDecoration(
            hintText: 'Enter your ${label.toLowerCase()}',
            suffixIcon:
                isPassword
                    ? IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed:
                          () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                    )
                    : null,
          ),
          validator: (value) {
            if (value == null || value.isEmpty)
              return 'Please enter your ${label.toLowerCase()}';
            if (isEmail && !value.contains('@')) return 'Invalid email';
            if (isPassword && value.length < 8) return 'Minimum 8 characters';
            return null;
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle login logic
    }
  }
}
