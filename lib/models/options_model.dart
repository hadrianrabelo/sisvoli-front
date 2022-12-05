class OptionsModel {
  String? id;
  String? name;
  String? pollId;
  OptionsModel({this.id, this.name, this.pollId});

  OptionsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    name = json['name'] as String;
    pollId = json['pollId'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['pollId'] = pollId;
    return data;
  }
}