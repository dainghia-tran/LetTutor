import 'package:lettutor/models/tutor/feedback.dart';
import 'package:lettutor/extensions/string_extension.dart';

double getRatingFromFeedbacks(List<Feedback> feedbacks) {
  double rating = 0;
  for (Feedback feedback in feedbacks) {
    rating += feedback.rating ?? 0;
  }
  return rating / feedbacks.length;
}

List<String> getTagsFromSpecialities(String? specialties) {
  if (specialties == null) return [];
  List<String> tags = [];
  specialties.split(',').forEach((speciality) {
    tags.add(speciality.trim().replaceAll('-', ' ').toTitleCase() ?? '');
  });
  return tags;
}
