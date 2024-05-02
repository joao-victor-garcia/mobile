import 'package:flutter/material.dart';
import 'package:cleaning_tracker/splash.dart';
import 'package:cleaning_tracker/pages/auth/login.dart';
import 'package:cleaning_tracker/pages/home/home.dart';
import 'package:cleaning_tracker/pages/incomeinfo/incomeinfo.dart';
import 'package:cleaning_tracker/pages/profile/profile_screen.dart';
import 'package:cleaning_tracker/pages/weekview/weekview.dart';
import 'package:cleaning_tracker/pages/services/servicescreen.dart';
import 'package:cleaning_tracker/main.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => MyHomePage(),
    '/login': (context) => LoginScreen(),
    '/incomeinfo': (context) => IncomeInfoScreen(),
    '/profile': (context) => ProfileScreen(),
    '/weekview': (context) => WeekViewScreen(),
    '/splash': (context) => SplashScreen(),
    '/service':(context) => ServiceScreen(),
  };
}
