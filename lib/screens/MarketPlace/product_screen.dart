import 'package:dreamfarm/Model/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductModel product = ProductModel(
      productName: "Tractor 1",
      productPrice: "450",
      imageUrl:
          "https://www.csceagri.in/web/image/lead.item/62/image_1920/TRAKSTAR%20531?unique=8f211c5",
      id: 1,
      ownerLocation: "Telungana",
      ownerName: "Ramesh",
      ownerNumber: "1234567890",
      productDescription:
          "The XYZ tractor is a reliable and versatile agricultural machine designed to streamline farm operations and maximize productivity. Built with durability and efficiency in mind, this tractor is suitable for various tasks, including plowing, tilling, planting, and hauling.",
      type: "rent",
      duration: "6 months");

  Future<void> makeCall() async {
    var url = Uri.parse("tel:${product.ownerNumber}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Can't make phone call")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              title: Text('Services'),
              onTap: () {
                // Implement option 2 functionality here
              },
            ),
            // Add more list tiles for other options as needed
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product.imageUrl,
                  height: 350,
                  width: double.infinity,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.productName,
                    style: GoogleFonts.lexend(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  Text(
                    "₹${product.productPrice}",
                    style: GoogleFonts.lexend(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 20),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 40,
                    color: const Color(0xFF80E51A),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.ownerName,
                        style: GoogleFonts.lexend(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        product.ownerNumber,
                        style: GoogleFonts.lexend(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 18),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 40,
                    color: Colors.green[200],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${product.ownerLocation}",
                    style: GoogleFonts.lexend(
                        fontWeight: FontWeight.w500, color: Colors.black),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Description",
                style: GoogleFonts.lexend(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                "${product.productDescription}",
                style: GoogleFonts.lexend(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              product.duration != null
                  ? Text(
                      "Duration : ${product.duration}",
                      style: GoogleFonts.lexend(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 16),
                    )
                  : SizedBox(),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 48,
                width: 358,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFF80E51A)),
                child: MaterialButton(
                  onPressed: () => {
                    makeCall()
                  },
                  child: Center(
                    child: Text(
                      "Call Owner",
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
        ),
      ),
    );
  }
}
