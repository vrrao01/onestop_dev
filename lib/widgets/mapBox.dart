import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:onestop_dev/functions/mapbox/helper.dart';
import 'package:onestop_dev/functions/mapbox/shared_prefs.dart';
import 'package:onestop_dev/main.dart';
import 'package:onestop_dev/pages/travel/data.dart';
import 'package:onestop_dev/stores/mapbox_store.dart';
import 'package:onestop_dev/widgets/mapbox/carousel_card.dart';
import 'package:provider/provider.dart';
import '../globals/my_colors.dart';
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
  late List<CameraPosition> _kBusStopsList;

  // Carousel related
  List<Map> bus_carousel_data = [];
  int page_index = 0;
  bool accessed = false;
  late List<Widget> bus_carousel_items;

  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(target: myPos, zoom: 15);
    _initialiseCarouselforBuses();
  }

  _initialiseCarouselforBuses(){
    for (int index = 0; index < BusStops.length; index++) {
      num distance = getDistanceFromSharedPrefs(index) / 1000;
      num duration = getDurationFromSharedPrefs(index) / 60;
      bus_carousel_data
          .add({'index': index, 'distance': distance, 'duration': duration});
    }
    bus_carousel_data.sort((a, b) => a['duration'] < b['duration'] ? 0 : 1);

    // Generate the list of carousel widgets
    bus_carousel_items = List<Widget>.generate(
        BusStops.length,
            (index) => carouselCard(
            bus_carousel_data[index]['index'],
            bus_carousel_data[index]['distance'],
            bus_carousel_data[index]['duration']));

    // initialize map symbols in the same order as carousel widgets
    _kBusStopsList = List<CameraPosition>.generate(
        BusStops.length,
            (index) => CameraPosition(
            target: getLatLngFromRestaurantData(bus_carousel_data[index]['index']),
            zoom: 15));
  }
  _addSourceAndLineLayer(int index, bool removeLayer) async {
    // Can animate camera to focus on the item
    controller
        .animateCamera(CameraUpdate.newCameraPosition(_kBusStopsList[index]));

    // Add a polyLine between source and destination
    Map geometry = getGeometryFromSharedPrefs(bus_carousel_data[index]['index']);
    final _fills = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "id": 0,
          "properties": <String, dynamic>{},
          "geometry": geometry,
        },
      ],
    };

    // Remove lineLayer and source if it exists
    if (removeLayer == true) {
      await controller.removeLayer("lines");
      await controller.removeSource("fills");
    }

    // Add new source and lineLayer
    await controller.addSource("fills", GeojsonSourceProperties(data: _fills));
    await controller.addLineLayer(
      "fills",
      "lines",
      LineLayerProperties(
        lineColor: Colors.green.toHexStringRGB(),
        lineCap: "round",
        lineJoin: "round",
        lineWidth: 2,
      ),
    );
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  _onStyleLoadedCallback() async {
    for (CameraPosition _kBusStop in _kBusStopsList) {
      await controller.addSymbol(
        SymbolOptions(
          geometry: _kBusStop.target,
          iconSize: 0.2,
          iconImage: busIcon,
        ),
      );
    }
    _addSourceAndLineLayer(0, false);
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(minutes: 1), _getLoctaion);
    return Observer(builder: (context) {
      int selectedIndex = context.read<MapBoxStore>().index;
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Stack(
          children: [
            Container(
              height: 365,
              // width: 350,
              child: MapboxMap(
                accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: _onMapCreated,
                onStyleLoadedCallback: _onStyleLoadedCallback,
                myLocationEnabled: true,
                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
              ),
            ),
            Positioned(
              left: 16,
              top: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      context.read<MapBoxStore>().setIndexMapBox(0);
                    },
                    //padding: EdgeInsets.only(left: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                      child: Container(
                        height: 32,
                        width: 83,
                        color: (selectedIndex == 0) ? lBlue2 : kBlueGrey,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconData(0xe1d5, fontFamily: 'MaterialIcons'),
                              color: (selectedIndex == 0) ? kBlueGrey : kWhite,
                            ),
                            Text(
                              "Bus",
                              style: TextStyle(
                                color:
                                    (selectedIndex == 0) ? kBlueGrey : kWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        context.read<MapBoxStore>().setIndexMapBox(1);
                      });
                    },
                    //padding: EdgeInsets.only(left: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                      child: Container(
                        height: 32,
                        width: 83,
                        color: (selectedIndex == 1) ? lBlue2 : kBlueGrey,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconData(0xefc2, fontFamily: 'MaterialIcons'),
                              color: (selectedIndex == 1) ? kBlueGrey : kWhite,
                            ),
                            Text(
                              "Ferry",
                              style: TextStyle(
                                color:
                                    (selectedIndex == 1) ? kBlueGrey : kWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  (context.read<MapBoxStore>().isTravelPage)
                      ? TextButton(
                          onPressed: () {
                            setState(() {
                              context.read<MapBoxStore>().setIndexMapBox(2);
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                            child: Container(
                              height: 32,
                              width: 83,
                              color: (selectedIndex == 2) ? lBlue2 : kBlueGrey,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.bus_alert,
                                    color: (selectedIndex == 2)
                                        ? kBlueGrey
                                        : kWhite,
                                  ),
                                  Text(
                                    "Food",
                                    style: TextStyle(
                                      color: (selectedIndex == 2)
                                          ? kBlueGrey
                                          : kWhite,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ],
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
    sharedPreferences.setDouble('latitude', _locationData!.latitude!);
    sharedPreferences.setDouble('longitude', _locationData!.longitude!);
  }
}
