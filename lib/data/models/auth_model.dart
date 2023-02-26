import 'package:shoes_app/data/models/user_model.dart';


class AuthModel {
  AuthModel({
    required this.accessToken,
    required this.tokenType,
    required this.user,
  });

  final String accessToken;
  final String tokenType;
  final UserModel user;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    user: UserModel.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "user": user.toJson(),
  };
}