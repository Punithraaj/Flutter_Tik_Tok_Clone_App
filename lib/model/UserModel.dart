class UserModel {
  late String username;
  late String email;
  late String id;

  UserModel({required this.username, required this.email, required this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['id'] = this.id;
    return data;
  }
}
