import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor/pages/profile_page/components/personal_info.dart';
import 'package:lettutor/pages/profile_page/profile_provider.dart';
import 'package:lettutor/widgets/button/primary_button_rounded.dart';
import 'package:lettutor/widgets/custom_circle_avatar.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileProvider _profileProvider = ProfileProvider();
  var countryName = 'Vietnam';

  final List<String> categories = [
    'TOEIC',
    'TOEFL',
    'IELTS',
    'PET',
    'KET',
    'FLYERS'
  ];
  var wantToLearn = 'IELTS';
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _profileProvider.getUserDetail();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _profileProvider,
      child: Scaffold(
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
          title: const Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Consumer<ProfileProvider>(builder: (context, prov, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Consumer<ProfileProvider>(
                                builder: (context, prov, _) {
                              return CustomCircleAvatar(
                                  dimension: 75,
                                  avatarUrl: prov.user?.avatar ?? '');
                            }),
                            Positioned(
                              child: GestureDetector(
                                onTap: () async {
                                  final XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery,
                                  );
                                  if (image != null) {
                                    _profileProvider.uploadAvatar(
                                        context, image.path);
                                  }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    color: Colors.grey,
                                    child: const Center(
                                      child: Icon(Icons.camera_alt),
                                    ),
                                  ),
                                ),
                              ),
                              bottom: 0,
                              right: 0,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          prov.user?.name ?? '',
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          prov.user?.email ?? '',
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: const [
                      Text('Personal Infomation',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      SizedBox(width: 4),
                      Expanded(
                          child: Divider(
                        thickness: 2,
                        color: Colors.grey,
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (prov.user != null) PersonalInfo(user: prov.user!),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
