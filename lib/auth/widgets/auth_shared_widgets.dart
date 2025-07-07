import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.orange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          elevation: 2,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class AuthLinkText extends StatelessWidget {
  final String prefixText;
  final String linkText;
  final VoidCallback onTap;

  const AuthLinkText({
    super.key,
    required this.prefixText,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: prefixText,
        style: const TextStyle(color: Colors.black),
        children: [
          TextSpan(
            text: linkText,
            recognizer: TapGestureRecognizer()..onTap = onTap,
            style: const TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}