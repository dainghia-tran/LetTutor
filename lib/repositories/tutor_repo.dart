import 'dart:convert';

import 'package:lettutor/models/tutor/tutor.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<List> fetchAllTutors() async {
  String tutorsFromFile =
      await rootBundle.loadString('assets/offline_data/tutors.json');

  List<Tutor> tutors = (json.decode(tutorsFromFile) as List)
      .map((tutor) => Tutor.fromJson(tutor))
      .toList();
  return tutors;
}
