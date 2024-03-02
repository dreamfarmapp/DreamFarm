import 'package:dreamfarm/Model/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              product.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${product.productName}",
                      style: GoogleFonts.lexend(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    if (product.productDescription != null &&
                        product.productDescription.isNotEmpty)
                      Text(
                        "${product.productDescription.substring(0, product.productDescription.length < 30 ? product.productDescription.length : 30)}...",
                        style: GoogleFonts.lexend(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
                Text(
                  "₹${product.productPrice}",
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF80E51A),
                borderRadius: BorderRadius.circular(8),
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/product", arguments: product);
                },
                child: Center(
                  child: Text(
                    "View Product",
                    style: GoogleFonts.lexend(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
