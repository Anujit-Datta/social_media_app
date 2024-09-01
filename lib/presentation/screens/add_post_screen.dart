import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media_app/presentation/controllers/add_post_controller.dart';
import 'package:social_media_app/presentation/controllers/bottom_nav_controller.dart';
import 'package:social_media_app/presentation/controllers/image_picker_controller.dart';
import 'package:social_media_app/presentation/utils/app_colors.dart';
import '../widgets/selected_icon_button.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _postTEController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Get.find<ImagePickerController>().clearPickedImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: GetBuilder<AddPostController>(
        builder: (ctrl) {
          return Visibility(
            visible: !ctrl.inProgress,
            replacement: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: AppColors.accentColor,
                  size: 50,
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          captionSection(context),
                          imageSection(context),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: ctrl.isProfilePic,
                          activeColor: AppColors.accentColor,
                          onChanged: (value){
                            ctrl.reverseIsProfilePic();
                          },
                        ),
                        Text(
                          'Upload as Profile Picture',
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  SizedBox captionSection(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.9,
      height: MediaQuery.sizeOf(context).height * 0.15,
      child: TextField(
        controller: _postTEController,
        maxLines: 10,
        style: Theme.of(context).textTheme.labelMedium,
        decoration: InputDecoration(
          hintText: 'Your Caption for the post...',
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
        ),
      ),
    );
  }

  Widget imageSection(BuildContext context) {
    return GetBuilder<ImagePickerController>(
      builder: (ctrl) {
        return InkWell(
          onTap: (){
            if(Get.find<ImagePickerController>().pickedImage==null){
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: SizedBox(
                        height: 220,
                        width: 250,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Text(
                                'Select from',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomIconButtons(
                                  icon: Icons.camera_alt,
                                  text: 'Camera',
                                  onTap: () {
                                    Navigator.pop(context);
                                    ctrl.pickImageFromCamera();
                                  },
                                ),
                                CustomIconButtons(
                                  icon: Icons.photo,
                                  text: 'Gallery',
                                  onTap: () {
                                    Navigator.pop(context);
                                    ctrl.pickImageFromGallery();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
          },
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.9,
            height: MediaQuery.sizeOf(context).width * 0.9,
            child: GetBuilder<ImagePickerController>(
              builder: (ctrl) {
                return Visibility(
                  visible: ctrl.pickedImage==null,
                  replacement: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Image.file(
                          File(ctrl.pickedImage?.path ??''),
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          height: MediaQuery.sizeOf(context).width * 0.9,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Colors.black26, Colors.transparent,Colors.transparent,Colors.transparent],
                            ),
                          ),
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          height: MediaQuery.sizeOf(context).width * 0.9,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            onPressed: (){
                              ctrl.clearPickedImage();
                            },
                            icon: const Icon(Icons.cancel_outlined,size: 30,),
                            color: Colors.black38,
                          ),
                        )
                      ],
                    ),
                  ),
                  child: Card(
                    color: Colors.grey.shade400,
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 50),
                      child: Icon(
                        Icons.add,
                        color: Colors.black45,
                        size: 50,
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
        );
      }
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
          onPressed: () async{
            XFile? image=Get.find<ImagePickerController>().pickedImage;
            if(image!=null){
              await Get.find<AddPostController>().addPost(
                caption: _postTEController.text,
                attachment: image,
                isProfilePic: false,
              );
            }
          },
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
