import 'package:dreamfarm/Model/ProductModel.dart';
import 'package:dreamfarm/screens/MarketPlace/product_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final List<ProductModel> allProducts = [
  ProductModel(
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
      duration: "6 months"),
  ProductModel(
    productName: "Tractor 2",
    productPrice: "500",
    imageUrl:
        "https://www.csceagri.in/web/image/lead.item/62/image_1920/TRAKSTAR%20531?unique=8f211c5",
    id: 2,
    ownerLocation: "Telungana",
    ownerName: "Suresh",
    ownerNumber: "9876543210",
    productDescription:
        "The ABC tractor is a powerful machine equipped with advanced features to handle heavy-duty farming tasks with ease. It offers exceptional performance and reliability, making it an ideal choice for modern farmers.",
    type: "buy",
  ),
  ProductModel(
      productName: "Tractor 3",
      productPrice: "600",
      imageUrl:
          "https://www.csceagri.in/web/image/lead.item/62/image_1920/TRAKSTAR%20531?unique=8f211c5",
      id: 3,
      ownerLocation: "Telungana",
      ownerName: "Gopal",
      ownerNumber: "9876123450",
      productDescription:
          "The PQR tractor is a compact yet powerful machine designed for small to medium-sized farms. It offers excellent maneuverability and fuel efficiency, making it suitable for a wide range of agricultural applications.",
      type: "rent",
      duration: "6 months"),
  ProductModel(
    productName: "Tractor 4",
    productPrice: "700",
    imageUrl:
        "https://www.csceagri.in/web/image/lead.item/62/image_1920/TRAKSTAR%20531?unique=8f211c5",
    id: 4,
    ownerLocation: "Telungana",
    ownerName: "Krishna",
    ownerNumber: "9012345678",
    productDescription:
        "The LMN tractor is an advanced agricultural machine equipped with cutting-edge technology to enhance productivity and performance. It offers superior comfort, control, and efficiency for a seamless farming experience.",
    type: "buy",
  ),
  ProductModel(
      productName: "Tractor 5",
      productPrice: "800",
      imageUrl:
          "https://www.csceagri.in/web/image/lead.item/62/image_1920/TRAKSTAR%20531?unique=8f211c5",
      id: 5,
      ownerLocation: "Telungana",
      ownerName: "Harish",
      ownerNumber: "9988776655",
      productDescription:
          "The UVW tractor is a high-performance machine engineered for heavy-duty agricultural tasks. It offers exceptional power, efficiency, and durability to handle the most demanding farming operations with ease.",
      type: "rent",
      duration: "6 months"),
];

class MarketplaceScreen extends StatefulWidget {
  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  bool isRent = true;
  TextEditingController controller = TextEditingController();
  List<ProductModel> filteredProducts =
      allProducts.where((e) => e.type == "rent").toList();

  //Toggle Options
  void showRent() {
    List<ProductModel> newProd =
        allProducts.where((e) => e.type == "rent").toList();
    setState(() {
      isRent = true;
      filteredProducts = newProd;
    });
  }

  void showBuy() {
    List<ProductModel> newProd =
        allProducts.where((e) => e.type == "buy").toList();
    setState(() {
      isRent = false;
      filteredProducts = newProd;
    });
  }

  void handleSearch() {
    List<ProductModel> newProd = allProducts
        .where((element) =>
            element.productName.contains(controller.text) &&
            (element.type == (isRent ? "rent" : "buy")))
        .toList();
    setState(() {
      filteredProducts = newProd;
    });
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
                        borderRadius: BorderRadius.circular(8))),
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
                        borderRadius: BorderRadius.circular(12)),
                    child: MaterialButton(
                      onPressed: () => showRent(),
                      child: Center(
                        child: Text(
                          "Rent",
                          style: GoogleFonts.lexend(
                              fontSize: 18,
                              fontWeight:
                                  isRent ? FontWeight.bold : FontWeight.normal,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: !isRent ? Colors.green[200] : Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: MaterialButton(
                      onPressed: () => showBuy(),
                      child: Center(
                        child: Text(
                          "Buy",
                          style: GoogleFonts.lexend(
                              fontSize: 18,
                              fontWeight:
                                  !isRent ? FontWeight.bold : FontWeight.normal,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: filteredProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: ProductCard(product: filteredProducts[index]),
                  );
                })
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
    );
  }
}
