import 'package:dreamfarm/Model/ServiceModel.dart';
import 'package:dreamfarm/screens/Networks/service_card.dart';
import 'package:dreamfarm/services/launchUrl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NetworksScreen extends StatefulWidget {
  const NetworksScreen({super.key});

  @override
  State<NetworksScreen> createState() => _NetworksScreenState();
}

List<ServiceModel> allservices = [
  ServiceModel(
      title: "Soil Testing facility", phoneNumber: "9638527410", distance: 25),
  ServiceModel(
      title: "Soil Testing facility 1",
      phoneNumber: "9638527410",
      distance: 20),
  ServiceModel(
      title: "Soil Testing facility 2",
      phoneNumber: "9638527410",
      distance: 15),
  ServiceModel(
      title: "Soil Testing facility 3",
      phoneNumber: "9638527410",
      distance: 10),
];

class _NetworksScreenState extends State<NetworksScreen> {
  TextEditingController controller = TextEditingController();
  bool isCustomLocation = false;
  int distance = 10;
  List<ServiceModel> filteredServices = allservices;
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
              isCustomLocation
                  ? Row(
                      children: [
                        SizedBox(
                          width: 270,
                          child: TextField(
                            style: GoogleFonts.lexend(color: Colors.black),
                            controller: controller,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter Location",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 10),
                                prefixIcon: IconButton(
                                    onPressed: () => {
                                          setState(() {
                                            isCustomLocation = false;
                                          })
                                        },
                                    icon: Icon(Icons.gps_fixed))),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFF80E51A)),
                          child: MaterialButton(
                            onPressed: () {},
                            child: Center(
                              child: Text(
                                "Submit",
                                style: GoogleFonts.lexend(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isCustomLocation = true;
                              });
                            },
                            icon: Icon(Icons.gps_fixed)),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Using Current GPS Location...",
                          style: GoogleFonts.lexend(
                              fontSize: 16, color: Colors.black),
                        )
                      ],
                    ),
              // Generated code for this Slider Widget...
              Text(
                "Distance : ${distance}",
                style: GoogleFonts.lexend(color: Colors.black, fontSize: 16),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                child: Slider(
                  min: 1,
                  max: 20,
                  value: distance.toDouble(),
                  onChanged: (newValue) {
                    newValue = double.parse(newValue.toStringAsFixed(2));
                    List<ServiceModel> services = allservices
                        .where(
                          (element) => element.distance <= newValue,
                        )
                        .toList();
                    setState(() {
                      distance = newValue.toInt();

                      filteredServices = services;
                    });
                  },
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredServices.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return ServiceCard(service: filteredServices[index]);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
