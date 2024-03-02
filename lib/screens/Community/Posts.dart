import 'package:dreamfarm/Model/CommunityScreenData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Post extends StatefulWidget {
  PostModel post;
 Post({super.key, required this.post});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(5.r)
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image(
              image: NetworkImage(widget.post.postImageUrl),
              height: 200.h,
              width: 329.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(200.r),
                child: Image(
                  image: NetworkImage(widget.post.profileImageUrl),
                  height: 30.h,
                  width: 30.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                widget.post.accountName,
                style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp),
              ),
              SizedBox(
                width: 10.w,
              ),
              !widget.post.isFollowed
                  ? ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust the radius as needed
                            side: const BorderSide(
                              color: Color(0xFF36750B), // Border color
                              width: 2.0, // Border width
                            ),
                          ))),
                      onPressed: () {
                        setState(() {
                          widget.post.isFollowed = !widget.post.isFollowed;
                        });
                      },
                      child: const Text("Follow"))
                  : ElevatedButton(
                      onPressed: () {
                        setState(() {
                          widget.post.isFollowed = !widget.post.isFollowed;
                        });
                      },
                      child: const Text("Followed")),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    setState(() {
                      widget.post.isSaved = !widget.post.isSaved;
                    });
                  },
                  icon: widget.post.isSaved
                      ? const Icon(
                          Icons.bookmark_rounded,
                          color: Colors.green,
                        )
                      : const Icon(
                          Icons.bookmark_border_rounded,
                          color: Colors.green,
                        ))
            ],
          ),
          SizedBox(
            width: 315.w,
            child: Text(widget.post.title,
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
          SizedBox(
            width: 315.w,
            child: Text(widget.post.captions,
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 11.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
