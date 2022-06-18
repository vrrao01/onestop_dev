import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:onestop_dev/pages/travel/data.dart';

LatLng getLatLngFromRestaurantData(int index) {
  return LatLng(double.parse(BusStops[index]['lat']),
      double.parse(BusStops[index]['long']));
}
