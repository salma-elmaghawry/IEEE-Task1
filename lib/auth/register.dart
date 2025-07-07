import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:image_picker/image_picker.dart';
import 'package:auth/auth/login.dart';
import 'package:auth/auth/widgets/auth_header.dart';
import 'package:auth/auth/widgets/auth_shared_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controllers = {
    'name': TextEditingController(),
    'email': TextEditingController(),
    'phone': TextEditingController(),
    'password': TextEditingController(),
    'confirmPassword': TextEditingController(),
  };
  final _obscure = {'password': true, 'confirmPassword': true};
  File? _profileImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null)
      setState(() => _profileImage = File(pickedFile.path));
  }

  Widget _buildTextField(String label, String key, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _controllers[key],
          obscureText: isPassword ? _obscure[key]! : false,
          keyboardType:
              key == 'email'
                  ? TextInputType.emailAddress
                  : key == 'phone'
                  ? TextInputType.phone
                  : null,
          decoration: InputDecoration(
            hintText: 'Your $key',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
          ),
          validator: (value) => _validateField(key, value),
        ),
        const Divider(),
        const SizedBox(height: 16),
      ],
    );
  }

  String? _validateField(String key, String? value) {
    if (value == null || value.isEmpty) return 'Please enter your $key';
    if (key == 'email' && !value.contains('@')) return 'Invalid email';
    if (key == 'password' && value.length < 8) return 'Minimum 8 characters';
    if (key == 'confirmPassword' && value != _controllers['password']!.text) {
      return 'Passwords don\'t match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              const AuthHeader(
                title: 'Register',
                backgroundImage: 'assets/bg.png',
              ),
              Expanded(
                child: Transform.translate(
                  offset: const Offset(0, -32),
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 50),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            ...['name', 'email', 'phone'].map(
                              (e) => _buildTextField(
                                e[0].toUpperCase() + e.substring(1),
                                e,
                              ),
                            ),
                            _buildTextField(
                              'Password',
                              'password',
                              isPassword: true,
                            ),
                            _buildTextField(
                              'Confirm Password',
                              'confirmPassword',
                              isPassword: true,
                            ),
                            AuthButton(
                              text: 'Register',
                              onPressed: _submitForm,
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: AuthLinkText(
                                prefixText: "Already have an account? Login",
                                linkText: " here",
                                onTap:
                                    () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => const LoginScreen(),
                                      ),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: size.height * 0.25,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[300]!, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child:
                        _profileImage != null
                            ? Image.file(_profileImage!, fit: BoxFit.cover)
                            : const Icon(
                              Icons.add_a_photo,
                              size: 40,
                              color: Colors.grey,
                            ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle registration
      print('Registration data:');
      for (var entry in _controllers.entries) {
        print('${entry.key}: ${entry.value.text}');
      }
      print('Profile Image: ${_profileImage?.path}');
    }
  }
}
