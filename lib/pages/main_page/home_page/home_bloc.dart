import 'dart:async';

import 'package:lettutor/models/tutor/tutor.dart';
import 'package:lettutor/repositories/tutor_repo.dart' as tutor_repo;
import 'package:lettutor/utils/tutor_utils.dart' as tutor_utils;

class HomeBloc {
  final _tutorsController = StreamController<List<Tutor>>();

  Stream<List<Tutor>> get tutorsStream => _tutorsController.stream;

  void initialize() {
    getTutors();
  }

  void getTutors() async {
    try {
      final tutors = await tutor_repo.fetchAllTutors();
      //Limit to 5 tutor
      _tutorsController
          .add(tutors.sublist(0, 5)..sort(tutor_utils.compareRating));
    } catch (e) {
      _tutorsController.addError(e);
    }
  }

  void dispose() {
    _tutorsController.close();
  }
}
