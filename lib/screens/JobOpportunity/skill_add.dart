import 'package:dreamfarm/services/launchUrl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillAddScreen extends StatefulWidget {
  const SkillAddScreen({super.key});

  @override
  State<SkillAddScreen> createState() => _SkillAddScreenState();
}

class _SkillAddScreenState extends State<SkillAddScreen> {
  List<String> skillList = [];
  TextEditingController controller = TextEditingController();

  void handleSearch() {
    if (skillList.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Add at least one skill")));
    } else {
      Navigator.pushNamed(context, "/job",arguments: skillList);
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
          ],       ),
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
                Row(
                  children: [
                    SizedBox(
                      width: 270,
                      child: TextField(
                          style: GoogleFonts.lexend(color: Colors.black),
                          controller: controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter a skill",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 10),
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFF80E51A)),
                      child: MaterialButton(
                        onPressed: () {
                          if (controller.text.isNotEmpty) {
                            setState(() {
                              skillList.add(controller.text);
                            });
                            controller.text = "";
                            print(skillList.length);
                          }
                        },
                        child: Center(
                          child: Text(
                            "Add",
                            style: GoogleFonts.lexend(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Wrap(
                  children: skillList
                      .map((skill) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            child: Chip(
                              label: Text(skill),
                              onDeleted: () {
                                setState(() {
                                  skillList.remove(skill);
                                });
                              },
                            ),
                          ))
                      .toList(),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 48,
                  width: 358,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFF80E51A)),
                  child: MaterialButton(
                    onPressed: () => handleSearch(),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: GoogleFonts.lexend(
                            color: const Color(0xFF141C0D),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
