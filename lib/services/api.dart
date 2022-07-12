import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:onestop_dev/models/timetable/registered_courses.dart';
import 'package:onestop_dev/models/timetable/course_model.dart';

class APIService {
  static String restaurantURL = "https://onestop4.free.beeceptor.com/getAllOutlets";

  static Future<List<Map<String, dynamic>>> getRestaurantData() async {
    http.Response response = await http.get(Uri.parse(restaurantURL));
    var status = response.statusCode;
    var body = jsonDecode(response.body);
    print("Sending GET request to $restaurantURL");
    if (status == 200) {
      List<Map<String, dynamic>> data = [];
      for (var json in body) {
        data.add(json);
      }
      return data;
    } else {
      print(status);
      throw Exception("Data could not be fetched");
    }
  }

  static String contactURL = "https://contacts.free.beeceptor.com/contact";

  static Future<List<Map<String, dynamic>>> getContactData() async {
    http.Response response = await http.get(Uri.parse(contactURL));
    var status = response.statusCode;
    var body = jsonDecode(response.body);
    print("Sending GET request to $contactURL");
    if (status == 200)
    {
      List<Map<String, dynamic>> data = [];
      for (var json in body)
      {
        data.add(json);
      }
      return data;
    }
    else
    {
      print(status);
      throw Exception("contact Data could not be fetched");
    }
  }

  static Future<RegisteredCourses> getTimeTable({required String roll}) async {
    final response = await http.post(
      Uri.parse('https://hidden-depths-09275.herokuapp.com/get-my-courses'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        "roll_number": roll,
      }),
    );
    if (response.statusCode == 200) {
      return RegisteredCourses.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      throw Exception(response.statusCode);
    }
  }

  static Future<List<LatLng>> getPolyline ({required LatLng source, required LatLng dest}) async {
    final response = await http.get(
      Uri.parse('https:// api.openrouteservice.org /v2/directions/driving-car? api_key = 5b3ce3597851110001cf6248b144cc92443247b7b9e0bd5df85012f2& start = ${source.latitude},${source.longitude}& end = ${dest.latitude},${dest.longitude}'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      List<LatLng>res=[];
      // print(body['features'][0]['geometry']['coordinates'][0]);
      // for(var r in body['features'][0]['geometry']['coordinates'][0]){
      //   res.add(LatLng(r[0], r[1]));
      // }
      return res;
    } else {
      print(response.statusCode);
      throw Exception(response.statusCode);
    }
  }
}
