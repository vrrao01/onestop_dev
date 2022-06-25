import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobx/mobx.dart';
import 'package:onestop_dev/pages/travel/data.dart';
import 'package:onestop_dev/widgets/mapbox/carousel_card.dart';
import 'package:location/location.dart';
part 'mapbox_store.g.dart';

class MapBoxStore = _MapBoxStore with _$MapBoxStore;

abstract class _MapBoxStore with Store {
  _MapBoxStore() {
    initialiseCarouselforBuses();
  }
  @observable
  int indexBusesorFerry = 0;
  @observable
  double userlat = 0;
  @observable
  double userlong = 0;
  @observable
  int selectedCarouselIndex = -1;
  @observable
  bool isTravelPage = false;
  // List<int>bus_distance=[];
  // List<int>bus_distance_to_time=[];
  List<Map> bus_carousel_data = [];
  // List<Map>bus_geometry=[];
  late List<Widget> bus_carousel_items;

  @action
  void setIndexMapBox(int i) {
    indexBusesorFerry = i;
  }

  @action
  void setUserLatLng(double lat, double long) {
    userlat = lat;
    userlong = long;
  }

  @action
  void selectedCarousel(int i) {
    selectedCarouselIndex = i;
  }

  @action
  void checkTravelPage(bool i) {
    isTravelPage = i;
  }

  void initialiseCarouselforBuses() {
    autorun((_) {
      for (int index = 0; index < BusStops.length; index++) {
        bus_carousel_data.add({'index': index,'time': BusStops[index]['time'],'lat':BusStops[index]['lat'],'long':BusStops[index]['long'],'status': BusStops[index]['status'],
          'distance': BusStops[index]['distance'],'name':BusStops[index]['name']});
      }
      bus_carousel_data.sort((a, b) => a['time'] < b['time'] ? 0 : 1);
    });
    generate_bus_markers();
  }

  @computed
  List<Widget> get buses_carousel {
    List<Widget> l = List<Widget>.generate(
      bus_carousel_data.length,
      (index) => carouselCard(bus_carousel_data[index]['index'],bus_carousel_data[index]['time']),
    );
    return l;
  }

  // @computed
  // List<CameraPosition> get bus_camera_positions{
  //   // initialize map symbols in the same order as carousel widgets
  //   List<CameraPosition> kBusStopsList = List<CameraPosition>.generate(
  //       BusStops.length,
  //           (index) => CameraPosition(
  //           target: this.bus_carousel_data[index]['index'],
  //           zoom: 15),
  //   );
  //   return kBusStopsList;
  // }

  Location location = new Location();
  LocationData? _locationData;

  @observable
  List<Marker> markers = [];

  @action
  Future<dynamic> getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    this.userlat = _locationData!.latitude!;
    this.userlong = _locationData!.longitude!;
    Marker user_marker = Marker(
      point: LatLng(this.userlat, this.userlong),
      width: 8,
      height: 8,
      builder: (ctx) => Container(
        child: Image.asset(pointIcon),
      ),
    );
    this.markers.add(user_marker);
  }

  @action
  void generate_bus_markers(){
    List<Marker> l =List.generate(this.bus_carousel_data.length, (index)=>
      Marker(
        point: LatLng(this.bus_carousel_data[index]['lat'], this.bus_carousel_data[index]['long']),
        width: 25.0,
        height: 25.0,
        builder: (ctx) => Container(
          child: Image.asset(busIcon),
        ),
      ),
    );
    this.markers=l;
  }

  @action
  void generate_restaraunt_markers(){
    List<Marker> l =List.generate(this.bus_carousel_data.length, (index)=>
        Marker(
          point: LatLng(this.bus_carousel_data[index]['lat'], this.bus_carousel_data[index]['long']),
          width: 25.0,
          height: 25.0,
          builder: (ctx) => Container(
            child: Image.asset(restaurauntIcon),
          ),
        ),
    );
    this.markers=l;
  }

  final pointIcon = 'assets/images/pointicon.png';
  final busIcon = 'assets/images/busicon.png';
  final restaurauntIcon='assets/images/restaurauntIcon.png';
}
