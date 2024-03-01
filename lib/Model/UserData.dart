class User {
  String userName;
  int noOfPosts;
  int noOfFollowers;
  int noOfFollowing;
  String profileImageUrl;
  int id;
  User(
      {required this.userName,
      required this.noOfPosts,
      required this.noOfFollowing,
      required this.noOfFollowers,
      required this.profileImageUrl,
      required this.id});
}

List<User> users = [
  User(
    userName: 'Alice',
    noOfPosts: 35,
    noOfFollowers: 782,
    noOfFollowing: 243,
    profileImageUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80',
    id: 1,
  ),
  User(
    userName: 'Bob',
    noOfPosts: 19,
    noOfFollowers: 524,
    noOfFollowing: 98,
    profileImageUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80',
    id: 2,
  ),
  User(
    userName: 'Charlie',
    noOfPosts: 67,
    noOfFollowers: 1289,
    noOfFollowing: 621,
    profileImageUrl:
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80',
    id: 3,
  ),
  User(
    userName: 'David',
    noOfPosts: 42,
    noOfFollowers: 956,
    noOfFollowing: 367,
    profileImageUrl:
        'https://images.unsplash.com/photo-1463453091185-61582044d556?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
    id: 4,
  ),
  User(
    userName: 'Eve',
    noOfPosts: 25,
    noOfFollowers: 633,
    noOfFollowing: 154,
    profileImageUrl:
        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
    id: 5,
  ),
  User(
    userName: 'Frank',
    noOfPosts: 55,
    noOfFollowers: 312,
    noOfFollowing: 87,
    profileImageUrl:
        'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1889&q=80',
    id: 6,
  ),
  User(
    userName: 'Grace',
    noOfPosts: 72,
    noOfFollowers: 890,
    noOfFollowing: 421,
    profileImageUrl:
        'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
    id: 7,
  ),
  User(
    userName: 'Hannah',
    noOfPosts: 11,
    noOfFollowers: 432,
    noOfFollowing: 176,
    profileImageUrl:
        'https://images.unsplash.com/photo-1520923990214-8ef4e4bf025d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
    id: 8,
  ),
  User(
    userName: 'Isaac',
    noOfPosts: 93,
    noOfFollowers: 1245,
    noOfFollowing: 588,
    profileImageUrl:
        'https://images.unsplash.com/photo-1639747280804-dd2d6b3d88ac?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80',
    id: 9,
  ),
  User(
    userName: 'Jack',
    noOfPosts: 28,
    noOfFollowers: 753,
    noOfFollowing: 298,
    profileImageUrl:
        'https://images.unsplash.com/photo-1544435253-f0ead49638fa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80',
    id: 10,
  ),
  User(
    userName: 'Kate',
    noOfPosts: 37,
    noOfFollowers: 642,
    noOfFollowing: 123,
    profileImageUrl:
        'https://images.unsplash.com/photo-1624561172888-ac93c696e10c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1889&q=80',
    id: 11,
  ),
  User(
    userName: 'Liam',
    noOfPosts: 64,
    noOfFollowers: 1047,
    noOfFollowing: 498,
    profileImageUrl:
        'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
    id: 12,
  ),
  User(
    userName: 'Mia',
    noOfPosts: 19,
    noOfFollowers: 381,
    noOfFollowing: 142,
    profileImageUrl:
        'https://images.unsplash.com/photo-1607746882042-944635dfe10e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
    id: 13,
  ),
  User(
    userName: 'Noah',
    noOfPosts: 87,
    noOfFollowers: 1298,
    noOfFollowing: 721,
    profileImageUrl:
        'https://images.unsplash.com/photo-1614289371518-722f2615943d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80',
    id: 14,
  ),
  User(
    userName: 'Olivia',
    noOfPosts: 22,
    noOfFollowers: 578,
    noOfFollowing: 189,
    profileImageUrl:
        'https://images.unsplash.com/photo-1591727884968-cc11135a19b3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1912&q=80',
    id: 15,
  ),
];
