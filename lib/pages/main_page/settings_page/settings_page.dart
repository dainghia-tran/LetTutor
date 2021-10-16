import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:lettutor/pages/main_page/settings_page/widgets/setting_item.dart';
import 'package:lettutor/pages/profile_page/profile_page.dart';
import 'package:lettutor/widgets/button/primary_button_rounded.dart';
import 'package:lettutor/widgets/custom_circle_avatar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfilePage(),)),
                child: Row(
                  children: [
                      const CustomCircleAvatar(dimention: 75, avatarUrl: 'https://cdn.dribbble.com/users/1003944/screenshots/10412487/dribbble_angry_4x.gif?compress=1&resize=400x300'),
                    const SizedBox(width: 8,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Dai Nghia Tran', style: TextStyle(fontSize: 16),),
                        Text('dainghia@gmail.com', style: TextStyle(color: Colors.black54),)
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16,),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: SettingItem(text: 'View Feedbacks', iconData: Icons.person_outlined),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: SettingItem(text: 'Booking History', iconData: Icons.list),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: SettingItem(text: 'Session History', iconData: Icons.history),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: SettingItem(text: 'Advanced Settings', iconData: Icons.settings_outlined),
              ),
              const SizedBox(height: 32,),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: SettingItem(text: 'Our Website', iconData: Icons.language),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: SettingItem(text: 'Facebook', iconData: Boxicons.bxl_facebook_circle),
              ),
              const SizedBox(height: 48,),
              const Text('Version 1.0.0'),
              const SizedBox(height: 16,),
              PrimaryButtonRounded(isDisabled: false, onPressed: (){}, text: 'Log out')
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
