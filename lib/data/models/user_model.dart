class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.roles,
    required this.profilePhotoUrl,
  });

  final int id;
  final String name;
  final String email;
  final String username;
  final String roles;
  final String profilePhotoUrl;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    username: json["username"],
    roles: json["roles"],
    profilePhotoUrl: json["profile_photo_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "username": username,
    "roles": roles,
    "profile_photo_url": profilePhotoUrl,
  };
}