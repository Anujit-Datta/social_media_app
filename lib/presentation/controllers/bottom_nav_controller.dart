import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media_app/presentation/controllers/posts_controller.dart';
import 'package:social_media_app/presentation/screens/add_post_screen.dart';
import 'package:social_media_app/presentation/screens/live_home_screen.dart';
import 'package:social_media_app/presentation/screens/profile_screen.dart';
import 'package:social_media_app/presentation/screens/search_screen.dart';
import 'package:social_media_app/presentation/utils/app_colors.dart';

class BottomNavController extends GetxController{
  int _selectedIndex=0;
  List screens=[
    const LiveHomeScreen(),
    const SearchScreen(),
    const AddPostScreen(),
    const ProfileScreen(),
  ];

  int get selectedIndex => _selectedIndex;

  set selectedIndexSetter(int index){
    _selectedIndex=index;
    update();
  }

  setSelectedIndex(int index)async{

    _selectedIndex=index;
    update();
  }

}