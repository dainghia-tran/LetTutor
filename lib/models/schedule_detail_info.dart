import 'booking_info.dart';

class ScheduleDetailInfo {
  int? startPeriodTimestamp;
  int? endPeriodTimestamp;
  String? id;
  String? scheduleId;
  String? startPeriod;
  String? endPeriod;
  String? createdAt;
  String? updatedAt;
  List<BookingInfo>? bookingInfo;

  ScheduleDetailInfo.fromJson(Map<String, dynamic> json) {
    startPeriodTimestamp = json['startPeriodTimestamp'];
    endPeriodTimestamp = json['endPeriodTimestamp'];
    id = json['id'];
    scheduleId = json['scheduleId'];
    startPeriod = json['startPeriod'];
    endPeriod = json['endPeriod'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['bookingInfo'] != null) {
      bookingInfo = <BookingInfo>[];
      json['bookingInfo'].forEach((v) {
        bookingInfo?.add(BookingInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startPeriodTimestamp'] = startPeriodTimestamp;
    data['endPeriodTimestamp'] = endPeriodTimestamp;
    data['id'] = id;
    data['scheduleId'] = scheduleId;
    data['startPeriod'] = startPeriod;
    data['endPeriod'] = endPeriod;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (bookingInfo != null) {
      data['bookingInfo'] = bookingInfo?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
