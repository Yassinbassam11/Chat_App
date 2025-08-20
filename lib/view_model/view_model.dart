import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewModel {
  late Stream<List<ChatModel>> chatStream;

  ViewModel() {
    chatStream = ChatService.getChatStream();
    chatStream.listen((event) {
      print(event);
    });
  }
  Future<void> sendMessage(ChatModel model) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(model.id)
        .set(model.toJson());
  }
}
