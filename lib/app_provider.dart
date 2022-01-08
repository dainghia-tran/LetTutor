import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/auth.dart';

class AppProvider extends ChangeNotifier {
  List<String> favoriteTutors = [];
  Auth? auth;
  String? _message;

  String? get message {
    final msg = _message;
    message = null;
    return msg;
  }

  set message(String? message) {
    _message = message;
    notifyListeners();
  }

  static AppProvider of(BuildContext context, {listen = true}) {
    return Provider.of<AppProvider>(context, listen: listen);
  }

  void setAuth(Auth auth) async {
    this.auth = auth;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('auth', jsonEncode(auth.toJson()));
  }

  Future<bool> loadAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('auth')) {
      auth = Auth.fromJson(jsonDecode(prefs.getString('auth')!));
      return true;
    }
    return false;
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
