import 'package:lettutor/models/price_of_each_session.dart';
import 'package:lettutor/models/referal_info.dart';
import 'package:lettutor/models/wallet_info.dart';

class User {
  String? id;
  String? email;
  String? name;
  String? avatar;
  String? country;
  String? phone;
  List<String>? roles;
  String? language;
  String? birthday;
  bool? isActivated;
  String? tutorInfo;
  WalletInfo? walletInfo;
  List<String>? feedbacks;
  List<String>? courses;
  String? requireNote;
  String? level;
  List<String>? learnTopics;
  List<String>? testPreparations;
  bool? isPhoneActivated;
  int? timezone;
  ReferralInfo? referralInfo;
  int? avgRating;
  PriceOfEachSession? priceOfEachSession;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    avatar = json['avatar'];
    country = json['country'];
    phone = json['phone'];
    roles = json['roles'].cast<String>();
    language = json['language'];
    birthday = json['birthday'];
    isActivated = json['isActivated'];
    tutorInfo = json['tutorInfo'];
    walletInfo = json['walletInfo'] != null
        ? WalletInfo.fromJson(json['walletInfo'])
        : null;
    if (json['feedbacks'] != null) {
      feedbacks = [];
      json['feedbacks'].forEach((v) {
        feedbacks?.add(v);
      });
    }
    if (json['courses'] != null) {
      courses = [];
      json['courses'].forEach((v) {
        courses?.add(v);
      });
    }
    requireNote = json['requireNote'];
    level = json['level'];
    if (json['learnTopics'] != null) {
      learnTopics = [];
      json['learnTopics'].forEach((v) {
        learnTopics?.add(v);
      });
    }
    if (json['testPreparations'] != null) {
      testPreparations = [];
      json['testPreparations'].forEach((v) {
        testPreparations?.add(v);
      });
    }
    isPhoneActivated = json['isPhoneActivated'];
    timezone = json['timezone'];
    referralInfo = json['referralInfo'] != null
        ? ReferralInfo.fromJson(json['referralInfo'])
        : null;
    avgRating = json['avgRating'];
    priceOfEachSession = json['priceOfEachSession'] != null
        ? PriceOfEachSession.fromJson(json['priceOfEachSession'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['avatar'] = avatar;
    data['country'] = country;
    data['phone'] = phone;
    data['roles'] = roles;
    data['language'] = language;
    data['birthday'] = birthday;
    data['isActivated'] = isActivated;
    data['tutorInfo'] = tutorInfo;
    if (walletInfo != null) {
      data['walletInfo'] = walletInfo?.toJson();
    }
    if (feedbacks != null) {
      data['feedbacks'] = feedbacks;
    }
    if (courses != null) {
      data['courses'] = courses;
    }
    data['requireNote'] = requireNote;
    data['level'] = level;
    if (learnTopics != null) {
      data['learnTopics'] = learnTopics;
    }
    if (testPreparations != null) {
      data['testPreparations'] = testPreparations;
    }
    data['isPhoneActivated'] = isPhoneActivated;
    data['timezone'] = timezone;
    if (referralInfo != null) {
      data['referralInfo'] = referralInfo?.toJson();
    }
    data['avgRating'] = avgRating;
    if (priceOfEachSession != null) {
      data['priceOfEachSession'] = priceOfEachSession?.toJson();
    }
    return data;
  }
}
