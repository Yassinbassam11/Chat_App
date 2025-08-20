import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String message;
  final String senderId;
  final String senderName;
  final String id;
  final DateTime timestamp;

  ChatModel({
    required this.message,
    required this.senderId,
    required this.senderName,
    required this.id,
    required this.timestamp,
  });
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      message: json['message'] as String,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
      id: json['id'] as String,
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'senderId': senderId,
      'senderName': senderName,
      'id': id,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
