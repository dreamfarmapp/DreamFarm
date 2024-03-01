class ProductModel {
  String productName;
  String productDescription;
  String productPrice;
  int id;
  String imageUrl;
  String ownerName;
  String ownerNumber;
  String ownerLocation;
  String type;
  String? duration;
  ProductModel(
      {required this.productName,
      required this.productPrice,
      required this.imageUrl,
      required this.id,
      required this.ownerLocation,
      required this.ownerName,
      required this.ownerNumber,
      required this.productDescription,
      required this.type,
      this.duration});
}
