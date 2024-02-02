import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../entity/user.dart';



class PersonalChatPage extends StatelessWidget {
  const PersonalChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('uid', isNotEqualTo: auth.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.hasData) {
            List<UserApp> users = snapshot.data!.docs.map((doc) => UserApp.fromFirestore(doc)).toList();
            print('Total User: ${users.length}');
            for (var user in users) {
              print('Username: ${user.username}, Email: ${user.email}');
            }
            // Tampilkan daftar pengguna di sini
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index].username),
                  subtitle: Text(users[index].email),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(users[index].imageUrl),
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),

    );
  }
}
