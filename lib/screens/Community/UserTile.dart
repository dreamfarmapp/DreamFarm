import 'package:dreamfarm/Model/UserData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UserTile extends StatefulWidget {
  User user;
  UserTile({super.key, required this.user});

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  bool isFollowed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/userprofile', arguments: widget.user);
        },
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: Image(
                    image: NetworkImage(widget.user.profileImageUrl),
                    height: 40.h,
                    width: 40.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  widget.user.userName,
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500),
                ),
                Spacer(),
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
                          });
                        },
                        child: const Text("Follow"))
                    : ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isFollowed = !isFollowed;
                          });
                        },
                        child: const Text("Followed")),
                SizedBox(
                  width: 10.w,
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Divider(
              color: Colors.grey.withOpacity(0.75),
            )
          ],
        ),
      ),
    );
  }
}
