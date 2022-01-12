import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:lettutor/app_provider.dart';
import 'package:lettutor/constants/http.dart';
import 'package:lettutor/models/tutor_schedule.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class BookTutorProvider extends ChangeNotifier {
  _AppointmentDataSource? appointmentData;
  List<TutorSchedule> scheduleList = [];
  bool isLoading = true;

  void getCalendarTiles() {
    List<Appointment> appointments = <Appointment>[];
    for (var schedule in scheduleList) {
      for (var detail in (schedule.scheduleDetails!)) {
        appointments.add(
          Appointment(
            startTime: DateTime.fromMillisecondsSinceEpoch(
                    detail.startPeriodTimestamp!)
                .toLocal(),
            endTime:
                DateTime.fromMillisecondsSinceEpoch(detail.endPeriodTimestamp!)
                    .toLocal(),
            startTimeZone: '',
            endTimeZone: '',
            subject: ((detail.isBooked ?? false) ||
                        (detail.bookingInfo!.isNotEmpty &&
                            detail.bookingInfo!.first.isDeleted == false)) ||
                    DateTime.now().millisecondsSinceEpoch >=
                        (detail.startPeriodTimestamp ?? 0)
                ? 'Booked'
                : 'Book',
            id: detail.id,
          ),
        );
      }
    }
    appointmentData = _AppointmentDataSource(appointments);
    notifyListeners();
  }

  void getTutorSchedule(String tutorId) async {
    try {
      isLoading = true;
      notifyListeners();

      var accessToken = AppProvider.auth?.tokens?.access?.token;
      var dio = Http().client;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      var res = await dio.post("schedule", data: {
        'tutorId': tutorId,
      });
      print(tutorId);

      Iterable i = res.data["data"];
      List<TutorSchedule> result = i
          .map(
            (schedule) => TutorSchedule.fromJson(schedule),
          )
          .toList();

      scheduleList = result;
      getCalendarTiles();
    } catch (e) {
      inspect(e);
    }

    isLoading = false;
    notifyListeners();
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
