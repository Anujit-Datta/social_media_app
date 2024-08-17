import 'package:flutter/material.dart';
import 'package:social_media_app/presentation/utils/app_colors.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'SnapShare',
              style: TextStyle(
                fontSize: 35,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lobster',
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05,),
            ElevatedButton(
              onPressed: (){},
              child: Text(
                'Create Account',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Colors.white
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
            TextButton(
              onPressed: (){},
              child: Text(
                'Login',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: AppColors.accentColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
