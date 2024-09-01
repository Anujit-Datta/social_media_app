import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media_app/presentation/controllers/comment_controller.dart';
import 'package:social_media_app/presentation/controllers/login_controller.dart';
import 'package:social_media_app/presentation/controllers/posts_controller.dart';
import 'package:social_media_app/presentation/screens/profile_screen.dart';
import 'package:social_media_app/presentation/utils/app_colors.dart';
import '../widgets/button_avatar.dart';
import '../widgets/button_bar.dart';
import '../widgets/common_appbar.dart';
import '../widgets/customize_box.dart';
import '../widgets/text_rich.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;


class LiveHomeScreen extends StatefulWidget {
  const LiveHomeScreen({super.key});

  @override
  State<LiveHomeScreen> createState() => _LiveHomeScreenState();
}

class _LiveHomeScreenState extends State<LiveHomeScreen> {
  bool _isFavoriteIconChecked = false;
  ScrollController sharedScrollController = ScrollController();
  final TextEditingController _commentTEController = TextEditingController();

  void favoriteUpdate() {
    setState(() {
      _isFavoriteIconChecked = !_isFavoriteIconChecked;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('Build Started');
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: commonAppBar(),
      body: GetBuilder<PostController>(
        builder: (ctrl) {
          return RefreshIndicator(
            onRefresh: ()async{
              ctrl.fetchPosts();
            },
            child: Visibility(
              visible: !ctrl.inProgress,
              replacement: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: AppColors.accentColor,
                  size: 50,
                ),
              ),
              child: SingleChildScrollView(
                controller: sharedScrollController,
                child: Column(
                  children: [
                    buildStoryList(),
                    buildUserDetails(textTheme),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }


  Widget buildStoryList() {
    return GetBuilder<PostController>(
      builder: (ctrl) {
        return GetBuilder<LoginController>(
          builder: (loginCtrl) {
            return Visibility(
              visible: !ctrl.inProgress && !loginCtrl.inProgress,
              replacement: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: AppColors.accentColor,
                  size: 20,),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height*0.19,
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
                                    child: GetBuilder<LoginController>(
                                      builder: (loginController) {
                                        return Visibility(
                                          visible: !(loginController.selfProfile?.profilePicture=='' && index==0),
                                          replacement: Image.asset(
                                            'assets/profile_avater.jpg',
                                            fit: BoxFit.cover,
                                            height: MediaQuery.sizeOf(context).height*0.16,
                                            width: 120,
                                          ),
                                          child: Image.network(
                                            index==0?loginController.selfProfile?.profilePicture??'':ctrl.postList[index-1].attachment,
                                            fit: BoxFit.cover,
                                            height: MediaQuery.sizeOf(context).height*0.16,
                                            width: 120,
                                          ),
                                        );
                                      }
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
                ),
              ),
            );
          }
        );
      }
    );
  }

  Widget buildUserDetails(TextTheme textTheme) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height*0.6,
      child: GetBuilder<PostController>(
        builder: (ctrl) {
          return GetBuilder<LoginController>(
            builder: (loginCtrl) {
              return Visibility(
                visible: !ctrl.inProgress && !loginCtrl.inProgress,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ButtonAvatar(
                                    onTap: () {
                                      Get.to(()=>ProfileScreen(uid: ctrl.postList[index].postedBy,));
                                    },
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
                                  Visibility(
                                    visible: ctrl.postList[index].isProfilePicture,
                                    child: const Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: Text('updated Profile Picture'),
                                    ),
                                  )
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
                ctrl.postList[index].isLikedByMe ? Icons.favorite : Icons.favorite_border,
                color: ctrl.postList[index].isLikedByMe ? Colors.redAccent:null,
              ),
              onTap: () {
                ctrl.likeTap(index: index);
              },
            ),
            ButtonIconBar(
              onTap: () {
                if(!(Get.find<CommentController>().commentsList.isNotEmpty && Get.find<CommentController>().commentsList[0].postId==ctrl.postList[index].id)){
                Get.find<CommentController>()
                    .fetchCommentsList(ctrl.postList[index].id!);
              }
              log(ctrl.postList[index].id!);
                showModalBottomSheet(
                  context: context,
                  builder: (context) => buildCommentBar(textTheme, context,index),
                );
              },
              icon: const Row(
                children: [
                  Icon(Icons.comment_outlined),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Comments',),
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
    return GetBuilder<CommentController>(
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
            Visibility(
              visible: !ctrl.inProgress,
              replacement: Expanded(
                child: Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: AppColors.accentColor,
                    size: 30,
                  ),
                ),
              ),
              child: Expanded(
                child: CustomizeBox(
                  //height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView.builder(
                    itemCount: ctrl.commentsList.length,
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
                                          ctrl.commentsList[index].commentedByProfilePic,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: MediaQuery.sizeOf(context).width*0.7,
                                        child: TextRich(
                                          textTheme: textTheme,
                                          title: ctrl.commentsList[index].commentedByName,
                                          subTitle: '   ${timeago.format(ctrl.commentsList[index].commentTime)}\n',
                                          commentText:
                                          ctrl.commentsList[index].comment,
                                        ),
                                      ),
                                      const Spacer(),
                                      ButtonIconBar(
                                        icon: Icon(
                                          ctrl.commentsList[index].likedByMe
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: ctrl.commentsList[index].likedByMe?Colors.redAccent:null,
                                        ),
                                        onTap: () {
                                          ctrl.likeTap(index: index);
                                        },
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
            ),
            TextFormField(
              controller: _commentTEController,
              decoration: InputDecoration(
                hintText: 'Add Comment',
                hintStyle: textTheme.bodySmall,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    foregroundImage: NetworkImage(
                      Get.find<LoginController>().selfProfile!.profilePicture,
                    ),
                  ),
                ),
                suffixIcon: TextButton(
                  onPressed: () {
                    Get.find<CommentController>().addComment(
                      Get.find<PostController>().postList[postIndex].id!,
                      _commentTEController.text.trim(),
                    );
                    _commentTEController.clear();
                  },
                  child: Icon(
                    Icons.send,
                    color: AppColors.accentColor,
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
