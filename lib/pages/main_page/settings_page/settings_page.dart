import 'package:flutter/material.dart';
import 'package:lettutor/pages/advanced_settings_page/advanced_settings_page.dart';
import 'package:lettutor/pages/booking_history_page/booking_history_page.dart';
import 'package:lettutor/pages/courses_page/courses_page.dart';
import 'package:lettutor/pages/login_page/login_page.dart';
import 'package:lettutor/pages/main_page/main_page_bloc.dart';
import 'package:lettutor/pages/main_page/settings_page/settings_provider.dart';
import 'package:lettutor/pages/main_page/settings_page/widgets/setting_item.dart';
import 'package:lettutor/pages/profile_page/profile_page.dart';
import 'package:lettutor/pages/tutor_registering_page/tutor_registering_page.dart';
import 'package:lettutor/pages/view_feedbacks_page/view_feedbacks_page.dart';
import 'package:lettutor/widgets/button/primary_button_rounded.dart';
import 'package:lettutor/widgets/custom_circle_avatar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with AutomaticKeepAliveClientMixin {
  final SettingsProvider _settingsProvider = SettingsProvider();

  @override
  void initState() {
    super.initState();
    _settingsProvider.getUserDetail();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider.value(
      value: _settingsProvider,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Settings',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: [
                Consumer<SettingsProvider>(builder: (_, prov, __) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ))
                        .then((value) => prov.getUserDetail()),
                    child: Row(
                      children: [
                        CustomCircleAvatar(
                            dimension: 75, avatarUrl: prov.user?.avatar ?? ''),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              prov.user?.name ?? '',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              prov.user?.email ?? '',
                              style: const TextStyle(color: Colors.black54),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }),
                const SizedBox(
                  height: 16,
                ),
                Consumer<SettingsProvider>(builder: (_, prov, __) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ViewFeedbacksPage(
                              feedbacks: prov.user?.tutorInfo!.feedbacks ??
                                  prov.user?.feedbacks))),
                      child: const SettingItem(
                          text: 'View Feedbacks',
                          iconData: Icons.person_outlined),
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const BookingHistoryPage())),
                      child: const SettingItem(
                          text: 'Booking History', iconData: Icons.list)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CoursesPage())),
                    child: const SettingItem(
                        text: 'Courses', iconData: Icons.school),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const AdvancedSettingsPage())),
                    child: const SettingItem(
                        text: 'Advanced Settings',
                        iconData: Icons.settings_outlined),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: GestureDetector(
                      onTap: () => navigateAndWaitForResult(context),
                      child: const SettingItem(
                          text: 'Become a tutor',
                          iconData: Icons.emoji_people)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: GestureDetector(
                    onTap: () {
                      launch('https://app.lettutor.com/');
                    },
                    child: const SettingItem(
                        text: 'Our Website', iconData: Icons.language),
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
                const Text('Version 1.0.0'),
                const SizedBox(
                  height: 16,
                ),
                PrimaryButtonRounded(
                    isDisabled: false,
                    onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const LoginPage())),
                    text: 'Log out')
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateAndWaitForResult(BuildContext context) async {
    final result = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const TutorRegisteringPage()));
    if (result == 'done') {
      MainPageBloc.of(context, listen: false).changePage(0);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
