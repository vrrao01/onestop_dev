import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:onestop_dev/main.dart';
import 'package:onestop_dev/stores/mapbox_store.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MapBox extends StatefulWidget {
  MapBox({Key? key}) : super(key: key);
  @override
  State<MapBox> createState() => _MapBoxState();
}

bool status = false;
DateTime now = DateTime.now();
String formattedTime = DateFormat.jm().format(now);

class _MapBoxState extends State<MapBox> {
  final pointIcon = 'assets/images/pointicon.png';
  final busIcon = 'assets/images/busicon.png';

  late LatLng myPos = LatLng(-37.327154, -59.119667);
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;

  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(target: myPos, zoom: 15);
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(minutes: 1), _getLoctaion);
    return Observer(builder: (context) {
      int selectedIndex = context.read<MapBoxStore>().index;
      return Center(
        child: Container(
          height: 365,
          // width: 350,
          child: MapboxMap(
            accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: _onMapCreated,
            // onStyleLoadedCallback: _onStyleLoadedCallback,

            myLocationEnabled: true,
            myLocationTrackingMode: MyLocationTrackingMode.Tracking,
            minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
            compassViewPosition: CompassViewPosition.TopLeft,
          ),
        ),
      );
    });
  }

  Location location = new Location();
  LocationData? _locationData;
  double lat = 0;
  double long = 0;

  Future<dynamic> _getLoctaion() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      return;
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      return;
    }
    _locationData = await location.getLocation();
    context.read<MapBoxStore>().setUserLatLng(_locationData!.latitude!, _locationData!.longitude!);
  }
}
