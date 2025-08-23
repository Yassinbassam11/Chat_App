import 'package:chat_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserChatCard extends StatelessWidget {
  const UserChatCard({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle user tap
      },
      child: ListTile(
        title: Text(user.username),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.red,
          backgroundImage: NetworkImage(
            'https://www.kindpng.com/picc/m/207-2074624_white-gray-circle-avatar-png-transparent-png.png',
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        subtitle: Text(user.email),
      ),
    );
  }
}
