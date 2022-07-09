import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:onestop_dev/models/timetable/registered_courses.dart';
import 'package:onestop_dev/models/timetable/course_model.dart';

class APIService {
  static String restaurantURL = "https://onestop4.free.beeceptor.com/getAllOutlets";

  static Future<List<Map<String, dynamic>>>  getRestaurantData() async {
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
      return [];
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

  String baseUrl = 'https://api.mapbox.com/directions/v5/mapbox';
  String accessToken = dotenv.env['MAPBOX_ACCESS_TOKEN']!;
  String navType = 'cycling';

  Future getCyclingRouteUsingMapbox(LatLng source, LatLng destination) async {
    String url =
        '$baseUrl/$navType/${source.longitude},${source.latitude};${destination.longitude},${destination.latitude}?alternatives=true&continue_straight=true&geometries=geojson&language=en&overview=full&steps=true&access_token=$accessToken';
    try {
      final responseData = await http.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      return responseData.body;
    } catch (e) {
      throw Exception(e);
    }
  }
}
