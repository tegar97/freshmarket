class UserModels {
  int? id;
  String? name;
  String? email;
  String? password;
  String? token;
  String? avatar;

  UserModels(
      {this.id, this.name, this.email, this.password, this.token, this.avatar});

  UserModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    token = json['token'];
    avatar = json['avatar'];

  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name,'email' : email,'password' : password,'token' : token,'avatar' : avatar};
  }
}
