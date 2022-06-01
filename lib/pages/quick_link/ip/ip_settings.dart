//import 'dart:html';

// ignore_for_file: file_names, prefer_typing_uninitialized_variables, avoid_print

//import 'package:blogss/hosteldetails.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

import '../../../globals/my_colors.dart';
import '../../../globals/my_fonts.dart';

class IpPage extends StatefulWidget {
  final argso;
  const IpPage({Key? key, required this.argso}) : super(key: key);

  @override
  _IpPageState createState() => _IpPageState();
}

class hostelDetails {
  late String hostelName;
  late String block;
  late String floor;
  late String roomNo;
  hostelDetails(this.hostelName, this.block, this.floor, this.roomNo);
}

String calculatedetails(hostelDetails args, String initials) {
  String block = args.block;
  int W = -1, X = -1, Y = -1, Z = -1;
  switch (block) {
    case "b1":
      W = 0;
      break;
    case "b2":
      W = 1;
      break;
    case "b3":
      W = 2;
      break;
    case "b4":
      W = 3;
      break;
    case "c1":
      W = 4;
      break;
    default:
      W = (block.toLowerCase().codeUnitAt(0) - 97).toInt();
      break;
  }
  var selectedHostel = args.hostelName;
  X = int.parse(args.floor);
  Y = int.parse(args.roomNo);
  if (args.hostelName == "Brahmaputra") {
    if (W == 0 || W == 1) {
      Z = Y;
    } else {
      if (X == 0) {
        Z = Y - 134;
      } else if (X == 1) {
        Z = Y - 119;
      } else if (X == 2) {
        Z = Y - 133;
      } else {
        Z = Y - 131;
      }
    }
  } else {
    Y %= 100;
  }
  String ipAddress;
  if (selectedHostel == "Dhansiri" ||
      selectedHostel == "Lohit" ||
      selectedHostel == "Married Scholars" ||
      selectedHostel == "Dibang") {
    ipAddress = "i dont know";
  } else if (selectedHostel == "Dihing" ||
      selectedHostel == "Kapili" ||
      selectedHostel == "Siang") {
    ipAddress = initials + "." + X.toString() + "." + Y.toString();
  } else if (selectedHostel == "Brahmaputra") {
    if (W != 0) {
      ipAddress =
          initials + "." + W.toString() + X.toString() + "." + Z.toString();
    } else {
      ipAddress = initials + "." + X.toString() + "." + Z.toString();
    }
  } else {
    if (W != 0) {
      ipAddress =
          initials + "." + W.toString() + X.toString() + "." + Y.toString();
    } else {
      ipAddress = initials + "." + X.toString() + "." + Y.toString();
    }
  }

  return ipAddress;
}

class _IpPageState extends State<IpPage> {
  List _items = [];
  var hostel;
  late final args;
  // Fetch content from the json file
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/csvjson.json');
    final data = await json.decode(response);
    setState(() {
      args = widget.argso;

      _items = data["Hostels"];
      for (var item in _items) {
        if (item["Hostel"] == args.hostelName) {
          hostel = item;
          break;
        }
      }
      print(args.hostelName);
    });
  }

  @override
  Widget build(BuildContext context) {
    readJson();

    String hostelname;
    String subnet;
    String ipAdress;
    if (hostel == null) {
      hostelname = "not defined";
      subnet = "255.255.255.255";
      ipAdress = " macfe";
    } else {
      hostelname = hostel["Hostel"];
      subnet = hostel["Subnet mask"];
      ipAdress = hostel["IP Adress Range"];
      int k = 0;
      for (int i = 0; i < ipAdress.length; i++) {
        if (ipAdress[i] == '.') {
          k++;
          if (k == 2) {
            k = i;
            break;
          }
        }
      }
      ipAdress = calculatedetails(args, ipAdress.substring(0, k));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Your details:',
            style: MyFonts.regular.size(18).setColor(kGrey6),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Gateway:       ' + hostelname,
            style: MyFonts.regular.size(16).setColor(kGrey6),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Subnet:         ' + subnet,
            style: MyFonts.regular.size(16).setColor(kGrey6),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'IP Address:   ' + ipAdress,
            style: MyFonts.regular.size(16).setColor(kGrey6),
          ),
        )
      ],
    );
  }
}
