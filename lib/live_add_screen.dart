import 'package:flutter/material.dart';
import 'package:socia_live/presentation/ui/utils/assets_colors_path.dart';
import 'package:socia_live/presentation/ui/widget/button_avatar.dart';
import 'package:socia_live/presentation/ui/widget/customize_box.dart';
import 'package:socia_live/presentation/ui/widget/logo_text.dart';
import 'package:socia_live/presentation/ui/widget/selected_icon_button.dart';

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
      appBar: buildAppBar(),
      backgroundColor: Colors.transparent,
      body: Center(
        child: CustomizeBox(
          color: Colors.white70,
          height: 220,
          width: 250,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select from',
                style: textTheme.labelLarge,
              ),
              const SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SelectedIconButton(
                    icon: Icons.camera_alt,
                    text: 'Camera',
                    onTap: () {},
                  ),
                  SelectedIconButton(
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

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ButtonAvatar(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              'https://as2.ftcdn.net/v2/jpg/03/26/98/51/1000_F_326985142_1aaKcEjMQW6ULp6oI9MYuv8lN9f8sFmj.jpg',
              fit: BoxFit.cover,
              width: 32,
              height: 32,
            ),
          ),
        ),
      ),
      title: const LogoText(),
      actions: [
        ButtonAvatar(
          onTap: () {
            notificationsUpdate();
          },
          color: AssetsColorsPath.iconBackgroundColors,
          child: Icon(
            _isIconChecked
                ? Icons.notifications_active
                : Icons.notifications_none_outlined,
            size: 28,
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonAvatar(
            onTap: () {},
            color: AssetsColorsPath.iconBackgroundColors,
            child: const Icon(
              Icons.forum_outlined,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }
}


