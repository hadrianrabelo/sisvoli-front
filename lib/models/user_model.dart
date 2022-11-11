class UserModel {
  String? accesToken;
  String? refreshToken;
  String? userCpf;
  String? token;

  UserModel({this.accesToken, this.refreshToken, this.userCpf, this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    accesToken = json['acces_token'];
    refreshToken = json['refresh_token'];
    userCpf = json['userCpf'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['acces_token'] = accesToken;
    data['refresh_token'] = refreshToken;
    data['userCpf'] = userCpf;
    data['token'] = token;
    return data;
  }
}