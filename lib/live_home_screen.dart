import 'package:flutter/material.dart';

import 'package:social_media_app/utils/assets_colors_path.dart';
import 'package:social_media_app/widget/button_avatar.dart';
import 'package:social_media_app/widget/button_bar.dart';
import 'package:social_media_app/widget/customize_box.dart';
import 'package:social_media_app/widget/logo_text.dart';
import 'package:social_media_app/widget/text_rich.dart';

class LiveHomeScreen extends StatefulWidget {
  const LiveHomeScreen({super.key});

  @override
  State<LiveHomeScreen> createState() => _LiveHomeScreenState();
}

class _LiveHomeScreenState extends State<LiveHomeScreen> {
  bool _isIconChecked = false;
  bool _isFavoriteIconChecked = false;

  void notificationsUpdate() {
    setState(() {
      _isIconChecked = !_isIconChecked;
    });
  }

  void favoriteUpdate() {
    setState(() {
      _isFavoriteIconChecked = !_isFavoriteIconChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildStoryList(),
            buildUserDetails(textTheme),
          ],
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

  Widget buildStoryList() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: Colors.white,
        height: 180,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 4,
                top: 0,
                right: 4,
                bottom: 0,
              ),
              child: Container(
                height: 100,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?t=st=1724228536~exp=1724229136~hmac=32879a49496018577775f1cb5c73589142ecb98ac26348d0ac4fcb8010778d9e',
                            fit: BoxFit.cover,
                            height: 140,
                            width: 120,
                          ),
                        ),
                        if (index % 10 == 0)
                          Positioned(
                            bottom: 40,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.add_circle,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 6,
                            left: 4,
                            right: 1,
                          ),
                          child: ButtonAvatar(
                            onTap: () {},
                            child: const Text(''),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      index % 10 == 0 ? 'You' : 'userName',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildUserDetails(TextTheme textTheme) {
    return SizedBox(
      height: 450,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 10,
            ),
            child: CustomizeBox(
              height: 410,
              width: 250,
              color: Colors.white70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ButtonAvatar(
                          onTap: () {},
                          child: const Text(''),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        TextRich(
                          textTheme: textTheme,
                          title: 'Name\n',
                          subTitle: '@UserName',
                        ),
                        const Spacer(),
                        buildIMenuBar(context, textTheme),
                      ],
                    ),
                  ),
                  Card(
                    child: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1024px-Image_created_with_a_mobile_phone.png'),
                  ),
                  buildFavCommentButton(textTheme),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

 Widget buildIMenuBar(BuildContext context, TextTheme textTheme) {
    return ButtonIconBar(
                        icon: const Icon(Icons.keyboard_arrow_down),
                        onTap: () {
                          showMenu(
                            context: context,
                            position: const RelativeRect.fromLTRB(100,300,20,0),
                            items: [
                              PopupMenuItem(
                                child: ListTile(
                                  leading: const Icon(Icons.delete),
                                  title: Text('Delete',
                                      style: textTheme.titleMedium),
                                  onTap: () {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Delete action pressed!')),
                                    );
                                    Navigator.pop(context); // Close the menu
                                  },
                                ),
                              ),
                              PopupMenuItem(
                                child: ListTile(
                                  leading: const Icon(Icons.edit_note_sharp),
                                  title: Text('Edit',
                                      style: textTheme.titleMedium),
                                  onTap: () {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Edit action pressed!')),
                                    );
                                    Navigator.pop(context); // Close the menu
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      );
  }

  Widget buildFavCommentButton(TextTheme textTheme) {
    return Row(
      children: [
        ButtonIconBar(
          icon: Icon(
            _isFavoriteIconChecked ? Icons.favorite : Icons.favorite_border,
          ),
          onTap: () {},
        ),
        ButtonIconBar(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => buildCommentBar(textTheme, context),
            );
          },
          icon: Row(
            children: [
              const Icon(Icons.comment_outlined),
              const SizedBox(
                width: 5,
              ),
              const Text('20'),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Comment',
                style: textTheme.labelMedium,
              ),
            ],
          ),
        ),
        const Spacer(),
        ButtonIconBar(
          icon: const Icon(
            Icons.bookmark_outline_outlined,
          ),
          onTap: () {},
        ),
      ],
    );
  }

  Widget buildCommentBar(TextTheme textTheme, BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const CustomizeBox(
          height: 5,
          width: 50,
          color: Colors.black45,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Comment',
          style: textTheme.labelMedium,
        ),
        Expanded(
          child: CustomizeBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ButtonAvatar(
                                  onTap: () {},
                                  child: const Text(''),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextRich(
                                  textTheme: textTheme,
                                  title: 'Name',
                                  subTitle: ' 2 hour ago\n',
                                  commentText:
                                      'Nice picture you have captured 🔥 \n',
                                  replayText: 'Replay',
                                ),
                                const Spacer(),
                                ButtonIconBar(
                                  icon: Icon(
                                    _isFavoriteIconChecked
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Add Comment',
            suffixStyle: textTheme.labelMedium,
            prefixIcon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: ButtonAvatar(),
            ),
            suffixIcon: TextButton(
              onPressed: () {},
              child: Text(
                'Post',
                style: textTheme.labelSmall,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
