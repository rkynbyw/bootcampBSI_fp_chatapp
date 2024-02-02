import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserApp {
  final String uid;
  final String username;
  final String imageUrl;
  final String email;

  UserApp({
    required this.uid,
    required this.username,
    required this.imageUrl,
    required this.email,
  });

  factory UserApp.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserApp(
      uid: doc.id,
      username: data['username'],
      imageUrl: data['imageUrl'],
      email: data['email'],
      // ... other properties from Firestore
    );
  }

  // factory UserApp.fromFirestore(DocumentSnapshot doc) {
  //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //   return UserApp(
  //     uid: doc.id,
  //     username: data['username'],
  //     imageUrl: data['imageUrl'],
  //     email: data['email'],
  //   );

}



