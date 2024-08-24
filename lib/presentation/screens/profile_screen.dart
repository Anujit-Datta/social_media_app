import 'package:flutter/material.dart';
import 'package:flutter_dynamic_staggered_grid_view/flutter_dynamic_staggered_grid_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size sizes = MediaQuery.sizeOf(context);
    List images=[
      'https://firebasestorage.googleapis.com/v0/b/ostad-works.appspot.com/o/photogrid%2F10.jpeg?alt=media&token=92ab69b5-8f7c-456f-a3bf-379da56d6273',
      'https://firebasestorage.googleapis.com/v0/b/ostad-works.appspot.com/o/photogrid%2F11.jpeg?alt=media&token=f991f7cf-dcca-4ba4-b48e-394e1dde4cd8',
      'https://firebasestorage.googleapis.com/v0/b/ostad-works.appspot.com/o/photogrid%2F6.jpeg?alt=media&token=8f8d9355-dbc6-4790-bd5c-86f1cfe8697a',
      'https://firebasestorage.googleapis.com/v0/b/ostad-works.appspot.com/o/photogrid%2F8.jpeg?alt=media&token=e9cb3fcf-b0bd-4581-abb5-9f795f2f30d8',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjmA6IFd3Ps4DYnSNRHo8hLNm1wIPBqWV2-Q&s',
      'https://firebasestorage.googleapis.com/v0/b/ostad-works.appspot.com/o/photogrid%2F10.jpeg?alt=media&token=92ab69b5-8f7c-456f-a3bf-379da56d6273',
      'https://firebasestorage.googleapis.com/v0/b/ostad-works.appspot.com/o/photogrid%2F11.jpeg?alt=media&token=f991f7cf-dcca-4ba4-b48e-394e1dde4cd8',
      'https://firebasestorage.googleapis.com/v0/b/ostad-works.appspot.com/o/photogrid%2F6.jpeg?alt=media&token=8f8d9355-dbc6-4790-bd5c-86f1cfe8697a',
      'https://firebasestorage.googleapis.com/v0/b/ostad-works.appspot.com/o/photogrid%2F8.jpeg?alt=media&token=e9cb3fcf-b0bd-4581-abb5-9f795f2f30d8',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjmA6IFd3Ps4DYnSNRHo8hLNm1wIPBqWV2-Q&s',
      'https://firebasestorage.googleapis.com/v0/b/ostad-works.appspot.com/o/photogrid%2F10.jpeg?alt=media&token=92ab69b5-8f7c-456f-a3bf-379da56d6273',
      'https://firebasestorage.googleapis.com/v0/b/ostad-works.appspot.com/o/photogrid%2F11.jpeg?alt=media&token=f991f7cf-dcca-4ba4-b48e-394e1dde4cd8',
      'https://firebasestorage.googleapis.com/v0/b/ostad-works.appspot.com/o/photogrid%2F6.jpeg?alt=media&token=8f8d9355-dbc6-4790-bd5c-86f1cfe8697a',
      'https://firebasestorage.googleapis.com/v0/b/ostad-works.appspot.com/o/photogrid%2F8.jpeg?alt=media&token=e9cb3fcf-b0bd-4581-abb5-9f795f2f30d8',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjmA6IFd3Ps4DYnSNRHo8hLNm1wIPBqWV2-Q&s',
      'https://firebasestorage.googleapis.com/v0/b/ostad-works.appspot.com/o/photogrid%2F10.jpeg?alt=media&token=92ab69b5-8f7c-456f-a3bf-379da56d6273',
      'https://firebasestorage.googleapis.com/v0/b/ostad-works.appspot.com/o/photogrid%2F11.jpeg?alt=media&token=f991f7cf-dcca-4ba4-b48e-394e1dde4cd8',
      'https://firebasestorage.googleapis.com/v0/b/ostad-works.appspot.com/o/photogrid%2F6.jpeg?alt=media&token=8f8d9355-dbc6-4790-bd5c-86f1cfe8697a',
      'https://firebasestorage.googleapis.com/v0/b/ostad-works.appspot.com/o/photogrid%2F8.jpeg?alt=media&token=e9cb3fcf-b0bd-4581-abb5-9f795f2f30d8',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjmA6IFd3Ps4DYnSNRHo8hLNm1wIPBqWV2-Q&s',
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          true?'Profile':'name',
          style: Theme.of(context).textTheme.titleLarge,
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
                    replacement: otherProfileSection(context, sizes),
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
            child: uploadsSection(sizes, context, images),
          ),
        ],
      ),
    );
  }

  Padding uploadsSection(Size sizes, BuildContext context, List<dynamic> images) {
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
                  child: StaggeredGridView.countBuilder(
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    itemCount: images.length,
                    itemBuilder: (context,index) => ClipRRect(
                      borderRadius: BorderRadius.circular(15), // Set your desired corner radius
                      child: Image.network(
                        images[index],
                        fit: BoxFit.cover, // Adjust as needed (cover, contain, etc.)
                      ),
                    ),

                  ),
                )
              ],
            ),
          );
  }





  Widget selfProfileInfo(BuildContext context, Size sizes) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: sizes.height * 0.002,
          ),
          Text(
            '@username',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Spacer(),
          postAndFollowCount(context: context,sizes: sizes,postCount: 0,followerCount: 0,followingCount: 0,),
        ],
      ),
    );
  }

  Widget otherProfileSection(BuildContext context, Size sizes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        postAndFollowCount(context: context,sizes: sizes,postCount: 0,followerCount: 0,followingCount: 0,),
        Text(
          '@username',
          style: Theme.of(context).textTheme.bodySmall,
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

  Row postAndFollowCount(
      {required BuildContext context,
      required Size sizes,
      required int postCount,
      required int followerCount,
      required int followingCount}) {
    return Row(
        children: [
          Text(
            postCount.toString(),
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
            followerCount.toString(),
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
            followingCount.toString(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Text(
            ' Following',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      );
  }


  Widget profilePicture(Size sizes) {
    return CircleAvatar(
      radius: sizes.height * 0.085,
      backgroundImage: const AssetImage(
        'assets/profile_avater.jpg',
      ),
      backgroundColor: Colors.grey.shade400,
      foregroundColor: Colors.transparent,
    );
  }
}
