import 'dart:async';

import 'package:lettutor/models/tutor/tutor.dart';
import 'package:lettutor/repositories/tutor_repo.dart' as tutorRepo;

class HomeBloc {
  final _tutorsController = StreamController<List<Tutor>>();

  Stream<List<Tutor>> get tutorsStream => _tutorsController.stream;

  void initialize() {
    getTutors();
  }

  void getTutors() async {
    final tutors = await tutorRepo.fetchAllTutors();
    _tutorsController.add(tutors as List<Tutor>);
    // try {
    //   final tutors = await tutorRepo.fetchAllTutors();
    //   _tutorsController.add(tutors as List<Tutor>);
    // } catch (e) {
    //   _tutorsController.addError(e);
    // }
  }

  void dispose() {
    _tutorsController.close();
  }
}
