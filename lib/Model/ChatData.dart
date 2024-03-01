class Chat {
  int userId;
  int chatId;
  String chat;
  Chat({required this.chat, required this.chatId, required this.userId});
}

List<Chat> chats = [
  Chat(chat: "Hi dude", chatId: 101, userId: 1),
  Chat(chat: "Hello", chatId: 102, userId: 2),
  Chat(chat: "How to prevent soil from dryness ?", chatId: 103, userId: 1),
  Chat(chat: "Water soils regularly. If sun is too much, water soil with excess water ?", chatId: 104, userId: 2)
];
