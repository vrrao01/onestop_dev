import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mobx/mobx.dart';
import 'package:onestop_dev/pages/travel/data.dart';
import 'package:onestop_dev/widgets/mapbox/carousel_card.dart';
part 'mapbox_store.g.dart';

class MapBoxStore = _MapBoxStore with _$MapBoxStore;

abstract class _MapBoxStore with Store {
  @observable
  int index = 0;
  double userlat=0;
  double userlong=0;
  int selectedCarouselIndex=-1;
  bool isTravelPage=false;
  List<int>bus_distance=[];
  List<int>bus_distance_to_time=[];
  List<Map> bus_carousel_data = [];
  List<Map>bus_geometry=[];
  late List<Widget> bus_carousel_items;

  @action
  void setIndexMapBox(int i) {
    index = i;
  }

  @action
  void setUserLatLng(double lat,double long){
    userlat=lat;
    userlong=long;
  }
  @action
  void selectedCarousel(int i){
    selectedCarouselIndex= i;
  }
  @action
  void checkTravelPage(bool i){
    isTravelPage=i ;
  }

  @action
  void set_distance_buses(int i,int distance){
    bus_distance[i]=distance;
  }

  @action
  void set_duration_buses(int i,int time){
    bus_distance_to_time[i]=time;
  }

  @action
  void initialiseCarouselforBuses(){
    for (int index = 0; index < BusStops.length; index++) {
      num distance = this.bus_distance[index] / 1000;
      num duration = this.bus_distance_to_time[index] / 60;
      bus_carousel_data
          .add({'index': index, 'distance': distance, 'duration': duration});
    }
    bus_carousel_data.sort((a, b) => a['duration'] < b['duration'] ? 0 : 1);
  }

  @computed
  List<Widget> get buses_carousel{
    List<Widget>l = List<Widget>.generate(
        BusStops.length,
            (index) => carouselCard(
            bus_carousel_data[index]['index'],
            bus_carousel_data[index]['distance'],
            bus_carousel_data[index]['duration'],
            ),
    );
    return l;
  }

  @computed
  List<CameraPosition> get bus_camera_positions{
    // initialize map symbols in the same order as carousel widgets
    List<CameraPosition> kBusStopsList = List<CameraPosition>.generate(
        BusStops.length,
            (index) => CameraPosition(
            target: this.bus_carousel_data[index]['index'],
            zoom: 15),
    );
    return kBusStopsList;
  }


}

