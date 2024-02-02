import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MyAuthProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> signIn(String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      notifyListeners(); // Memberitahu widget yang mendengarkan perubahan data
    } on FirebaseAuthException catch (e) {

    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {

    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    _user = null;
    notifyListeners();
  }

  late bool isLogin;
  MyAuthProvider({this.isLogin = true });
  void switchMethod(){
    isLogin = !isLogin;
    notifyListeners();
  }


}


