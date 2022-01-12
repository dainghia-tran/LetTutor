import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/http.dart';
import 'models/auth.dart';

class AppProvider extends ChangeNotifier {
  List<String> favoriteTutors = [];
  static Auth? auth;
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

  void setAuth(Auth newAuth) async {
    auth = newAuth;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('auth', jsonEncode(newAuth.toJson()));
  }

  Future<bool> loadAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('auth')) {
      auth = Auth.fromJson(jsonDecode(prefs.getString('auth')!));
      return true;
    }
    return false;
  }

  static Future<void> setFavorite(String id) async {
    try {
      var dio = Http().client;
      dio.options.headers["Authorization"] =
          "Bearer ${auth?.tokens?.access?.token}";
      final result = await dio.post(
        "user/manageFavoriteTutor",
        data: {'tutorId': id},
      );
      inspect(result);
    } catch (e) {
      inspect(e);
    }
  }
}
