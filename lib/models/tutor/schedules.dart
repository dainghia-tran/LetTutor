import 'package:lettutor/models/schedule_detail_info.dart';

class Schedules {
  String? date;
  int? startTimestamp;
  int? endTimestamp;
  String? id;
  String? tutorId;
  String? startTime;
  String? endTime;
  String? createdAt;
  String? updatedAt;
  List<ScheduleDetailInfo>? scheduleDetailInfo;

  Schedules.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    startTimestamp = json['startTimestamp'];
    endTimestamp = json['endTimestamp'];
    id = json['id'];
    tutorId = json['tutorId'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['scheduleDetailInfo'] != null) {
      scheduleDetailInfo = <ScheduleDetailInfo>[];
      json['scheduleDetailInfo'].forEach((v) {
        scheduleDetailInfo?.add(ScheduleDetailInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['startTimestamp'] = startTimestamp;
    data['endTimestamp'] = endTimestamp;
    data['id'] = id;
    data['tutorId'] = tutorId;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (scheduleDetailInfo != null) {
      data['scheduleDetailInfo'] =
          scheduleDetailInfo?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
