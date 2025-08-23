import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    this.isPrivate = false,
    this.chatId,
  });
  final ChatModel message;
  final bool isPrivate;
  final String? chatId;

  @override
  Widget build(BuildContext context) {
    // Current user may be null during app startup; guard against that.
    final currentUid = FirebaseAuth.instance.currentUser?.uid;
    print(
      'MessageBubble Debug: senderId = \\"${message.senderId}\\", currentUser.uid = \\"$currentUid\\"',
    );
    bool isMe = message.senderId == currentUid;
    return GestureDetector(
      onLongPress: () {
        if (isMe) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog.adaptive(
                title: Text('Delete Message'),
                content: Text('Are you sure you want to delete this message?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      try {
                        if (isPrivate && chatId != null) {
                          await ChatService.deletePrivateMessage(
                            chatId!,
                            message.id,
                          );
                        } else {
                          await ChatService.deleteMessage(message.id);
                        }
                        Navigator.of(context).pop();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to delete message: $e'),
                          ),
                        );
                      }
                    },
                    child: Text('Delete'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: isMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(
                message.senderName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                ),
                decoration: BoxDecoration(
                  color: isMe ? Colors.blueAccent : Colors.grey[600],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: isMe ? Radius.circular(12) : Radius.circular(0),
                    bottomRight: isMe
                        ? Radius.circular(0)
                        : Radius.circular(12),
                  ),
                ),
                child: Text(
                  message.message,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Text(timeago.format(message.timestamp)),
            ],
          ),
        ),
      ),
    );
  }
}
