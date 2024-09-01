import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/presentation/controllers/bottom_nav_controller.dart';
import 'package:social_media_app/presentation/utils/app_colors.dart';

import '../controllers/auth_shared_pref.dart';
import '../controllers/posts_controller.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    super.initState();
    //Get.find<PostController>().fetchPosts();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
      builder: (ctrl) {
        return Scaffold(
          body: ctrl.screens[ctrl.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)async{
              ctrl.setSelectedIndex(index);
            },
            currentIndex: ctrl.selectedIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: AppColors.accentColor,
            unselectedItemColor: Colors.black,
            iconSize: 28,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: '',
              ),
            ],
          ),
        );
      }
    );
  }
}
