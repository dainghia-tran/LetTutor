import 'package:flutter/material.dart';
import 'package:lettutor/pages/main_page/home_page/home_page.dart';
import 'package:lettutor/pages/main_page/main_page_bloc.dart';
import 'package:lettutor/pages/main_page/message_page/message_page.dart';
import 'package:lettutor/pages/main_page/settings_page/settings_page.dart';
import 'package:lettutor/pages/main_page/tutors_page/tutors_page.dart';
import 'package:lettutor/pages/main_page/upcoming_page/upcoming_page.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> pages = [
    const HomePage(),
    const MessagePage(),
    const UpcomingPage(),
    const TutorsPage(),
    const SettingsPage()
  ];

  late PageController _pageController;
  var _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentPageIndex = 0;
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainPageBloc(),
      child: Consumer<MainPageBloc>(builder: (context, bloc, child) {
        if (_pageController.hasClients &&
            bloc.currentPageIndex != _pageController.page?.floor()) {
          _pageController.jumpToPage(bloc.currentPageIndex);
        }
        return Scaffold(
          body: PageView(
            controller: _pageController,
            children: pages,
            onPageChanged: (index) => MainPageBloc.of(context, listen: false).changePage(index),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.black26,
            selectedItemColor: Colors.blue,
            type: BottomNavigationBarType.fixed,
            currentIndex: MainPageBloc.of(context).currentPageIndex,
            onTap: (index) {
              MainPageBloc.of(context, listen: false).changePage(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.message_outlined),
                  activeIcon: Icon(Icons.message),
                  label: 'Message'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.access_time_outlined),
                  activeIcon: Icon(Icons.access_time),
                  label: 'Upcoming'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people_outlined),
                  activeIcon: Icon(Icons.people),
                  label: 'Tutors'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined),
                  activeIcon: Icon(Icons.settings),
                  label: 'Settings'),
            ],
          ),
        );
      }),
    );
  }
}
