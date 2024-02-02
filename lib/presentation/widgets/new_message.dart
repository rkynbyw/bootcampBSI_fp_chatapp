//new_message
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'send_image_preview.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage> {
  var _messageController = TextEditingController();
  File? _selectedImage;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });

      // Lakukan sesuatu dengan gambar yang dipilih, seperti mengunggahnya ke Firebase
    }
  }

  void _deleteImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  void _submitMessage() async {
    final enteredMessage = _messageController.text;

    if (enteredMessage.trim().isEmpty && _selectedImage == null) {
      return;
    }

    FocusScope.of(context).unfocus();
    _messageController.clear();

    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (_selectedImage != null) {
      final imageRef = FirebaseStorage.instance
          .ref()
          .child('chat_images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = imageRef.putFile(_selectedImage!);

      final imageUrl = await (await uploadTask).ref.getDownloadURL();
      // print('Image URL: $imageUrl');

      FirebaseFirestore.instance.collection('chat').add({
        'text': enteredMessage,
        'imageUrl': imageUrl,
        'createdAt': Timestamp.now(),
        'userId': user.uid,
        'username': userData.data()!['username'],
        'userImage': userData.data()!['image_url'],
      });

      setState(() {
        _selectedImage = null;
      });
    } else {
      FirebaseFirestore.instance.collection('chat').add({
        'text': enteredMessage,
        'createdAt': Timestamp.now(),
        'userId': user.uid,
        'username': userData.data()!['username'],
        'userImage': userData.data()!['image_url'],
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                if (_selectedImage != null)
                  ImagePreview(imageFile: _selectedImage!),
                Row(
                  children: [
                    if (_selectedImage != null)
                      IconButton(
                        color: Theme.of(context).colorScheme.primary,
                        icon: const Icon(Icons.delete),
                        onPressed: _deleteImage,
                      )
                  ],
                ),
                TextField(
                  controller: _messageController,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  enableSuggestions: true,
                  decoration: const InputDecoration(labelText: 'Send a message...'),
                ),

              ],
            )
          ),
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            icon: const Icon(
              Icons.image,
            ),
            onPressed: (){
              _pickImage();
            },
          ),
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            icon: const Icon(
              Icons.send,
            ),
            onPressed: _submitMessage,
          ),
        ],
      ),
    );
  }
}