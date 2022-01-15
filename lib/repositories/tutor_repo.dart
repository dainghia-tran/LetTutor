import 'dart:developer';

import 'package:lettutor/constants/http.dart';
import 'package:lettutor/models/tutor.dart';

import '../app_provider.dart';

Future<List<Tutor>> getTutors(int page, String specialties) async {
  try {
    var dio = Http().client;

    dio.options.headers["Authorization"] =
        "Bearer ${AppProvider.auth?.tokens?.access?.token}";
    dio.options.headers["Content-Type"] = "application/json";
    final payload = {
      "page": page,
      "perPage": 12,
      if (specialties != '')
        'filters': {
          'specialties': [specialties],
        }
    };
    inspect(payload);
    var res = await dio.post(
      "tutor/search",
      data: payload,
    );
    inspect(res.data);
    Iterable i = res.data["rows"];
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
