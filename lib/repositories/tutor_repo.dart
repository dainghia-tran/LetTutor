import 'dart:developer';

import 'package:lettutor/constants/http.dart';
import 'package:lettutor/models/tutor.dart';

import '../app_provider.dart';

Future<List<Tutor>> getTutors(int page) async {
  try {
    var dio = Http().client;

    dio.options.headers["Authorization"] =
        "Bearer ${AppProvider.auth?.tokens?.access?.token}";
    var res = await dio.get(
      "tutor/more?perPage=9&page=$page",
    );
    inspect(res.data);
    Iterable i = res.data['tutors']["rows"];
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
              return Tutor.fromJson(tutor);
            }
          },
        ),
      ),
    ).where((element) => element.id != null).toList();
    inspect(result);
    return result;
  } catch (e) {
    inspect(e);
    return [];
  }
}
