import 'package:dreamfarm/Model/ChatData.dart';
import 'package:dreamfarm/Model/UserData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart'; // For audio playback

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Chat> _chats = chats;
  TextEditingController textEditingController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final AudioPlayer _audioPlayer = AudioPlayer();

  void addChat(String text) {
    setState(() {
      _chats.add(Chat(chat: text, chatId: 101, userId: 1));
    });
  }

  void addImageChat(String imagePath) {
    setState(() {
      _chats.add(Chat(chat: 'Image', chatId: 101, userId: 1, mediaUrl: imagePath, chatType: 'image'));
    });
  }

  void addAudioChat(String audioPath) {
    setState(() {
      _chats.add(Chat(chat: 'Audio', chatId: 101, userId: 1, mediaUrl: audioPath, chatType: 'audio'));
    });
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      addImageChat(pickedFile.path);
    }
  }

  Future<void> pickAudio() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null && result.files.single.path != null) {
      addAudioChat(result.files.single.path!);
    }
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
                      child: currentChat.chatType == 'text'
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
                          : currentChat.chatType == 'image'
                              ? Container(
                                  margin: const EdgeInsets.all(5),
                                  child: Image.file(
                                    File(currentChat.mediaUrl!),
                                    width: 150.w,
                                    height: 150.h,
                                  ),
                                )
                              : currentChat.chatType == 'audio'
                                  ? Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Container(
                                         width: 150.w,
                                    height: 150.h,
                                        child: Row(
                                          
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.play_arrow),
                                              onPressed: () {
                                                _audioPlayer.play( 
                                                    UrlSource(currentChat.mediaUrl!));
                                              },
                                            ),
                                            Text('Audio File'),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: pickImage,
                  ),
                  IconButton(
                    icon: Icon(Icons.audiotrack),
                    onPressed: pickAudio,
                  ),
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                      ),
                      onSubmitted: (value) {
                        addChat(value);
                        textEditingController.clear();
                      },
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
