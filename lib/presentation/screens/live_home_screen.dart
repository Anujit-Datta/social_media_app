import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media_app/presentation/controllers/auth_shared_pref.dart';
import 'package:social_media_app/presentation/controllers/posts_controller.dart';
import 'package:social_media_app/presentation/screens/profile_screen.dart';
import 'package:social_media_app/presentation/utils/app_colors.dart';
import '../utils/assets_colors_path.dart';
import '../widgets/button_avatar.dart';
import '../widgets/button_bar.dart';
import '../widgets/customize_box.dart';
import '../widgets/logo_text.dart';
import '../widgets/text_rich.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;


class LiveHomeScreen extends StatefulWidget {
  const LiveHomeScreen({super.key});

  @override
  State<LiveHomeScreen> createState() => _LiveHomeScreenState();
}

class _LiveHomeScreenState extends State<LiveHomeScreen> {
  bool _isIconChecked = false;
  bool _isFavoriteIconChecked = false;
  ScrollController sharedScrollController = ScrollController();

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
  void initState() {
    super.initState();
    Get.find<PostController>().fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        controller: sharedScrollController,
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
          onTap: () async{
            await AuthController.getToken().then((uid){
              Get.to(() => ProfileScreen(uid: uid,));
            });
          },
          child: const CircleAvatar(
            foregroundImage: NetworkImage(
              'https://as2.ftcdn.net/v2/jpg/03/26/98/51/1000_F_326985142_1aaKcEjMQW6ULp6oI9MYuv8lN9f8sFmj.jpg',
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
              Icons.logout,
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
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height*0.19,
        child: GetBuilder<PostController>(
          builder: (ctrl) {
            return Visibility(
              visible: !ctrl.inProgress,
              replacement: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: AppColors.accentColor,
                  size: 20,),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: ctrl.postList.length+1,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 4,
                      top: 0,
                      right: 4,
                      bottom: 0,
                    ),
                    child: Container(
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
                                  index==0?ctrl.postList[index].postedByProfilePic:ctrl.postList[index-1].attachment,
                                  fit: BoxFit.cover,
                                  height: MediaQuery.sizeOf(context).height*0.16,
                                  width: 120,
                                ),
                              ),
                              if (index == 0)
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
                              Visibility(
                                visible: index!=0,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 6,
                                    left: 4,
                                    right: 1,
                                  ),
                                  child: ButtonAvatar(
                                    onTap: () {},
                                    child: CircleAvatar(
                                      foregroundImage: NetworkImage(
                                        ctrl.postList[index==0?0:index-1].postedByProfilePic,
                                      ),
                                    ),
                                  ),
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
            );
          }
        ),
      ),
    );
  }

  Widget buildUserDetails(TextTheme textTheme) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height*0.6,
      child: GetBuilder<PostController>(
        builder: (ctrl) {
          return Visibility(
            visible: !ctrl.inProgress,
            replacement: LoadingAnimationWidget.staggeredDotsWave(
              color: AppColors.accentColor,
              size: 50,
            ),
            child: ListView.builder(
              //physics: NeverScrollableScrollPhysics(),
              controller: sharedScrollController,
              itemCount: ctrl.postList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 10,
                  ),
                  child: CustomizeBox(
                    //height: MediaQuery.sizeOf(context).height*0.6,
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
                                child: CircleAvatar(
                                  foregroundImage: NetworkImage(
                                    ctrl.postList[index].postedByProfilePic,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TextRich(
                                textTheme: textTheme,
                                title: '${ctrl.postList[index].postedByName}\n',
                                subTitle: '@${ctrl.postList[index].postedByUsername}',
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(ctrl.postList[index].caption),
                        ),
                        Card(
                          child: Image.network(
                            ctrl.postList[index].attachment,
                          ),
                        ),
                        buildFavCommentButton(textTheme,index),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      ),
    );
  }

 // Widget buildIMenuBar(BuildContext context, TextTheme textTheme) {
 //    return ButtonIconBar(
 //                        icon: const Icon(Icons.keyboard_arrow_down),
 //                        onTap: () {
 //                          showMenu(
 //                            context: context,
 //                            position: const RelativeRect.fromLTRB(100,300,20,0),
 //                            items: [
 //                              PopupMenuItem(
 //                                child: ListTile(
 //                                  leading: const Icon(Icons.delete),
 //                                  title: Text('Delete',
 //                                      style: textTheme.titleMedium),
 //                                  onTap: () {
 //                                    ScaffoldMessenger.of(context)
 //                                        .showSnackBar(
 //                                      const SnackBar(
 //                                          content:
 //                                              Text('Delete action pressed!')),
 //                                    );
 //                                    Navigator.pop(context); // Close the menu
 //                                  },
 //                                ),
 //                              ),
 //                              PopupMenuItem(
 //                                child: ListTile(
 //                                  leading: const Icon(Icons.edit_note_sharp),
 //                                  title: Text('Edit',
 //                                      style: textTheme.titleMedium),
 //                                  onTap: () {
 //                                    ScaffoldMessenger.of(context)
 //                                        .showSnackBar(
 //                                      const SnackBar(
 //                                          content:
 //                                              Text('Edit action pressed!')),
 //                                    );
 //                                    Navigator.pop(context); // Close the menu
 //                                  },
 //                                ),
 //                              ),
 //                            ],
 //                          );
 //                        },
 //                      );
 //  }

  Widget buildFavCommentButton(TextTheme textTheme,int index) {
    return GetBuilder<PostController>(
      builder: (ctrl) {
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
                  builder: (context) => buildCommentBar(textTheme, context,index),
                );
              },
              icon: Row(
                children: [
                  const Icon(Icons.comment_outlined),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(ctrl.postList[index].comments.length.toString()),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text('Comments',),
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
    );
  }

  Widget buildCommentBar(TextTheme textTheme, BuildContext context,int postIndex) {
    return GetBuilder<PostController>(
      builder: (ctrl) {
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
                //height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                  itemCount: ctrl.postList[postIndex].comments.length,
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
                                    CircleAvatar(
                                      foregroundImage: NetworkImage(
                                        ctrl.postList[postIndex].comments[index].commentedByProfilePic,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width*0.7,
                                      child: TextRich(
                                        textTheme: textTheme,
                                        title: ctrl.postList[postIndex].comments[index].commentedByName,
                                        subTitle: '   ${timeago.format(ctrl.postList[postIndex].comments[index].commentTime)}\n',
                                        commentText:
                                        ctrl.postList[postIndex].comments[index].comment,
                                      ),
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
    );
  }
}
