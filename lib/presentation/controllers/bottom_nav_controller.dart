import 'package:get/get.dart';
import 'package:social_media_app/presentation/screens/live_add_screen.dart';
import 'package:social_media_app/presentation/screens/live_home_screen.dart';
import 'package:social_media_app/presentation/screens/profile_screen.dart';

class BottomNavController extends GetxController{
  int _selectedIndex=0;
  List screens=[
    const LiveHomeScreen(),
    const LiveHomeScreen(),
    const LiveAddScreen(),
    const ProfileScreen(uid: "Ggv6C6rP28dDagGyeRwiX5L2K2F2"),
  ];

  get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index){
    _selectedIndex=index;
    update();
  }

}