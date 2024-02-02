//chat.dart
import 'package:bootcampday11_firebase_training/presentation/widgets/new_message.dart';
import 'package:bootcampday11_firebase_training/presentation/widgets/chat_messages.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bootcampday11_firebase_training/presentation/widgets/user_image_picker.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  void _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate back to the login screen after signing out
      Navigator.of(context).pop();
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('FlutterChat'),
        // actions: [
        //   IconButton(
        //       onPressed: (){
        //         FirebaseAuth.instance.signOut();
        //       },
        //       icon: Icon(Icons.logout))
        // ],

      // ),
      body: Column(
        children: const [
          Expanded(
              child: ChatMessages()
          ),
          NewMessage(),
        ],
      )
    );
  }
}