import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {
  const LogoText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'SnapShare',
      style: TextStyle(
        fontSize: 25,
        fontFamily: 'Lobster',
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}