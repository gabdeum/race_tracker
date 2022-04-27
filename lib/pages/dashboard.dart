import 'package:flutter/material.dart';
import '../services/bottom_bar.dart';
import '../services/carousel.dart';

class Dashboard extends StatelessWidget {

  Dashboard({Key? key}) : super(key: key);

  final Map<String,DateTime?> personalBestTimes = {
    "marathon" : DateTime(1970, 1, 1, 2, 48, 34),
    "halfmarathon" : DateTime(1970, 1, 1, 1, 23, 10),
    "10kRun" : DateTime(1970, 1, 1, 0, 34, 45),
    "5kRun" : DateTime(1970, 1, 1, 0, 16, 25),
    "100kBike" : DateTime(1970, 1, 1, 6, 48, 34),
    "50kBike" : DateTime(1970, 1, 1, 3, 10, 22),
    "2500mSwim" : DateTime(1970, 1, 1, 1, 31, 13),
    "1000mSwim" : DateTime(1970, 1, 1, 0, 44, 10),
  }; 

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: const Drawer(),
      bottomNavigationBar: const BottomBar(),
      body: Column(
        children: [
          CarouselWithIndicator(context: context, trainingTrend: 40, personalBestTimes: personalBestTimes,),
        ],
      )
    );
  }
}