import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trainertimer/User/page/profile_page.dart';
import 'package:trainertimer/User/themes.dart';
import 'package:trainertimer/User/utils/user_preferences.dart';

Future MainUser() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await UserPreferences.init();



  runApp(MainUserApp());
}

class MainUserApp extends StatelessWidget {
  static final String title = 'User Profile';

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.getUser();

    return ThemeProvider(
      initTheme: user.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeProvider.of(context),
          title: title,
          home: ProfilePage(),
        ),
      ),
    );
  }
}
