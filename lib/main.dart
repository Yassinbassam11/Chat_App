// import 'package:chatapp/screens/signin_screen.dart';

import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/forget_password_screen.dart';
import 'package:chat_app/screens/signin_screen.dart';
import 'package:chat_app/screens/signup_screen.dart';
import 'package:chat_app/screens/usersList_screen.dart';
import 'package:chat_app/screens/verify_screen.dart';
import 'package:chat_app/view_model/view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

ViewModel viewModel = ViewModel();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: FirebaseAuth.instance.currentUser?.uid != null
          ? '/chat'
          : '/signin',
      routes: {
        '/signin': (context) => SigninScreen(),
        '/signup': (context) => SignupScreen(),
        '/chat': (context) => ChatScreen(),
        '/verify': (context) => VerifyScreen(),
        '/forgot_password': (context) => ForgotPasswordScreen(),
        '/users': (context) => UsersListScreen(),
      },
    );
  }
}
