import 'package:lettutor/models/referral_pack_info.dart';

class ReferralInfo {
  int? id;
  String? referralCode;
  String? userId;
  int? referralPackId;
  String? createdAt;
  String? updatedAt;
  ReferralPackInfo? referralPackInfo;

  ReferralInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referralCode = json['referralCode'];
    userId = json['userId'];
    referralPackId = json['referralPackId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    referralPackInfo = json['referralPackInfo'] != null
        ? ReferralPackInfo.fromJson(json['referralPackInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['referralCode'] = referralCode;
    data['userId'] = userId;
    data['referralPackId'] = referralPackId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (referralPackInfo != null) {
      data['referralPackInfo'] = referralPackInfo?.toJson();
    }
    return data;
  }
}
