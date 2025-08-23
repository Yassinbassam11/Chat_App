import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:flutter/cupertino.dart';

class ViewModel {
  late Stream<List<ChatModel>> chatStream;
  ValueNotifier<List<UserModel>> users = ValueNotifier([]);

  ViewModel() {
    chatStream = ChatService.getChatStream();
    chatStream.listen((event) {
      print("stream loaded");
      print(event);
    });
  }
}
