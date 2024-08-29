import 'package:flutter/material.dart';
import 'package:social_media_app/presentation/utils/app_colors.dart';
import 'package:social_media_app/presentation/widgets/common_appbar.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.add,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        'New Post',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: [
        MaterialButton(
          onPressed: () {},
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
          ),
          child: Row(
            children: [
              Text(
                'Post',
                style: TextStyle(
                  color: AppColors.accentColor,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.accentColor,
                size: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
