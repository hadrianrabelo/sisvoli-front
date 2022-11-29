class ProfileModel {
  String? id;
  String? name;
  String? gender;
  String? email;
  String? cpf;
  String? birthDate;
  String? username;
  String? creationDate;
  String? updateDate;
  String? roleName;

  ProfileModel(
      {this.id,
        this.name,
        this.gender,
        this.email,
        this.cpf,
        this.birthDate,
        this.username,
        this.creationDate,
        this.updateDate,
        this.roleName});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    email = json['email'];
    cpf = json['cpf'];
    birthDate = json['birthDate'];
    username = json['username'];
    creationDate = json['creationDate'];
    updateDate = json['updateDate'];
    roleName = json['roleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['gender'] = gender;
    data['email'] = email;
    data['cpf'] = cpf;
    data['birthDate'] = birthDate;
    data['username'] = username;
    data['creationDate'] = creationDate;
    data['updateDate'] = updateDate;
    data['roleName'] = roleName;
    return data;
  }
}