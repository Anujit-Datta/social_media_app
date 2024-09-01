import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media_app/data/models/user_model.dart';
import 'package:social_media_app/presentation/controllers/auth_shared_pref.dart';
import 'package:social_media_app/presentation/screens/profile_screen.dart';
import 'package:social_media_app/presentation/utils/constants.dart';

import '../utils/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchTEController = TextEditingController();
  String _searchText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16,right: 16,top: 20),
          child: Column(
            children: [
              TextField(
                controller: _searchTEController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (value){
                  setState(() {
                    _searchText = value;
                  });
                },
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance.collection('User').where('name',isGreaterThanOrEqualTo: _searchText).where('name', isLessThanOrEqualTo: _searchText + '\uf8ff').where('uid',isNotEqualTo: AuthController.accessToken).snapshots(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: snapshot.data?.docs.length??0,
                      itemBuilder: (context, index) {
                        UserModel user = UserModel.fromJson(snapshot.data!.docs[index].data());
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Center(
                            child: LoadingAnimationWidget.staggeredDotsWave(
                              color: AppColors.accentColor,
                              size: 50,
                            ),
                          );
                        }else if(snapshot.hasError){
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        }else{
                          return InkWell(
                            onTap: (){
                              Get.to(()=>ProfileScreen(uid: user.uid,));
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 23,
                                foregroundImage: NetworkImage(user.profilePicture==''?Constants.profileImage:user.profilePicture),
                              ),
                              title: Text(user.name),
                              subtitle: Text('@${user.username}'),

                            ),
                          );
                        }
                      },
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
