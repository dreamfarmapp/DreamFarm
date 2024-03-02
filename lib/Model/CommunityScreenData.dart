class PostModel {
  String postImageUrl;
  String profileImageUrl;
  bool isFollowed;
  bool isSaved;
  String captions;
  String accountName;
  String title;
  int id;
  PostModel(
      {required this.postImageUrl,
      required this.profileImageUrl,
      required this.accountName,
      required this.captions,
      required this.isFollowed,
      required this.isSaved,
      required this.title,
      required this.id});
}

List<PostModel> posts = [
  PostModel(
    title: "Woekin",
      postImageUrl:
          "https://images.unsplash.com/photo-1605000797499-95a51c5269ae?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2071&q=80",
      profileImageUrl:
          "https://images.unsplash.com/profile-1686586982473-66932111d72eimage?dpr=1&auto=format&fit=crop&w=150&h=150&q=60&crop=faces&bg=fff",
      accountName: "Sunnil Kumar",
      captions: "Just started harvesting guys...",
      isFollowed: false,
      isSaved: false,
      id: 101),
  PostModel(
    title: "Woekin",
      postImageUrl:
          "https://images.unsplash.com/photo-1533062618053-d51e617307ec?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
      profileImageUrl:
          "https://images.unsplash.com/profile-1533558945235-d438862b9bb4?dpr=1&auto=format&fit=crop&w=150&h=150&q=60&crop=faces&bg=fff",
      accountName: "Naveen Patel",
      captions: "Invested on Good Tractors, hope I get back my investment",
      isFollowed: false,
      isSaved: false,
      id: 101),
  PostModel(
    title: "Working",
      postImageUrl:
          "https://images.unsplash.com/photo-1627920769842-6887c6df05ca?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1933&q=80",
      profileImageUrl:
          "https://images.unsplash.com/profile-fb-1550775635-9ab106b96960.jpg?dpr=1&auto=format&fit=crop&w=150&h=150&q=60&crop=faces&bg=fff",
      accountName: "Ravana",
      captions: "Harvesting Corns, anyone want ?",
      isFollowed: false,
      isSaved: false,
      id: 103),
  PostModel(
    title: "Woekin",
      postImageUrl:
          "https://images.unsplash.com/photo-1509099381441-ea3c0cf98b94?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2072&q=80",
      profileImageUrl:
          "https://images.unsplash.com/profile-1648828806223-1852f704c58aimage?dpr=1&auto=format&fit=crop&w=150&h=150&q=60&crop=faces&bg=fff",
      accountName: "Annie Spratt",
      captions: "Women farming cassava in Sierra Leone",
      isFollowed: false,
      isSaved: false,
      id: 104),
  PostModel(
    title: "Woekin",
      postImageUrl:
          "https://images.unsplash.com/photo-1565647952915-9644fcd446a4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
      profileImageUrl:
          "https://images.unsplash.com/profile-1482177840531-94dcac5fa2b5?dpr=1&auto=format&fit=crop&w=32&h=32&q=60&crop=faces&bg=fff",
      accountName: "Robert Wiedemann",
      captions: "Usage machines, just doubled my investments",
      isFollowed: false,
      isSaved: false,
      id: 105)
];
