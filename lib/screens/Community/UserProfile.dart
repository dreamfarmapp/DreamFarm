import 'package:dreamfarm/Model/CommunityScreenData.dart';
import 'package:dreamfarm/Model/UserData.dart';
import 'package:dreamfarm/screens/Community/Posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Model/HomeScreenData.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool isFollowed = false;

  @override
  Widget build(BuildContext context) {
    final userData = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDBF5E0),
        title: Text(
          "DreamFarm",
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 24.sp),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.r),
              child: const Image(image: NetworkImage(profilePic)),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 60.h,
        decoration: BoxDecoration(color: const Color(0xFFDBF5E0), boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 8)
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/icons/home_black.png",
                    height: 20.h,
                  ),
                  Text("Home",
                      style: GoogleFonts.roboto(
                          color: Colors.black, fontSize: 12.sp))
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/icons/community_green.png",
                  height: 20.h,
                ),
                Text("Community",
                    style: GoogleFonts.roboto(
                        color: Colors.black, fontSize: 12.sp))
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/cropdoc-input');
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/icons/cropdoc_black.png",
                    height: 20.h,
                  ),
                  Text("CropDoc",
                      style: GoogleFonts.roboto(
                          color: Colors.black, fontSize: 12.sp))
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/account');
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/icons/profile_black.png",
                    height: 20.h,
                  ),
                  Text("Profile",
                      style: GoogleFonts.roboto(
                          color: Colors.black, fontSize: 12.sp))
                ],
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.r),
              child: Image(
                image: NetworkImage(
                  userData.profileImageUrl,
                ),
                height: 60.h,
                width: 60.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              userData.userName,
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "Posts",
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp),
                    ),
                    Text(
                      userData.noOfPosts.toString(),
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp),
                    )
                  ],
                ),
                SizedBox(width: 15.w),
                Column(
                  children: [
                    Text(
                      "Following",
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp),
                    ),
                    Text(
                      userData.noOfFollowing.toString(),
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp),
                    )
                  ],
                ),
                SizedBox(
                  width: 15.sp,
                ),
                Column(
                  children: [
                    Text(
                      "Followers",
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp),
                    ),
                    Text(
                      userData.noOfFollowers.toString(),
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !isFollowed
                    ? ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Adjust the radius as needed
                              side: const BorderSide(
                                color: Color(0xFF36750B), // Border color
                                width: 2.0, // Border width
                              ),
                            ))),
                        onPressed: () {
                          setState(() {
                            isFollowed = !isFollowed;
                            userData.noOfFollowers += 1;
                          });
                        },
                        child: const Text("Follow"))
                    : ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isFollowed = !isFollowed;
                            userData.noOfFollowers -= 1;
                          });
                        },
                        child: const Text("Followed")),
                SizedBox(
                  width: 15.w,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/chat',
                          arguments: userData);
                    },
                    child: Text("Message"))
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            const Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: 10.h,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: userData.noOfPosts,
                itemBuilder: (BuildContext context, int index) {
                  PostModel post = PostModel(
                      postImageUrl:
                          "https://images.unsplash.com/photo-1605000797499-95a51c5269ae?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2071&q=80",
                      profileImageUrl: userData.profileImageUrl,
                      accountName: userData.userName,
                      captions: "Just started harvesting guys...",
                      isFollowed: false,
                      isSaved: false,
                      id: 101);
                  return Post(post: post);
                })
          ],
        ),
      ))),
    );
  }
}
