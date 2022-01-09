import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/app_provider.dart';
import 'package:lettutor/constants/enum.dart';
import 'package:lettutor/constants/http.dart';
import 'package:lettutor/models/user.dart';
import 'package:provider/provider.dart';

class ProfileProvider extends ChangeNotifier {
  User? user;
  bool isLoading = true;

  static ProfileProvider of(BuildContext context, {listen = true}) =>
      Provider.of<ProfileProvider>(context, listen: listen);

  Future<void> getUserDetail() async {
    try {
      var dio = Http().client;
      var accessToken = AppProvider.auth?.tokens?.access?.token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      var res = await dio.get("user/info");

      user = User.fromJson(res.data["user"]);
      isLoading = false;
    } catch (e) {
      inspect(e);
    }
    notifyListeners();
  }

  Future<bool> uploadAvatar(BuildContext context, String imagePath) async {
    try {
      isLoading = true;
      notifyListeners();

      var dio = Http().client;
      var accessToken = AppProvider.auth?.tokens?.access?.token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      inspect(imagePath);
      // String fileName = imagePath.split('/').last;
      var formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(
          imagePath,
          // filename: fileName,
        ),
      });
      await dio.post('user/uploadAvatar', data: formData);
      getUserDetail();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Updated avatar successfully",
          ),
        ),
      );
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Upload failed, please try again",
          ),
        ),
      );
      inspect(e);
      return false;
    }
  }

  Future<void> updatePersonalInfo(BuildContext context, String? name,
      String? phone, String country, String level, DateTime? birthday) async {
    try {
      var dio = Http().client;
      var accessToken = AppProvider.auth?.tokens?.access?.token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      // String fileName = imagePath.split('/').last;
      var data = {
        'name': name ?? "default",
        'phone': phone ?? "000000000",
        'country': country,
        'level': level,
        'birthday': DateFormat('yyyy-MM-dd').format(birthday ?? DateTime.now()),
      };
      await dio.put('user/info', data: data);
      getUserDetail();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Update personal info successfully",
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Update user data failed, please try again",
          ),
        ),
      );
      inspect(e);
    }
  }

  Future<bool> updateTutorInfo(
      String interests,
      String exp,
      String education,
      String profession,
      String bio,
      Level level,
      List specialties,
      String videoPath,
      String language) async {
    try {
      var dio = Http().client;
      var accessToken = AppProvider.auth?.tokens?.access?.token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      var formData = FormData.fromMap({
        "interests": interests,
        "experience": exp,
        "education": education,
        "profession": profession,
        "bio": bio,
        "targetStudent": level.toString().split('.').last,
        "specialties": specialties.join(","),
        "video":
            videoPath.isEmpty ? null : await MultipartFile.fromFile(videoPath),
        "languages": language
      });
      await dio.post('tutor', data: formData);
      return true;
    } catch (e) {
      inspect(e);
      return false;
    }
  }
}
