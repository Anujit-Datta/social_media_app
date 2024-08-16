import 'package:flutter/material.dart';
import 'package:social_media_app/presentation/utils/app_colors.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'SnapShare',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lobster',
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
            ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.accentColor,
              ),
              child: const Text('Create Account'),
            ),
            TextButton(
              onPressed: (){},
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
