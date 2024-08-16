import 'package:flutter/material.dart';
import 'package:social_media_app/presentation/screens/initial_screen.dart';

class SnapShare extends StatelessWidget {
  const SnapShare({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SnapShare',
      home: InitialScreen(),
    );
  }
}
