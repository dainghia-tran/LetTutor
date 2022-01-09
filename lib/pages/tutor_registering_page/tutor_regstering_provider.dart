import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/app_provider.dart';
import 'package:lettutor/constants/enum.dart';
import 'package:lettutor/constants/http.dart';
import 'package:provider/provider.dart';

class TutorRegisteringProvider extends ChangeNotifier {
  String name = '';
  String countryCode = '';
  Level _level = Level.Beginner;

  Level get level => _level;

  set level(Level level) {
    _level = level;
    notifyListeners();
  }

  String interests = '';
  String experience = '';
  String? avatarPath;
  String? _videoPath;

  String? get videoPath => _videoPath;

  set videoPath(String? videoPath) {
    _videoPath = videoPath;
    notifyListeners();
  }

  String education = '';
  String profession = '';
  String bio = '';
  String language = '';
  String price = '10000';
  DateTime? birthday;
  List<String> specialties = [];

  static TutorRegisteringProvider of(BuildContext context, {listen = false}) {
    return Provider.of<TutorRegisteringProvider>(context, listen: listen);
  }

  Future<String?> sendRequest() async {
    try {
      var dio = Http().client;
      var accessToken = AppProvider.auth?.tokens?.access?.token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      var formData = FormData.fromMap({
        'name': name,
        'country': countryCode,
        'birthday': DateFormat('yyyy-MM-dd').format(birthday ?? DateTime.now()),
        'interests': interests,
        'education': education,
        'profession': profession,
        'experience': experience,
        'bio': bio,
        'languages': language,
        'targetStudent': level.toString().split('.').last,
        'price': price,
        'specialties': specialties.join(","),
        if (avatarPath != null)
          'avatar': await MultipartFile.fromFile(avatarPath!),
        if (videoPath != null)
          'video': await MultipartFile.fromFile(videoPath!),
      });
      final result = await dio.post('tutor/register', data: formData);
      inspect(result);
      return null;
    } catch (e) {
      inspect(e);
      return (e as DioError).response?.data['message'];
    }
  }
}
