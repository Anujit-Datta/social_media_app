import 'package:flutter/material.dart';
import 'package:social_media_app/presentation/screens/initial_screen.dart';
import 'package:social_media_app/presentation/utils/app_colors.dart';

class SnapShare extends StatelessWidget {
  const SnapShare({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnapShare',
      home: const InitialScreen(),
      theme: ThemeData(
        elevatedButtonTheme: buildElevatedButtonThemeData(),
        textTheme: buildTextTheme()
      ),
    );
  }

  TextTheme buildTextTheme() {
    return const TextTheme(
      labelMedium: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 15,
      ),
    );
  }

  ElevatedButtonThemeData buildElevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.accentColor,
        fixedSize: const Size(double.maxFinite, 50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
      ),
    );
  }
}
