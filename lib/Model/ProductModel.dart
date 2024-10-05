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
  double? ownerLocationLat; // New property for owner's location latitude
  double? ownerLocationLon; // New property for owner's location longitude
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
      this.duration,
      this.ownerLocationLat,
    this.ownerLocationLon,});
}
