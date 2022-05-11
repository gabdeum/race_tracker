import 'package:flutter/material.dart';

import '../services/activity_entry.dart';
import '../widgets/bottom_bar.dart';

class Routes extends StatelessWidget {

  final ActivityEntry? currentActivity;

  const Routes({Key? key, this.currentActivity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routes'),
      ),
      bottomNavigationBar: Hero(
          tag: 'bottomBar',
          child: BottomBar(dashboard: false, currentActivity: currentActivity,)),
      // drawer: const Drawer(),
    );
  }
}
