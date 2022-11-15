class UserModel {
  String? accessToken;
  String? refreshToken;
  String? userCpf;
  String? token;
  String? newPassword;

  UserModel({this.accessToken, this.refreshToken, this.userCpf, this.token, this.newPassword});

  UserModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    userCpf = json['userCpf'];
    token = json['token'];
    newPassword = json['newPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['userCpf'] = userCpf;
    data['token'] = token;
    data['newPassword'] = newPassword;
    return data;
  }
 String toString() {
    return "$userCpf";
  }
}