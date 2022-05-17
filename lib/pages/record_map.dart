import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:location/location.dart';
import 'package:race_tracker/services/display_data.dart';
import 'package:race_tracker/services/activity_entry.dart';
import 'package:race_tracker/services/colors.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../widgets/bottom_bar_record.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../widgets/location_map.dart';

//ignore: must_be_immutable
class RecordMap extends StatefulWidget {

  RecordMap({this.currentActivity, Key? key}) : super(key: key);

  ActivityEntry? currentActivity;

  @override
  State<RecordMap> createState() => _RecordMapState();
}

class _RecordMapState extends State<RecordMap> {

  late Stream<LocationData> locationStream;

  @override
  void initState() {
    askPermission();
    locationStream = getLocationStream();
    widget.currentActivity == null ? widget.currentActivity = ActivityEntry(locationStream: locationStream, onLocationChanged: (){setState(() {});}) : widget.currentActivity?.onLocationChanged = (){setState(() {});};
    super.initState();
  }

  @override
  void dispose() {
    widget.currentActivity?.onLocationChanged = (){};
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final widthScreen = MediaQuery.of(context).size.width;

    locationStream = getLocationStream();

    locationStream.listen((event) {
      print('Hello');});

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Text('Back', style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: primaryTextColor)) ,),
          onPressed: () => Navigator.of(context).pop(widget.currentActivity)
        ),
        title: const Text('Record'),
      ),
      body: Stack(
        children: [
          SlidingUpPanel(
            parallaxOffset: 0.5,
            minHeight: 250,
            maxHeight: 490,
            parallaxEnabled: true,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
            panel: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0.1 * widthScreen),
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 120,
                  child: Stack(
                    children: [
                      Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          DisplayData(title: 'Distance', dataStr: (widget.currentActivity?.activityType ?? 'run') != 'swim' ?
                          '${((widget.currentActivity?.distance ?? 0) / 1000).toStringAsFixed(2)} K' : '${(widget.currentActivity?.distance.round() ?? 0).toString()} m',
                            titleStyle: Theme.of(context).textTheme.bodyMedium, dataStrStyle: Theme.of(context).textTheme.titleLarge,),
                          SizedBox(width: 0.1 * widthScreen,),
                          DisplayData(title: 'Time', dataStr: formatMovingTime(widget.currentActivity?.duration.round() ?? 0),
                            titleStyle: Theme.of(context).textTheme.bodyMedium, dataStrStyle: Theme.of(context).textTheme.titleLarge,),
                        ],),
                        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          DisplayData(title: 'Avg Pace', dataStr: formatPace(widget.currentActivity?.duration.round() ?? 0, widget.currentActivity?.distance.round() ?? 0),
                            titleStyle: Theme.of(context).textTheme.bodyMedium, dataStrStyle: Theme.of(context).textTheme.titleLarge,),
                          SizedBox(width: 0.1 * widthScreen,),
                          DisplayData(title: 'Current Pace', dataStr: formatPace(widget.currentActivity?.duration.round() ?? 0, widget.currentActivity?.distance.round() ?? 0),
                            titleStyle: Theme.of(context).textTheme.bodyMedium, dataStrStyle: Theme.of(context).textTheme.titleLarge,),
                        ],)
                      ],),
                      Positioned(top: 60, left: 0, right: 0 ,child: Container(height: 1,color: const Color.fromRGBO(0, 0, 0, 0.3),)),
                      Positioned(top: 0, bottom: 0, left: widthScreen * 0.4 ,child: Container(width: 1,color: const Color.fromRGBO(0, 0, 0, 0.3),)),
                    ],
                  ),
                ),
              ),
            ),
            body: Image.asset('assets/placeholders/record_map.png')//LocationMap(locationStream: locationStream,)
          ),
          Positioned(bottom: 0,child: BottomBarRecord(
            widthScreen: widthScreen,
            currentActivity: widget.currentActivity,
            callback: (){
              setState(() {});
            },
          )),
        ],
      ),
    );
  }

  Future askPermission() async {

    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print('Location service not enabled');
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('Location denied by user');
      }
    }
  }

  Stream<LocationData> getLocationStream() {

    Location location = Location();
    return location.onLocationChanged;

  }

}

class LocationMap extends StatefulWidget {
  const LocationMap({
    Key? key,
    required this.locationStream,
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
    mapController = MapController();
    super.initState();
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
        (snapshot.data?.longitude != null || snapshot.data?.latitude != null) ? _animatedMapMove(LatLng(snapshot.data!.latitude!, snapshot.data!.longitude!), 10.0) : null;
        return FlutterMap(
          options: MapOptions(
            center: (snapshot.data?.longitude != null || snapshot.data?.latitude != null) ? LatLng(snapshot.data!.latitude!, snapshot.data!.longitude!) : null,
            zoom: 2,
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
                  width: 20.0,
                  height: 20.0,
                  point: LatLng(snapshot.data!.latitude!, snapshot.data!.longitude!),
                  builder: (ctx) =>
                      Container(
                        // height: 20,
                        // width: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColorDark
                        ),
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