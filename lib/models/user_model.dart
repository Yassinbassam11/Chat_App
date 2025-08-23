class UserModel {
  String id;
  String username;
  String email;

  UserModel({required this.id, required this.username, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      username: json['username'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'username': username, 'id': id};
  }
}
