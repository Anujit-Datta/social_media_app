import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/presentation/screens/initial_screen.dart';
import 'package:social_media_app/presentation/utils/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class SnapShare extends StatelessWidget {
  const SnapShare({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SnapShare',
      home: const InitialScreen(),
      theme: ThemeData(
        elevatedButtonTheme: buildElevatedButtonThemeData(),
        textTheme: buildTextTheme(),
        inputDecorationTheme: InputDecorationTheme(
          prefixIconColor: Colors.grey,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          constraints: BoxConstraints(
            minHeight: MediaQuery.sizeOf(context).height*0.04,
            maxHeight: MediaQuery.sizeOf(context).height*0.075,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1.5,
              color: Colors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.5
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors.accentColor,
              width: 1.5,
            ),
          ),
        )
      ),
    );
  }

  TextTheme buildTextTheme() {
    return TextTheme(
      labelMedium: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 15,
      ),
      titleLarge: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: AppColors.textColor,
      ),
      titleSmall: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600
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
