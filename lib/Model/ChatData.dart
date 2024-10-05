class Chat {
  int userId;
  int chatId;
  String chat;
  String? mediaUrl; // For image or audio file URL
  String chatType; // text, image, audio

  Chat({
    required this.chat,
    required this.chatId,
    required this.userId,
    this.mediaUrl,
    this.chatType = 'text', // default to text
  });

  
}

List<Chat> chats = [
  Chat(chat: "Hey, how are you?", chatId: 101, userId: 1, chatType: 'text'),
  Chat(chat: "I'm good! How about you?", chatId: 102, userId: 2, chatType: 'text'),

  Chat(chat: "Thanks! That was really helpful.", chatId: 105, userId: 1, chatType: 'text'),
  
  Chat(chat: "That looks efficient. Keep it up!", chatId: 107, userId: 2, chatType: 'text'),
];
