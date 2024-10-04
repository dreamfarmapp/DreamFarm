import 'dart:convert';

import 'package:dreamfarm/Model/JobModel.dart';
import 'package:dreamfarm/screens/JobOpportunity/job_card.dart';
import 'package:dreamfarm/services/launchUrl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

// List<JobModel> joblist = [
//   JobModel(
//       title: "Software Developer",
//       skills: ["C", "Flutter", "Java"],
//       url: "https://www.google.com"),
//   JobModel(
//       title: "Software Developer",
//       skills: ["C", "Flutter", "Java"],
//       url: "https://www.google.com"),
//   JobModel(
//       title: "Software Developer",
//       skills: ["C", "Flutter", "Java"],
//       url: "https://www.google.com"),
//   JobModel(
//       title: "Software Developer",
//       skills: ["C", "Flutter", "Java"],
//       url: "https://www.google.com"),
// ];

class JobListingScreen extends StatefulWidget {
  JobListingScreen({super.key});

  @override
  State<JobListingScreen> createState() => _JobListingScreenState();
}

class _JobListingScreenState extends State<JobListingScreen> {
  List<String>? skillList;
  List<JobModel> joblist = [];

  Future<void> fetchJob(List<String> skills) async {
    final response = await http.get(Uri.parse(
        "http://10.0.2.2:8001/jobs/?familiar_skills=${skills.join(",")}"));
    if (response.statusCode == 200) {
      List<dynamic> respBody = jsonDecode(response.body);
      List<JobModel> data = [];
      respBody.forEach((element) {
        data.add(JobModel(
            title: element["Company Name"],
            skills: element["Required Skills"],
            url: element["More Info"]));
      });
      setState(() {
        joblist = data;
      });
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (skillList == null) {
      skillList = ModalRoute.of(context)!.settings.arguments as List<String>;
      fetchJob(skillList!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ],    ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(165, 214, 167, 1),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/account");
            },
            icon: Icon(Icons.account_circle_outlined),
          )
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
      bottomNavigationBar: BottomNavigationBar(
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Jobs you seek",
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: joblist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return JobCard(job: joblist[index]);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
