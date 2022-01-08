import 'dart:async';

import 'package:lettutor/models/tutor.dart';
import 'package:lettutor/repositories/tutor_repo.dart' as tutor_repo;
import 'package:lettutor/utils/tutor_utils.dart' as tutor_utils;

class TutorsBloc {
  List<Tutor> tutors = [];
  final _tutorsController = StreamController<List>();

  Stream<List> get tutorsStream => _tutorsController.stream;

  void initialize() {
    getTutors();
  }

  void getTutors() async {
    try {
      tutors = await tutor_repo.getTutors(1);
      _tutorsController.add(tutors..sort(tutor_utils.compareRating));
    } catch (e) {
      _tutorsController.addError(e);
    }
  }

  void searchTutors(String keyword) {
    _tutorsController.add(tutors
        .where((element) => element.toString().contains(keyword))
        .toList());
  }

  void filterTutorsByTag(String tag) {
    if (tag == 'All') {
      _tutorsController.add(tutors);
    } else {
      _tutorsController.add(tutors
          .where((element) => element.specialties!
              .replaceAll('-', ' ')
              .toLowerCase()
              .contains(tag.toLowerCase()))
          .toList());
    }
  }

  void filterTutorsByCountry(String countryCode) {
    _tutorsController.add(tutors
        .where((element) => element.country?.contains(countryCode) ?? false)
        .toList());
  }

  void dispose() {
    _tutorsController.close();
  }
}
