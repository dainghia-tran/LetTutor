import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:lettutor/app_provider.dart';
import 'package:lettutor/constants/http.dart';
import 'package:lettutor/models/schedule.dart';

class BookingHistoryProvider extends ChangeNotifier {
  bool isLoading = true;
  int page = 1;
  int perPage = 2;
  int count = 0;

  List<Schedule> scheduleList = [];

  Future<void> getSchedules(bool resetList) async {
    try {
      if (resetList == true) {
        scheduleList.clear();
        page = 1;
      }
      isLoading = true;
      notifyListeners();

      var dio = Http().client;
      var accessToken = AppProvider.auth?.tokens?.access?.token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      var query = {
        'page': page,
        'perPage': perPage,
        'dateTimeLte': DateTime.now().millisecondsSinceEpoch,
        'orderBy': 'meeting',
        'sortBy': 'desc'
      };
      var res = await dio.get("booking/list/student", queryParameters: query);
      Iterable i = res.data["data"]["rows"];
      List<Schedule> data =
          List<Schedule>.from(i.map((schedule) => Schedule.fromJson(schedule)));
      scheduleList.addAll(data);
      count = res.data["data"]["count"];
    } catch (e) {
      inspect(e);
    }
    isLoading = false;
    notifyListeners();
  }
}
