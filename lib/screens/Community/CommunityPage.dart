import 'dart:convert';

import 'package:dreamfarm/Model/CommunityScreenData.dart';
import 'package:dreamfarm/Model/ProductModel.dart';
import 'package:dreamfarm/screens/Community/Posts.dart';
import 'package:dreamfarm/services/launchUrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  List<PostModel> allPosts = [];
  Future<void> fetchAllPosts() async {
    final response =
        await http.get(Uri.parse("http://10.0.2.2:8000/community"));
    if (response.statusCode == 200) {
      List<dynamic> respBody = jsonDecode(response.body);
      List<PostModel> data = [];
      respBody.forEach((element) {
        data.add(PostModel(
            postImageUrl: element["img"],
            profileImageUrl: element["title"].contains("Aswin")
                ? "https://images.unsplash.com/profile-fb-1550775635-9ab106b96960.jpg?dpr=1&auto=format&fit=crop&w=150&h=150&q=60&crop=faces&bg=fff"
                : "https://images.unsplash.com/profile-1648828806223-1852f704c58aimage?dpr=1&auto=format&fit=crop&w=150&h=150&q=60&crop=faces&bg=fff",
            accountName: element['title'].contains('Aswin')
                ? "Aswin Raaj P S"
                : "Naveen Patel",
            captions: element['description'],
            isFollowed: false,
            isSaved: false,
            title: element['title'],
            id: 2));
      });
      setState(() {
        allPosts = data;
      });
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    fetchAllPosts();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/search");
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/account");
            },
            icon: Icon(Icons.account_circle_outlined),
          ),
        ],
        centerTitle: true,
        title: Text('DreamFarm'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/addpost");
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (value) => {
          if (value == 1)
            {Navigator.pushNamed(context, "/community")}
          else if (value == 0)
            {Navigator.pushNamed(context, "/")}
          else if (value == 2)
            {Navigator.pushNamed(context, "/marketplace")}
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/community_black.png",
              height: 20,
            ),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'MarketPlace',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              title: Text('Crop Doc'),
              onTap: () {
                Navigator.pushNamed(context, "/cropdoc-input");
                // Implement option 1 functionality here
              },
            ),
            ListTile(
              title: Text('Crop Recommendations'),
              onTap: () {
                Navigator.pushNamed(context, "/recommend");
                // Implement option 1 functionality here
              },
            ),
            ListTile(
              title: Text('Services'),
              onTap: () {
                 makeCall("http://192.168.1.4:8501");
                // Implement option 2 functionality here
              },
            ),
            ListTile(
              title: Text('Job Opportunities'),
              onTap: () {
                Navigator.pushNamed(context, '/skill');
                // Implement option 2 functionality here
              },
            ),
            // ListTile(
            //   title: Text('Therapy'),
            //   onTap: () {
            //     Navigator.pushNamed(context, "/therapy");
            //     // Implement option 1 functionality here
            //   },
            // ),
          ],       ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Posts",
                style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 24.sp),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: allPosts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Post(
                      post: allPosts[index],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
