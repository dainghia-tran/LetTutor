import 'package:json_annotation/json_annotation.dart';
import 'package:lettutor/models/topic.dart';

import 'category.dart';

part 'course.g.dart';

@JsonSerializable(explicitToJson: true)
class Course {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  String? description;
  String? imageUrl;
  String? level;
  String? reason;
  String? purpose;
  String? other_details;
  int? default_price;
  int? course_price;
  bool? visible;
  List<Category>? categories;
  List<Topic>? topics;

  Course();
  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
