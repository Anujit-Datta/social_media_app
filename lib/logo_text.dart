import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {
  const LogoText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'SociaLive',
      style: TextStyle(
        fontSize: 25,
        fontFamily: 'Lobster_Two',
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}