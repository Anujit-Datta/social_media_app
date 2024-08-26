import 'package:flutter/material.dart';
import 'package:flutter_dynamic_staggered_grid_view/flutter_dynamic_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:social_media_app/presentation/controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key,required this.uid});

  final String uid;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
    Get.find<ProfileController>().fetchProfileInfo(uid: widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    Size sizes = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: Get.find<ProfileController>().isSelfProfile,
        title: GetBuilder<ProfileController>(
          builder: (ctrl) {
            return Text(
              ctrl.isSelfProfile?'Profile':ctrl.user.name,
              style: Theme.of(context).textTheme.titleLarge,
            );
          }
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: sizes.height * 0.17,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: sizes.height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  profilePicture(sizes),
                  Visibility(
                    visible: true,
                    replacement: otherProfileSection(context, sizes,),
                    child: selfProfileInfo(context, sizes),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: sizes.height * 0.012,
            color: Colors.black12,
          ),
          SizedBox(
            height: sizes.height * 0.698,
            width: sizes.width,
            child: uploadsSection(sizes, context),
          ),
        ],
      ),
    );
  }

  Padding uploadsSection(Size sizes, BuildContext context) {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: sizes.height*0.01,),
                Text(
                  'Uploads',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Divider(),
                Expanded(
                  child: GetBuilder<ProfileController>(
                    builder: (controller) {
                      return StaggeredGridView.countBuilder(
                        staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        itemCount: controller.user.posts.length,
                        itemBuilder: (context,index) => ClipRRect(
                          borderRadius: BorderRadius.circular(15), // Set your desired corner radius
                          child: Image.network(
                            controller.user.posts[index],
                            fit: BoxFit.cover, // Adjust as needed (cover, contain, etc.)
                          ),
                        ),

                      );
                    }
                  ),
                )
              ],
            ),
          );
  }

  Widget selfProfileInfo(BuildContext context, Size sizes) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: GetBuilder<ProfileController>(
        builder: (ctrl) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ctrl.user.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: sizes.height * 0.002,
              ),
              Text(
                '@${ctrl.user.username}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Spacer(),
              postAndFollowCount(context,sizes),
            ],
          );
        }
      ),
    );
  }

  Widget otherProfileSection(BuildContext context, Size sizes,) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        postAndFollowCount(context,sizes),
        GetBuilder<ProfileController>(
          builder: (ctrl) {
            return Text(
              '@${ctrl.user.username}',
              style: Theme.of(context).textTheme.bodySmall,
            );
          }
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: SizedBox(
            height: sizes.height*0.035,
            child: Row(
              children: [
                MaterialButton(
                  onPressed: (){},
                  color: Colors.grey.shade400,
                  child: Text(
                    'Follow',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                SizedBox(width: sizes.width*0.03,),
                MaterialButton(
                  onPressed: (){},
                  color: Colors.grey.shade400,
                  child: Text(
                    'Message',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }

  Widget postAndFollowCount(BuildContext context, Size sizes,) {
    return GetBuilder<ProfileController>(
      builder: (ctrl) {
        return Row(
            children: [
              Text(
                ctrl.user.postCount.toString(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                ' Post',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: sizes.width * 0.015,
                ),
              ),
              Text(
                ctrl.user.followerCount.toString(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                ' Follower',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: sizes.width * 0.015,
                ),
              ),
              Text(
                ctrl.user.followingCount.toString(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                ' Following',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          );
      }
    );
  }

  Widget profilePicture(Size sizes) {
    return GetBuilder<ProfileController>(
      builder: (ctrl) {
        return CircleAvatar(
          radius: sizes.height * 0.085,
          backgroundImage: NetworkImage(
            ctrl.user.profilePicture,
          ),
          backgroundColor: Colors.grey.shade400,
          foregroundColor: Colors.transparent,
        );
      }
    );
  }
}
