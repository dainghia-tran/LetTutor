import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:lettutor/pages/booking_history_page/booking_history_page.dart';
import 'package:lettutor/pages/courses_page/courses_page.dart';
import 'package:lettutor/pages/ebooks_page/ebooks_page.dart';
import 'package:lettutor/pages/main_page/main_page_bloc.dart';
import 'package:lettutor/pages/main_page/settings_page/widgets/setting_item.dart';
import 'package:lettutor/pages/profile_page/profile_page.dart';
import 'package:lettutor/pages/session_history_page/session_history_page.dart';
import 'package:lettutor/pages/tutor_registering_page/tutor_registering_page.dart';
import 'package:lettutor/widgets/button/primary_button_rounded.dart';
import 'package:lettutor/widgets/custom_circle_avatar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
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
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                )),
                child: Row(
                  children: [
                    const CustomCircleAvatar(
                        dimension: 75,
                        avatarUrl:
                            'https://cdn.dribbble.com/users/1003944/screenshots/10412487/dribbble_angry_4x.gif?compress=1&resize=400x300'),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Dai Nghia Tran',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'dainghia@gmail.com',
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: SettingItem(
                    text: 'View Feedbacks', iconData: Icons.person_outlined),
              ),
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
                      builder: (context) => const SessionHistoryPage())),
                  child: const SettingItem(
                      text: 'Session History', iconData: Icons.history),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CoursesPage())),
                  child: const SettingItem(
                      text: 'Courses', iconData: Icons.school),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EBooksPage())),
                  child: const SettingItem(
                      text: 'E-books', iconData: Icons.menu_book),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: SettingItem(
                    text: 'Advanced Settings',
                    iconData: Icons.settings_outlined),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: GestureDetector(
                    onTap: () => navigateAndWaitForResult(context),
                    child: const SettingItem(
                        text: 'Become a tutor', iconData: Icons.emoji_people)),
              ),
              const SizedBox(
                height: 32,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child:
                    SettingItem(text: 'Our Website', iconData: Icons.language),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: SettingItem(
                    text: 'Facebook', iconData: Boxicons.bxl_facebook_circle),
              ),
              const SizedBox(
                height: 48,
              ),
              const Text('Version 1.0.0'),
              const SizedBox(
                height: 16,
              ),
              PrimaryButtonRounded(
                  isDisabled: false, onPressed: () {}, text: 'Log out')
            ],
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
