import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  static Future<void> sendVerificationEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } catch (e) {
      // Handle email verification error
      throw Exception('Failed to verify email: $e');
    }
  }

  static Future<void> checkEmailVerification(BuildContext context) async {
    try {
      await FirebaseAuth.instance.currentUser!.reload();
      if (FirebaseAuth.instance.currentUser!.emailVerified ?? false) {
        await Future.delayed(Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(context, '/chat', (route) => false);
        });
      } else {
        // Email is not verified
      }
    } catch (e) {
      // Handle error
      throw Exception('Failed to check email verification: $e');
    }
  }

  static Future<void> signIn(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (FirebaseAuth.instance.currentUser!.emailVerified == false) {
        Navigator.pushNamedAndRemoveUntil(context, '/chat', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, '/verify', (route) => false);
      }
    } catch (e) {
      // Handle sign-in error
      throw Exception('Failed to sign in: $e');
    }
  }

  static Future<void> signUp(
    String username,
    String email,
    String password,
  ) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({'username': username, 'email': email});
      if (credential.user != null) {
        // User successfully created
        await credential.user!.updateProfile(displayName: username);
      }
    } catch (e) {
      // Handle sign-up error
      throw Exception('Failed to sign up: $e');
    }
  }

  static Future<void> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      // Handle forgot password error
      throw Exception('Failed to send password reset email: $e');
    }
  }
}
