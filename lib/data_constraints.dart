import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Route createCustomRoute(Widget path, {dynamic data}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => path,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    settings: RouteSettings(
      arguments: data, // Pass the data as arguments to the new route
    ),
  );
}

var appVersion = '1.0.0';

class Constants {
  static SharedPreferences? prefs;
}

class MyData {
  final String imageAsset;
  final String title;

  MyData({
    required this.imageAsset,
    required this.title,
  });
}

enum UserData { isLoggedIn, name, email, steps, suid, cropped }
