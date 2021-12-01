import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  List<String> favoriteTutors = [];

  static AppProvider of(BuildContext context, {listen = true}) {
    return Provider.of<AppProvider>(context, listen: listen);
  }

  void addFavoriteTutors(String tutorId) {
    favoriteTutors.add(tutorId);
    saveFavoriteTutorsToStorage();
    notifyListeners();
  }

  void removeFavoriteTutors(String tutorId) {
    favoriteTutors.removeWhere((id) => id == tutorId);
    saveFavoriteTutorsToStorage();
    notifyListeners();
  }

  Future<void> saveFavoriteTutorsToStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorite_tutors', favoriteTutors);
  }

  Future<void> loadFavoriteTutor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favoriteTutors = prefs.getStringList('favorite_tutors') ?? [];
  }
}
