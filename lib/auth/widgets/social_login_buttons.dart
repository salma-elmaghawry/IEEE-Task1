import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.facebook, size: 40),
          onPressed: () {
            // Handle Facebook login
          },
        ),
        const SizedBox(width: 16),
        IconButton(
          icon: Image.asset('assets/images/google.png', width: 40, height: 40),
          onPressed: () {
            // Handle Google login
          },
        ),
        const SizedBox(width: 16),
        IconButton(
          icon: const Icon(Icons.apple, size: 40),
          onPressed: () {
            // Handle Apple login
          },
        ),
      ],
    );
  }
}
