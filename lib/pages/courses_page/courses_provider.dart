import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:lettutor/app_provider.dart';
import 'package:lettutor/constants/http.dart';
import 'package:lettutor/models/category.dart';
import 'package:lettutor/models/course.dart';

class CoursesProvider extends ChangeNotifier {
  int page = 1;
  int size = 2;
  int count = 0;
  List<String> _levelsTag = [
    'All',
    'Beginner',
    'Higher Beginner',
    'Pre-Intermediate',
    'Intermediate',
    'Upper Intermediate',
    'Pre-Advanced',
    'Advanced'
        'Proficiency'
  ];

  List<String> get levelsTag => _levelsTag;

  set levelsTag(List<String> levelsTag) {
    _levelsTag = levelsTag;
    notifyListeners();
  }

  bool _isAscending = true;

  bool get isAscending => _isAscending;

  set isAscending(bool isAscending) {
    _isAscending = isAscending;
    notifyListeners();
  }

  List<int> _selectedLevels = [];

  List<int> get selectedLevels => _selectedLevels;

  set selectedLevels(List<int> selectedLevels) {
    _selectedLevels = selectedLevels;
    notifyListeners();
  }

  List<Category> categories = [];
  List<String> categoriesTags = [];
  List<String> selectedCategories = [];
  List<Course> courseList = [];
  bool isLoading = true;

  Future<void> getCourseList(bool resetList, String keyword) async {
    try {
      if (resetList == true) {
        courseList.clear();
        page = 1;
      }
      isLoading = true;
      notifyListeners();

      var dio = Http().client;
      var accessToken = AppProvider.auth?.tokens?.access?.token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      var query = {
        'page': page,
        'size': size,
        'level': selectedLevels,
        'categoryId': selectedCategories,
        'q': keyword
      };
      var res = await dio.get("course", queryParameters: query);
      Iterable i = res.data["data"]["rows"];
      List<Course> data =
          List<Course>.from(i.map((course) => Course.fromJson(course)));
      courseList.addAll(data);
      count = res.data["data"]["count"];
    } catch (e) {
      inspect(e);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getCategories() async {
    try {
      isLoading = true;
      notifyListeners();

      var dio = Http().client;
      var accessToken = AppProvider.auth?.tokens?.access?.token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      var res = await dio.get(
        "content-category",
      );
      Iterable i = res.data["rows"];
      List<Category> result =
          List<Category>.from(i.map((category) => Category.fromJson(category)));
      categories = result;
      categoriesTags = result.map((ele) => ele.title ?? "").toList();
    } catch (e) {
      inspect(e);
    }
    isLoading = false;
    notifyListeners();
  }

  List<int> convertLevelToIndex(List<String> levels) {
    List<int> result = [];
    for (int i = 0; i < levels.length; i++) {
      int index = levelsTag.indexWhere((element) => element == levels[i]);
      if (index >= 0) {
        result.add(index);
      }
    }
    return result;
  }

  List<String> convertCategoriesToId(List<String> temp) {
    List<String> result = [];
    for (int i = 0; i < temp.length; i++) {
      int index = categories.indexWhere((element) => element.title == temp[i]);
      if (index >= 0 && categories[index].id != null) {
        result.add(categories[index].id ?? "");
      }
    }
    return result;
  }
}
