import 'package:flutter/material.dart';
import 'package:race_tracker/pages/home.dart';
import 'package:race_tracker/pages/record_map.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/' : (context) => const Home(),
    '/record_map' : (context) => const RecordMap()
  },
));