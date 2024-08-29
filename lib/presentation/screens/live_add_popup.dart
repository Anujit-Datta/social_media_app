import 'package:flutter/material.dart';
import 'package:social_media_app/presentation/widgets/common_appbar.dart';

import '../utils/assets_colors_path.dart';
import '../widgets/button_avatar.dart';
import '../widgets/customize_box.dart';
import '../widgets/logo_text.dart';
import '../widgets/selected_icon_button.dart';


class LiveAddScreen extends StatefulWidget {
  const LiveAddScreen({
    super.key,
  });

  @override
  State<LiveAddScreen> createState() => _LiveAddScreenState();
}

class _LiveAddScreenState extends State<LiveAddScreen> {
  bool _isIconChecked = false;

  void notificationsUpdate() {
    setState(() {
      _isIconChecked = !_isIconChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: commonAppBar(),
      backgroundColor: Colors.transparent,
      body: Center(
        child: CustomizeBox(
          color: Colors.white70,
          height: 220,
          width: 250,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Select from',
                  style: textTheme.titleMedium,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomIconButtons(
                    icon: Icons.camera_alt,
                    text: 'Camera',
                    onTap: () {},
                  ),
                  CustomIconButtons(
                    icon: Icons.photo,
                    text: 'Gallery',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}


