import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor/constants/enum.dart';
import 'package:lettutor/models/user.dart';
import 'package:lettutor/pages/profile_page/components/tag_list_selector.dart';
import 'package:lettutor/pages/profile_page/profile_provider.dart';
import 'package:lettutor/widgets/button/primary_button.dart';
import 'package:lettutor/widgets/button/secondary_button.dart';
import 'package:video_player/video_player.dart';

class TutorInfo extends StatefulWidget {
  const TutorInfo({Key? key, required this.user}) : super(key: key);

  final User user;
  @override
  _TutorInfoState createState() => _TutorInfoState();
}

class _TutorInfoState extends State<TutorInfo> {
  Level? _level = Level.Beginner;
  final tutorInfoForm = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  VideoPlayerController? videoController;
  Future<void>? initializeVideoPlayerFuture;
  Future<void>? initializeNewVideoPlayer;
  User? userData;
  var _interestsController;
  var _educationController;
  var _expController;
  var _professionController;
  var _bioController;
  String? language;
  String videoPath = "";
  List<String> specialties = [];
  var tagsList = [
    "business-english",
    "conversational-english",
    "english-for-kids",
    "ielts",
    "toeic",
    "starters",
    "movers",
    "flyers",
    "ket",
    "pet",
    "toefl"
  ];
  @override
  void initState() {
    super.initState();
    setState(() {
      userData = widget.user;
      _bioController = TextEditingController(text: userData!.tutorInfo!.bio);
      _interestsController =
          TextEditingController(text: userData!.tutorInfo!.interests);
      _educationController =
          TextEditingController(text: userData!.tutorInfo!.education);
      _expController =
          TextEditingController(text: userData!.tutorInfo!.experience);
      _professionController =
          TextEditingController(text: userData!.tutorInfo!.profession);
      language = userData!.tutorInfo!.languages;
      specialties = userData!.tutorInfo!.specialties!.split(",");

      String? level = userData!.level;
      if (level!.toLowerCase() == "beginner") {
        _level = Level.Beginner;
      } else if (level.toLowerCase() == "intermediate") {
        _level = Level.Intermediate;
      } else {
        _level = Level.Advanced;
      }
      videoController = VideoPlayerController.network(
        userData!.tutorInfo!.video!,
      );
      initializeVideoPlayerFuture = videoController!.initialize();
      videoController!.setLooping(true);
      videoController!.play();
    });
  }

  @override
  void dispose() {
    _bioController.dispose();
    _interestsController.dispose();
    _educationController.dispose();
    _expController.dispose();
    _professionController.dispose();

    videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: tutorInfoForm,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Students will view this information on your profile to decide if you\'re a good fit for them.',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  labelText: 'Interests',
                ),
                minLines: 3,
                maxLines: 5,
                controller: _interestsController,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  hintMaxLines: 5,
                  labelText: 'Education',
                ),
                controller: _educationController,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Experience',
                ),
                minLines: 3,
                maxLines: 5,
                controller: _expController,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Profession',
                ),
                minLines: 3,
                maxLines: 5,
                controller: _professionController,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  const Text('Language'),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black12,
                          width: 1,
                        ),
                      ),
                      child: CountryCodePicker(
                        onChanged: (CountryCode countryCode) {
                          setState(() {
                            language = countryCode.toString();
                          });
                        },
                        initialSelection: language,
                        showOnlyCountryWhenClosed: true,
                        showCountryOnly: true,
                        alignLeft: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  labelText: 'Introduction',
                ),
                minLines: 2,
                maxLines: 5,
                controller: _bioController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'I am best at teaching students who are',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16),
                  ),
                  ListTile(
                    title: const Text('Beginner'),
                    leading: Radio<Level>(
                      value: Level.Beginner,
                      groupValue: _level,
                      onChanged: (Level? value) {
                        setState(() {
                          _level = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Intermediate'),
                    leading: Radio<Level>(
                      value: Level.Intermediate,
                      groupValue: _level,
                      onChanged: (Level? value) {
                        setState(() {
                          _level = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Advanced'),
                    leading: Radio<Level>(
                      value: Level.Advanced,
                      groupValue: _level,
                      onChanged: (Level? value) {
                        setState(() {
                          _level = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(bottom: 8),
              child: const Text(
                'My specialties are',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: TagsListSelector(
                tagsList: tagsList,
                selectFirstItem: false,
                onSelectedList: (s) {
                  setState(() {
                    specialties = s;
                  });
                },
                defaultSelected: specialties,
              ),
            ),
            const Divider(),
            const Text(
              'Introduction video',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SecondaryButton(
              isDisabled: false,
              onPressed: () async {
                final XFile? video =
                    await picker.pickVideo(source: ImageSource.gallery);
                if (video != null) {
                  setState(() {
                    videoPath = video.path;
                    videoController =
                        VideoPlayerController.file(File(video.path));
                    initializeNewVideoPlayer = videoController?.initialize();
                    videoController?.setLooping(true);
                    videoController?.play();
                  });
                }
              },
              text: 'Choose video',
            ),
            const SizedBox(height: 8),
            if (initializeVideoPlayerFuture != null)
              FutureBuilder(
                future: initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AspectRatio(
                      aspectRatio: videoController!.value.aspectRatio,
                      child: VideoPlayer(videoController!),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: 150,
                  child: PrimaryButton(
                    isDisabled: false,
                    onPressed: () async {
                      if (tutorInfoForm.currentState!.validate()) {
                        const snackBar = SnackBar(
                          content: Text('Updating, please wait...'),
                          duration: Duration(minutes: 10),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        final result =
                            await ProfileProvider.of(context, listen: false)
                                .updateTutorInfo(
                          _interestsController.text,
                          _expController.text,
                          _educationController.text,
                          _professionController.text,
                          _bioController.text,
                          _level ?? Level.Beginner,
                          specialties,
                          videoPath,
                          language ?? 'English',
                        );
                        if (result) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Update tutor info successfully",
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Update tutor data failed, try again later",
                              ),
                            ),
                          );
                        }
                      }
                    },
                    text: 'Save changes',
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
