import 'package:flutter/material.dart';

import '../widgets/bottom_bar.dart';

class Routes extends StatelessWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routes'),
      ),
      bottomNavigationBar: const Hero(
          tag: 'bottomBar',
          child: BottomBar(dashboard: false)),
      // drawer: const Drawer(),
    );
  }
}
