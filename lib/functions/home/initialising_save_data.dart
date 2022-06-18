import 'dart:convert';

import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:onestop_dev/functions/mapbox/get_directions.dart';
import 'package:onestop_dev/main.dart';
import 'package:onestop_dev/pages/travel/data.dart';

void initializeLocationAndSave() async {
  // Ensure all permissions are collected for Locations
  Location _location = Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;

  _serviceEnabled = await _location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await _location.requestService();
  }

  _permissionGranted = await _location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await _location.requestPermission();
  }

  // Get capture the current user location
  LocationData _locationData = await _location.getLocation();
  LatLng currentLatLng =
  LatLng(_locationData.latitude!, _locationData.longitude!);

  // Store the user location in sharedPreferences
  sharedPreferences.setDouble('latitude', _locationData.latitude!);
  sharedPreferences.setDouble('longitude', _locationData.longitude!);

  // Get and store the directions API response in sharedPreferences
  for (int i = 0; i < BusStops.length; i++) {
    Map modifiedResponse = await getDirectionsAPIResponse(currentLatLng, i);
    saveDirectionsAPIResponse(i, json.encode(modifiedResponse));
  }
}