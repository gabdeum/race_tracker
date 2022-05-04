import 'package:flutter/material.dart';
import 'package:race_tracker/pages/dashboard.dart';
import 'package:race_tracker/pages/record_map.dart';
import 'package:race_tracker/pages/routes.dart';
import 'package:race_tracker/services/colors.dart';

void main() => runApp(MaterialApp(
  // home: Scaffold(
  //   body: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
  //     Dashboard(),
  //     const BottomBar(),
  //   ],),
  // ),
  initialRoute: '/dashboard',
  routes: {
    '/dashboard' : (context) => Dashboard(),
    '/routes' : (context) => const Routes(),
    '/record_map' : (context) => RecordMap()
    },
  theme: ThemeData(
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontSize: 20.0, color: primaryTextColor, fontWeight: FontWeight.w500),
      titleLarge: TextStyle(fontSize: 20.0, color: secondaryTextColor,),
      titleMedium: TextStyle(fontSize: 16.0, color: secondaryTextColor, height: 1.25,),
      bodyLarge: TextStyle(fontSize: 14.0, color: secondaryTextColor, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(fontSize: 14.0, color: secondaryTextColor),
      bodySmall: TextStyle(fontSize: 12.0, color: secondaryTextColor),
      labelMedium: TextStyle(fontSize: 11.0, color: secondaryTextColor, fontWeight: FontWeight.w300),
    ),
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      color: primaryColor,
      titleTextStyle: TextStyle(fontSize: 20.0, color: primaryTextColor, fontWeight: FontWeight.w500),
      elevation: 0.0,
      centerTitle: true,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: primaryColorDark,
    )
  ),
));

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const Routes(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}