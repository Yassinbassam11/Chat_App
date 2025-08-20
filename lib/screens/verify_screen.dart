import 'dart:async';

import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  late Timer _verificationTimer;

  @override
  void initState() {
    super.initState();
    _startVerificationTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _verificationTimer.cancel();
    super.dispose();
  }

  void _startVerificationTimer() {
    _verificationTimer = Timer.periodic(Duration(seconds: 3), (timer) async {
      // Check if the email is verified
      print("checking verify");
      await AuthService.checkEmailVerification(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Verification Email Sent"),
              SizedBox(height: 12),
              Text(
                "Please check your inbox and click the link to verify your email.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
