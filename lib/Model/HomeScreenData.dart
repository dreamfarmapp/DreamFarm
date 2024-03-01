const profilePic =
    "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1780&q=80";

class CropData {
  int id;
  String imageURL;
  String name;
  String description;
  int sno;
  CropData(
      {required this.id,
      required this.imageURL,
      required this.name,
      required this.description,
      required this.sno});
}

List<CropData> AI_Recommendations = [
  CropData(
      id: 1,
      imageURL:
          "https://images.unsplash.com/photo-1561504935-4e7d4516a2d1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80",
      name: "Rice",
      description:
          "Hot and humid weather for next 3 months and market demand in high in your region..",
      sno: 1),
  CropData(
      id: 2,
      imageURL:
          "https://images.unsplash.com/photo-1603833665858-e61d17a86224?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1854&q=80",
      name: "Banana",
      description:
          "Hot and humid weather predicted for next 3 months, and market demand is high in cities near your region...",
      sno: 2),
  CropData(
      id: 3,
      imageURL:
          "https://images.unsplash.com/photo-1553787434-dd9eb4ea4d0b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1935&q=80",
      name: "Coconut",
      description:
          "Hot and humid weather predicted for next 3 months, and market demand is high in cities near your region...",
      sno: 3),
  CropData(
      id: 4,
      imageURL:
          "https://images.unsplash.com/photo-1550828520-4cb496926fc9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1933&q=80",
      name: "Pineapple",
      description:
          "Hot and humid weather detected and market demand will be high in 6 months... ",
      sno: 4),
  CropData(
      id: 5,
      imageURL:
          "https://images.unsplash.com/photo-1636488771211-9c635f5002e9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
      name: "Black Pepper",
      description:
          "Hot and humid climate detected and market demand is aldo high..",
      sno: 5)
];
