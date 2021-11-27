class ReferralPackInfo {
  int? id;
  int? earnPercent;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  ReferralPackInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    earnPercent = json['earnPercent'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['earnPercent'] = earnPercent;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
