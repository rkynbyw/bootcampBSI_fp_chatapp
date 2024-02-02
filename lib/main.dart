//main.dart
import 'package:bootcampday11_firebase_training/presentation/page/chat.dart';
import 'package:bootcampday11_firebase_training/presentation/page/auth_page.dart';
import 'package:bootcampday11_firebase_training/presentation/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:bootcampday11_firebase_training/presentation/page/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'package:bootcampday11_firebase_training/presentation/page/home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
  // runApp(
  //   MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider(create: (_) => MyAuthProvider()),
  //     ],
  //     child: const App(),
  //   ),
  // );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FlutterChat',
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 63, 17, 177)),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot){
            if (snapshot.hasData){
              return const HomePage();
            } else {
              return AuthScreen();
            }
          },
        )
    );
  }
}

