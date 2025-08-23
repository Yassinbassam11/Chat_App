import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  static Future<void> deleteMessage(String messageId) async {
    try {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(messageId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete message: $e');
    }
  }

  static Stream<List<ChatModel>> getChatStream() {
    try {
      final snapshots = FirebaseFirestore.instance
          .collection('chats')
          .orderBy('timestamp')
          .snapshots();
      return snapshots.map((snapshot) {
        return snapshot.docs.map((doc) {
          return ChatModel.fromJson(doc.data());
        }).toList();
      });
    } catch (e) {
      throw Exception('Failed to fetch chat messages: $e');
    }
  }

  static Future<void> getChatUsers() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    final result = snapshot.docs
        .where((doc) {
          final dataMap = doc.data();
          return FirebaseAuth.instance.currentUser?.uid != dataMap['id'];
        })
        .map((doc) => UserModel.fromJson(doc.data()))
        .toList();

    viewModel.users.value = result;
  }

  static Future<bool> doesPrivateChatExist(String chatId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("privateChats")
        .doc(chatId)
        .get();
    return snapshot.exists;
  }

  static Future<void> createPrivateChat(String chatId) async {
    try {
      await FirebaseFirestore.instance
          .collection("privateChats")
          .doc(chatId)
          .set({});
    } catch (e) {
      throw Exception('Failed to create private chat: $e');
    }
  }
}
