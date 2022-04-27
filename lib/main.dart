import 'package:flutter/material.dart';
import 'package:race_tracker/pages/dashboard.dart';
import 'package:race_tracker/pages/home.dart';
import 'package:race_tracker/pages/record_map.dart';
import 'package:race_tracker/services/colors.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/' : (context) => Dashboard(),
    '/record_map' : (context) => const RecordMap()
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