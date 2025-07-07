import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String backgroundImage;

  const AuthHeader({
    super.key,
    required this.title,
    required this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Stack(
      children: [
        Container(
          height: size.height * 0.32,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 32,
          bottom: 80,
          child: Text(
            title,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ),
      ],
    );
  }
}