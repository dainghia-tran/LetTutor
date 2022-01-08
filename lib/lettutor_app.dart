import 'package:flutter/material.dart';
import 'package:lettutor/app_provider.dart';
import 'package:lettutor/pages/login_page/login_page.dart';
import 'package:lettutor/pages/main_page/main_page.dart';
import 'package:provider/provider.dart';

class LetTutorApp extends StatelessWidget {
  const LetTutorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Inter'),
        home: Scaffold(
          body: Consumer<AppProvider>(
            builder: (context, appProvider, _) {
              appProvider.loadAuth().then((value) {
                if (value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainPage(),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                }
              });
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
