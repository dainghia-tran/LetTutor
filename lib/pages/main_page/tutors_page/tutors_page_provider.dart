import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:lettutor/models/tutor.dart';
import 'package:lettutor/repositories/tutor_repo.dart' as tutor_repo;
import 'package:lettutor/utils/tutor_utils.dart' as tutor_utils;

class TutorsPageProvider extends ChangeNotifier {
  List<Tutor>? tutors = [];
  final _tutorsController = StreamController<List?>();
  int page = 1;
  bool hasLoadMore = true;
  String currentSpeciality = "";

  Stream<List?> get tutorsStream => _tutorsController.stream;

  void initialize() {
    getTutors(true);
  }

  void getTutors(bool isReset) async {
    try {
      _tutorsController.add(null);
      if (isReset) {
        hasLoadMore = true;
        page = 1;
        final result = await tutor_repo.getTutors(page, currentSpeciality);
        tutors = result;
        if (result.length < 4) {
          hasLoadMore = false;
        }
      } else {
        final result = await tutor_repo.getTutors(page, currentSpeciality);
        tutors?.addAll(result);
        if (result.length < 4) {
          hasLoadMore = false;
        }
      }
      page++;
      _tutorsController.add(tutors?..sort(tutor_utils.compareRating));
    } catch (e) {
      _tutorsController.addError(e);
    }
  }

  void searchTutors(String keyword) {
    _tutorsController.add(tutors
        ?.where((element) => element.toString().contains(keyword))
        .toList());
  }

  void filterTutorsByTag(String tag) {
    page = 1;
    if (tag == 'All') {
      currentSpeciality = "";
      getTutors(true);
    } else {
      currentSpeciality = tag.toLowerCase().replaceAll(' ', '-');
      getTutors(true);
    }
  }

  void filterTutorsByCountry(String countryCode) {
    _tutorsController.add(tutors
        ?.where((element) => element.country?.contains(countryCode) ?? false)
        .toList());
  }

  void dispose() {
    _tutorsController.close();
  }
}
