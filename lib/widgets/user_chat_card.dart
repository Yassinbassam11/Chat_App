import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserChatCard extends StatelessWidget {
  const UserChatCard({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // Handle user tap
        String chatId = '';
        final myId = FirebaseAuth.instance.currentUser!.uid;
        final receiverId = user.id;

        if (myId.compareTo(receiverId) < 0) {
          chatId = '$myId-$receiverId';
        } else {
          chatId = '$receiverId-$myId';
        }
        final doesChatExist = await ChatService.doesPrivateChatExist(chatId);
        if (doesChatExist) {
          Navigator.pushNamed(context, '/private_chat', arguments: chatId);
        } else {
          await ChatService.createPrivateChat(chatId);
          Navigator.pushNamed(context, '/private_chat', arguments: chatId);
        }
      },
      child: ListTile(
        title: Text(user.username),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[200],
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
