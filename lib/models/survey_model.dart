class SurveyModel {
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

  SurveyModel(
      {this.id,
        this.title,
        this.description,
        this.type,
        this.creationDate,
        this.updateDate,
        this.startDate,
        this.endDate,
        this.status,
        this.userOwnerId});

  SurveyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    type = json['type'];
    creationDate = json['creationDate'];
    updateDate = json['updateDate'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    status = json['status'];
    userOwnerId = json['userOwnerId'];
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
    return data;
  }
}