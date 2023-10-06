class UserModel {
  String? image;
  String? name;
  String? about;
  String? createdAt;
  String? lastActive;
  String? id;
  bool? isOnline;
  String? pushToken;
  String? email;

  UserModel(
      {this.image,
      this.name,
      this.about,
      this.createdAt,
      this.lastActive,
      this.id,
      this.isOnline,
      this.pushToken,
      this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    about = json['about'];
    createdAt = json['created_at'];
    lastActive = json['last_active'];
    id = json['id'];
    isOnline = json['is_online'];
    pushToken = json['push_token'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['about'] = about;
    data['created_at'] = createdAt;
    data['last_active'] = lastActive;
    data['id'] = id;
    data['is_online'] = isOnline;
    data['push_token'] = pushToken;
    data['email'] = email;
    return data;
  }
}
