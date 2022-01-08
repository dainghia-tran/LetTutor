import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:lettutor/app_provider.dart';
import 'package:lettutor/constants/http.dart';
import 'package:lettutor/models/schedule.dart';
import 'package:lettutor/models/tutor.dart';

class HomeBloc extends ChangeNotifier {
  final _tutorsController = StreamController<List>();
  int totalLearntTime = 0;
  List<Schedule> scheduleList = [];

  Stream<List> get tutorsStream => _tutorsController.stream;

  void initialize(BuildContext context) async {
    getFavoriteTutors(context);
    getTotalTime();
    getLatestSchedule();
  }

  void getFavoriteTutors(BuildContext context) async {
    try {
      var dio = Http().client;
      var query = {
        'perPage': '1',
        'page': '1',
      };
      dio.options.headers["Authorization"] =
          "Bearer ${AppProvider.auth?.tokens?.access?.token}";
      var res = await dio.get(
        "tutor/more",
        queryParameters: query,
      );
      Iterable i = res.data["favoriteTutor"];
      List<Tutor>? result = List<Tutor>.from(
        await Future.wait(
          i.map(
            (tutor) async {
              if (tutor["secondInfo"] != null) {
                String id = tutor["secondId"];
                var tutorRes = await dio.get("tutor/$id");
                var detail = tutorRes.data;
                var data = Tutor.fromJson(detail);
                return data;
              } else {
                return Tutor();
              }
            },
          ),
        ),
      ).where((element) => element.id != null).toList();
      for (final e in result) {
        AppProvider.of(context, listen: false)
            .addFavoriteTutors(e.user == null ? e.userId! : e.user!.id ?? '');
      }
      _tutorsController.sink.add(result);
    } catch (e) {
      inspect(e);
      _tutorsController.addError(e);
    }
  }

  void getTotalTime() async {
    var dio = Http().client;
    dio.options.headers["Authorization"] =
        "Bearer ${AppProvider.auth?.tokens?.access?.token}";
    var res = await dio.get("call/total");
    inspect(res);
    totalLearntTime = res.data["total"].toInt() ?? 0;
    notifyListeners();
  }

  Future<void> getLatestSchedule() async {
    try {
      scheduleList.clear();
      var dio = Http().client;
      dio.options.headers["Authorization"] =
          "Bearer ${AppProvider.auth?.tokens?.access?.token}";
      var query = {
        'page': 1,
        'perPage': 1,
        'dateTimeGte': DateTime.now().millisecondsSinceEpoch,
        'orderBy': 'meeting',
        'sortBy': 'asc'
      };
      var res = await dio.get("booking/list/student", queryParameters: query);
      Iterable i = res.data["data"]["rows"];
      List<Schedule> data =
          List<Schedule>.from(i.map((schedule) => Schedule.fromJson(schedule)));
      scheduleList.addAll(data);
      notifyListeners();
    } catch (e) {
      inspect(e);
    }
  }

  @override
  void dispose() {
    _tutorsController.close();
    super.dispose();
  }
}
