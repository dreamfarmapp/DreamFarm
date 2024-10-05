import 'dart:convert';
import 'dart:math';

import 'package:dreamfarm/Model/ProductModel.dart';
import 'package:dreamfarm/screens/MarketPlace/product_card.dart';
import 'package:dreamfarm/services/launchUrl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class MarketplaceScreen extends StatefulWidget {
  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  List<ProductModel> allProducts = [];
  bool isRent = true;
  TextEditingController controller = TextEditingController();
  List<ProductModel> filteredProducts = [];

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const R = 6371; // Radius of Earth in kilometers
  double dLat = (lat2 - lat1) * (pi / 180);
  double dLon = (lon2 - lon1) * (pi / 180);

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1 * (pi / 180)) * cos(lat2 * (pi / 180)) *
      sin(dLon / 2) * sin(dLon / 2);

  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return R * c; // Distance in kilometers
}

  //Toggle Options
  void showRent() {
    List<ProductModel> newProd =
        allProducts.where((e) => e.type == "Rent").toList();
    setState(() {
      isRent = true;
      filteredProducts = newProd;
    });
  }

  void showBuy() {
    List<ProductModel> newProd =
        allProducts.where((e) => e.type == "Buy").toList();
    setState(() {
      isRent = false;
      filteredProducts = newProd;
    });
  }

  // Add a list of predefined random locations with their latitudes and longitudes
  List<Map<String, dynamic>> randomLocations = [
    {'location': 'Chennai', 'lat': 13.0827, 'lon': 80.2707},
    {'location': 'Trichy', 'lat': 10.7905, 'lon': 78.7047},
    {'location': 'Telangana', 'lat': 17.1232, 'lon': 79.2088},
    {'location': 'Coimbatore', 'lat': 11.0168, 'lon': 76.9558},
  ];

  Future<void> fetchAllProducts() async {
    print("Fetching products...");
    final response =
        await http.get(Uri.parse("http://10.0.2.2:8000/marketplace/"));
    if (response.statusCode == 200) {
      List<ProductModel> data = [];
      List<dynamic> respBody = jsonDecode(response.body);
      print("Response body: $respBody");

      Random random = Random();

      // Coimbatore coordinates
      double coimbatoreLat = 11.0168;
      double coimbatoreLon = 76.9558;

      respBody.forEach((element) {
        // Assign a random location from Chennai, Trichy, Telangana, or Coimbatore
        Map<String, dynamic> randomLocation =
            randomLocations[random.nextInt(randomLocations.length)];

        data.add(ProductModel(
          productName: element['title'],
          productPrice: element['price'].toString(),
          imageUrl: element['img'],
          id: 1,
          duration: element['duration'] == 0
              ? element['duration'].toString()
              : 0.toString(),
          ownerLocation: randomLocation['location'], // Random location
          ownerName: "Aswin Raaj P S",
          ownerNumber: "9568812345",
          productDescription: element['description'],
          type: element['type'],
          ownerLocationLat: randomLocation['lat'], // Latitude
          ownerLocationLon: randomLocation['lon'], // Longitude
        ));
      });

      // Sort products by distance from Coimbatore
      data.sort((a, b) {
        double distA = calculateDistance(coimbatoreLat, coimbatoreLon,
            a.ownerLocationLat!, a.ownerLocationLon!);
        double distB = calculateDistance(coimbatoreLat, coimbatoreLon,
            b.ownerLocationLat!, b.ownerLocationLon!);
        return distA.compareTo(distB);
      });

      setState(() {
        allProducts = data;
        filteredProducts =
            data.where((e) => e.type == (isRent ? "Rent" : "Buy")).toList();
      });

      print("Products fetched and sorted successfully.");
    } else {
      print("Failed to fetch products: ${response.statusCode}");
    }
  }

  void handleSearch() {
    List<ProductModel> newProd = allProducts
        .where((element) =>
            element.productName.contains(controller.text) &&
            (element.type == (isRent ? "Rent" : "Buy")))
        .toList();
    setState(() {
      filteredProducts = newProd;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[200],
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextField(
                controller: controller,
                onChanged: (value) => handleSearch(),
                decoration: InputDecoration(
                  hintText: "Search Products",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: isRent ? Colors.green[200] : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: MaterialButton(
                      onPressed: () => showRent(),
                      child: Center(
                        child: Text(
                          "Rent",
                          style: GoogleFonts.lexend(
                            fontSize: 18,
                            fontWeight:
                                isRent ? FontWeight.bold : FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: !isRent ? Colors.green[200] : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: MaterialButton(
                      onPressed: () => showBuy(),
                      child: Center(
                        child: Text(
                          "Buy",
                          style: GoogleFonts.lexend(
                            fontSize: 18,
                            fontWeight:
                                !isRent ? FontWeight.bold : FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: filteredProducts.length,
              itemBuilder: (BuildContext context, int index) {
                print("Index: $index");
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: ProductCard(product: filteredProducts[index]),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/addproduct");
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
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
          ],
        ),
      ),
    );
  }
}
