import 'package:dreamfarm/Model/UserData.dart';
import 'package:dreamfarm/screens/Community/UserTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textEditingController = TextEditingController();
  List<User> filteredUser = users;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (e) {
                  setState(() {
                    filteredUser = users.where((user) {
                      return user.userName
                          .toLowerCase()
                          .contains(e.toLowerCase());
                    }).toList();
                  });
                },
                controller: textEditingController,
                style: GoogleFonts.roboto(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: "Search Farmers...",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.all(8.h),
                  child: Column(
                    children: [
                      if (filteredUser.length != 0)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: filteredUser.length,
                          itemBuilder: (BuildContext context, int index) {
                            return UserTile(user: filteredUser[index]);
                          },
                        )
                      else
                        Container(
                          margin: EdgeInsets.only(top: 100.h),
                          child: Center(
                            child: Text(
                              "Sorry, no users found !",
                              style: GoogleFonts.roboto(
                                color: Colors.grey,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        
      ),
    );
  }
}
