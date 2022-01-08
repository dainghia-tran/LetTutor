import 'package:lettutor/extensions/string_extension.dart';
// import 'package:lettutor/models/tutor/feedback.dart';
// import 'package:lettutor/models/tutor/tutor.dart';

// double getRatingFromFeedbacks(List<Feedback> feedbacks) {
//   double rating = 0;
//   for (Feedback feedback in feedbacks) {
//     rating += feedback.rating ?? 0;
//   }
//   return rating / feedbacks.length;
// }

// List<String> getTagsFromSpecialities(String? specialties) {
//   if (specialties == null) return [];
//   List<String> tags = [];
//   specialties.split(',').forEach((speciality) {
//     tags.add(speciality.trim().replaceAll('-', ' ').toTitleCase() ?? '');
//   });
//   return tags;
// }

// int compareRating(Tutor a, Tutor b) {
//   double ratingA = getRatingFromFeedbacks(a.feedbacks ?? []);
//   double ratingB = getRatingFromFeedbacks(b.feedbacks ?? []);

//   try {
//     return (ratingA - ratingB).round();
//   } catch (err) {
//     return 0;
//   }
// }
