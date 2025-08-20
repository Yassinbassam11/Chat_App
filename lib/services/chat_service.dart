import 'package:chat_app/models/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
}
