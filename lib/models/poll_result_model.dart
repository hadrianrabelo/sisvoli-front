class PollResultModel {
  String? pollId;
  int? voteCount;
  List<OptionRanking>? optionRanking;

  PollResultModel({this.pollId, this.voteCount, this.optionRanking});

  PollResultModel.fromJson(Map<String, dynamic> json) {
    pollId = json['pollId'];
    voteCount = json['voteCount'];
    if (json['optionRanking'] != null) {
      optionRanking = <OptionRanking>[];
      json['optionRanking'].forEach((v) {
        optionRanking!.add(OptionRanking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pollId'] = pollId;
    data['voteCount'] = voteCount;
    if (optionRanking != null) {
      data['optionRanking'] =
          optionRanking!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OptionRanking {
  String? id;
  String? name;
  int? totalVotes;

  OptionRanking({this.id, this.name, this.totalVotes});

  OptionRanking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    totalVotes = json['totalVotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['totalVotes'] = totalVotes;
    return data;
  }
}