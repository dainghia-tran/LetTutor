import 'dart:async';

import 'package:lettutor/models/tutor/tutor.dart';
import 'package:lettutor/repositories/tutor_repo.dart' as tutor_repo;
import 'package:lettutor/utils/tutor_utils.dart' as tutor_utils;

class TutorsBloc {
  final _tutorsController = StreamController<List<Tutor>>();
  final _tutorFilterController = StreamController<String>();

  Stream<List<Tutor>> get tutorsStream => _tutorsController.stream;
  Stream<String> get filterStream => _tutorFilterController.stream;

  void initialize() {
    getTutors();
  }

  void getTutors() async {
    try {
      final tutors = await tutor_repo.fetchAllTutors();
      _tutorsController.add(tutors..sort(tutor_utils.compareRating));
    } catch (e) {
      _tutorsController.addError(e);
    }
  }

  void dispose() {
    _tutorsController.close();
    _tutorFilterController.close();
  }
}
