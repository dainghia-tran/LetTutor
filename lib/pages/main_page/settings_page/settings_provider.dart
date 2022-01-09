import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:lettutor/constants/http.dart';
import 'package:lettutor/models/user.dart';

import '../../../app_provider.dart';

class SettingsProvider extends ChangeNotifier {
  User? user;

  Future<void> getUserDetail() async {
    try {
      var dio = Http().client;
      var accessToken = AppProvider.auth?.tokens?.access?.token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      var res = await dio.get("user/info");

      user = User.fromJson(res.data["user"]);
    } catch (e) {
      inspect(e);
    }
    notifyListeners();
  }
}
