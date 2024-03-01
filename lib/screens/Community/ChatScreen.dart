import 'package:dreamfarm/Model/ChatData.dart';
import 'package:dreamfarm/Model/UserData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Chat> _chats = chats;
  TextEditingController textEditingController = TextEditingController();

  void addChat(String text) {
    setState(() {
      _chats.add(Chat(chat: text, chatId: 101, userId: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    final userData = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDBF5E0),
        title: Text(
          userData.userName,
          style: GoogleFonts.roboto(
            fontSize: 20.sp,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.r),
              child: Image(
                image: NetworkImage(userData.profileImageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _chats.length,
                  itemBuilder: (BuildContext context, int index) {
                    Chat currentChat = _chats[index];
                    return Align(
                      alignment: currentChat.userId == 1
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      child: currentChat.userId == 1
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.green[300],
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              constraints: BoxConstraints(maxWidth: 250.w),
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                currentChat.chat,
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                ),
                              ),
                            )
                          : Container(
                              constraints: BoxConstraints(maxWidth: 250.w),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.green),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                currentChat.chat,
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                    );
                  },
                ),
              ),
              TextField(
                controller: textEditingController,
                style: GoogleFonts.roboto(
                  color: Colors.black,
                ),
                onSubmitted: ((value) => addChat(value)),
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  contentPadding: EdgeInsets.all(10),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: Colors.greenAccent,
                    ),
                    onPressed: () {
                      addChat(textEditingController.text);
                      textEditingController.clear();
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
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
