import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import '../services/colors.dart';

class LocationMap extends StatefulWidget {
  const LocationMap({
    required this.locationStream,
    Key? key
  }) : super(key: key);

  final Stream<LocationData> locationStream;

  @override
  State<LocationMap> createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap>
    with TickerProviderStateMixin{

  late final MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(begin: mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(begin: mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<LocationData>(
        stream: widget.locationStream,
        builder: (context, snapshot) {
          (snapshot.data?.longitude != null && snapshot.data?.latitude != null) ? _animatedMapMove(LatLng(snapshot.data!.latitude!, snapshot.data!.longitude!), 16.0) : null;
          // (snapshot.data?.longitude != null && snapshot.data?.latitude != null) ? mapController.move(LatLng(snapshot.data!.latitude!, snapshot.data!.longitude!), 16.0) : null;
          return FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: (snapshot.data?.longitude != null || snapshot.data?.latitude != null) ? LatLng(snapshot.data!.latitude!, snapshot.data!.longitude!) : LatLng(0, 0),
              zoom: 3,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: "https://api.mapbox.com/styles/v1/gabdeum/cl349btvk005i14ql6zqt0pgy/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZ2FiZGV1bSIsImEiOiJjbDF4OXo2ZWswMHJnM21xb2U1bGY5MHVhIn0.t_cdWXNtOO8Y1bOfU9RpyQ",
                additionalOptions: {
                  'accessToken': 'pk.eyJ1IjoiZ2FiZGV1bSIsImEiOiJjbDF4OXo2ZWswMHJnM21xb2U1bGY5MHVhIn0.t_cdWXNtOO8Y1bOfU9RpyQ',
                  'id': 'mapbox.mapbox-streets-v8'
                },
              ),
              (snapshot.data?.longitude != null || snapshot.data?.latitude != null) ? MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 70.0,
                    height: 70.0,
                    point: LatLng(snapshot.data!.latitude!, snapshot.data!.longitude!),
                    builder: (ctx) =>
                        Stack(
                          children: [
                            Center(
                              child: Container(
                                height: 24,
                                width: 24,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                height: 18,
                                width: 18,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primaryColorDark
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                height: 70,
                                width: 70,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(26, 90, 255, 0.3)
                                ),
                              ),
                            ),
                          ],
                        ),
                  ),
                ],
              ) : MarkerLayerOptions(),
            ],
          );
        }
    );
  }
}