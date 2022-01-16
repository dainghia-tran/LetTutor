import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/constants/http.dart';
import 'package:lettutor/models/tutor.dart';
import 'package:lettutor/pages/tutor_profile_page/book_tutor_page.dart';
import 'package:lettutor/pages/tutor_profile_page/widgets/report_dialog.dart';
import 'package:lettutor/pages/tutor_profile_page/widgets/reviews_dialog.dart';
import 'package:lettutor/utils/tutor_utils.dart' as tutor_utils;
import 'package:lettutor/widgets/button/primary_button.dart';
import 'package:lettutor/widgets/custom_circle_avatar.dart';
import 'package:lettutor/widgets/expandable_text.dart';
import 'package:lettutor/widgets/star_rating_bar.dart';
import 'package:lettutor/widgets/tag.dart';
import 'package:video_player/video_player.dart';

import '../../app_provider.dart';

class TutorProfilePage extends StatefulWidget {
  const TutorProfilePage({
    Key? key,
    required this.tutorId,
  }) : super(key: key);

  final String tutorId;

  @override
  _TutorProfilePageState createState() => _TutorProfilePageState();
}

class _TutorProfilePageState extends State<TutorProfilePage> {
  var _isFavorite = false;
  VideoPlayerController? videoController;
  Future<void>? initializeVideoPlayerFuture;
  Tutor tutor = Tutor();

  @override
  void initState() {
    super.initState();
    getDetail().then((value) {
      if (tutor.video != null) {
        videoController = VideoPlayerController.network(
          tutor.video!,
        );
        initializeVideoPlayerFuture = videoController!.initialize();
        videoController!.setLooping(false);
        videoController!.play();
      }
    });
  }

  @override
  void dispose() {
    videoController?.pause();
    videoController?.dispose();
    super.dispose();
  }

  Future<void> getDetail() async {
    try {
      await FirebaseAnalytics.instance
          .logEvent(name: 'view_tutor_profile', parameters: {
        'tutor_id': widget.tutorId,
      });

      var dio = Http().client;
      var accessToken = AppProvider.auth?.tokens?.access?.token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      var res = await dio.get(
        "tutor/${widget.tutorId}",
      );
      Tutor data = Tutor.fromJson(res.data);
      setState(() {
        tutor = data;
        _isFavorite = data.isFavorite ?? false;
      });
    } catch (e) {
      inspect(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: SizedBox(
            width: 150,
            child: SvgPicture.asset('assets/lettutor_logo.svg',
                semanticsLabel: 'LetTutor logo'),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomCircleAvatar(
                          dimension: 100,
                          avatarUrl:
                              tutor.user?.avatar ?? (tutor.avatar ?? '')),
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tutor.user?.name ?? (tutor.name ?? ""),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            StarRatingBar(
                                stars: tutor.avgRating?.toDouble() ?? 0),
                            SizedBox(
                              width: 200,
                              child: CountryCodePicker(
                                alignLeft: true,
                                initialSelection: tutor.user != null
                                    ? tutor.user!.country!
                                    : (tutor.country ?? ""),
                                showOnlyCountryWhenClosed: true,
                                enabled: false,
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (initializeVideoPlayerFuture != null)
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        FutureBuilder(
                          future: initializeVideoPlayerFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return AspectRatio(
                                aspectRatio: videoController!.value.aspectRatio,
                                child: VideoPlayer(
                                  videoController!,
                                ),
                              );
                            } else {
                              return const Center(
                                child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator()),
                              );
                            }
                          },
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            icon: Icon(
                              videoController!.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                if (videoController!.value.isPlaying) {
                                  videoController!.pause();
                                } else {
                                  videoController!.play();
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  ExpandableText(
                    key: Key(tutor.bio ?? ''),
                    content: tutor.bio ?? "",
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await AppProvider.setFavorite(
                              tutor.user?.id ?? (tutor.userId ?? ''));
                          setState(() {
                            _isFavorite = !_isFavorite;
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              _isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: _isFavorite ? Colors.red : Colors.blue,
                            ),
                            Text(
                              'Favorite',
                              style: TextStyle(
                                  color:
                                      _isFavorite ? Colors.red : Colors.blue),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => ReportDialog(
                              name: tutor.name ?? '',
                              tutorId: tutor.userId ?? tutor.user!.id!,
                            ),
                          );
                        },
                        child: Column(
                          children: const [
                            Icon(
                              Icons.report_outlined,
                              color: Colors.blue,
                            ),
                            Text(
                              'Report',
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => ReviewsDialog(
                                feedbacks:
                                    tutor.user?.feedbacks ?? tutor.feedbacks!),
                          );
                        },
                        child: Column(
                          children: const [
                            Icon(
                              Icons.star_border_rounded,
                              color: Colors.blue,
                            ),
                            Text(
                              'Reviews',
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  PrimaryButton(
                      icon: Icons.check,
                      isDisabled: false,
                      onPressed: () {
                        setState(() {
                          videoController?.pause();
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => BookTutorPage(
                              tutorId: tutor.userId ?? tutor.user!.id!,
                            ),
                          ),
                        );
                      },
                      text: 'Book'),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'Languages',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Wrap(
                      children: tutor.languages
                              ?.split(',')
                              .map((e) => Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 8, 8),
                                    child: Tag(
                                      text: e,
                                      isActive: true,
                                    ),
                                  ))
                              .toList() ??
                          [],
                    ),
                  ),
                  const Text(
                    'Experience',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      tutor.experience ?? '',
                      style: const TextStyle(color: Colors.black45),
                    ),
                  ),
                  const Text(
                    'Education',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      tutor.education ?? '',
                      style: const TextStyle(color: Colors.black45),
                    ),
                  ),
                  const Text(
                    'Interests',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      tutor.interests ?? '',
                      style: const TextStyle(color: Colors.black45),
                    ),
                  ),
                  const Text(
                    'Profession',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      tutor.profession ?? '',
                      style: const TextStyle(color: Colors.black45),
                    ),
                  ),
                  const Text(
                    'Specialities',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Wrap(
                        children: tutor_utils
                            .getTagsFromSpecialities(tutor.specialties)
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                                child: Tag(
                                  text: e,
                                  isActive: true,
                                ),
                              ),
                            )
                            .toList()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
