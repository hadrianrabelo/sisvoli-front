import 'options_model.dart';

class PollModel {
  String? id;
  String? title;
  String? description;
  String? type;
  String? creationDate;
  String? updateDate;
  String? startDate;
  String? endDate;
  String? status;
  String? userOwnerId;
  List<OptionsModel>? optionList;

  PollModel(
      {this.id,
        this.title,
        this.description,
        this.type,
        this.creationDate,
        this.updateDate,
        this.startDate,
        this.endDate,
        this.status,
        this.userOwnerId,
        this.optionList});

  PollModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    title = json['title'] as String;
    description = json['description'] as String;
    type = json['type'] as String;
    creationDate = json['creationDate'] as String;
    updateDate = json['updateDate'] as String;
    startDate = json['startDate'] as String;
    endDate = json['endDate'] as String;
    status = json['status'] as String;
    userOwnerId = json['userOwnerId'] as String;
    optionList = (json['optionList'] as Iterable<dynamic>).map((e) => OptionsModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['type'] = type;
    data['creationDate'] = creationDate;
    data['updateDate'] = updateDate;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['status'] = status;
    data['userOwnerId'] = userOwnerId;
    data['optionList'] = optionList;
    return data;
  }
}