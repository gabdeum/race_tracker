import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: const Drawer(),
      body: Stack(
        children: [
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){},
                        child: SvgPicture.asset('assets/bottom_bar/dashboard.svg'),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      InkWell(
                        onTap: (){},
                        child: SvgPicture.asset('assets/bottom_bar/routes.svg'),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0,),
                ],
              )
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                InkWell(
                  onTap: (){},
                  child: SvgPicture.asset('assets/bottom_bar/new_activity.svg'),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                const SizedBox(height: 41.84,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
