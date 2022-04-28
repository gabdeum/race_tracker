import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../services/colors.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Stack(
        children: [
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(child: Container(
                height: 110,
                decoration: const BoxDecoration(gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: <Color>[Color.fromRGBO(0, 0, 0, 0.5),Colors.transparent]
                )),))
          ),
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
                        child: Stack(
                          children: [
                            SvgPicture.asset('assets/bottom_bar/dashboard.svg'),
                            Positioned(
                                left: 40,
                                top: 6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.dashboard_outlined, size: 25, color: primaryTextColor,),
                                    Text('Dashboard', style: Theme.of(context).textTheme.bodySmall?.merge(const TextStyle(color: primaryTextColor)),)
                                  ],
                                )
                            )
                          ],
                        ),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      InkWell(
                        onTap: (){},
                        child: Stack(
                          children: [
                            SvgPicture.asset('assets/bottom_bar/routes.svg'),
                            Positioned(
                                right: 52,
                                top: 6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.directions, size: 25, color: primaryTextColor,),
                                    Text('Routes', style: Theme.of(context).textTheme.bodySmall?.merge(const TextStyle(color: primaryTextColor)),)
                                  ],
                                )
                            )
                          ],
                        ),
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
          ),
        ],
      ),
    );
  }
}