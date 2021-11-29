import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:lettutor/models/tutor/tutor.dart';

Future<List<Tutor>> fetchAllTutors() async {
  String tutorsFromFile =
      await rootBundle.loadString('assets/offline_data/tutors.json');

  List<Tutor> tutors = (json.decode(tutorsFromFile) as List)
      .map((tutor) => Tutor.fromJson(tutor))
      .toList();
  return tutors;
}
