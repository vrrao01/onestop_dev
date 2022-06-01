import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../../../globals/days.dart';
import '../../../../globals/my_colors.dart';
import '../../../../globals/my_fonts.dart';
import '../../../../models/timetable.dart';
import '../../../../stores/login_store.dart';
import 'helper_functions/addwidget.dart';


DateTime now = DateTime.now();
DateTime day1 = now.add(Duration(days: 1));
DateTime day2 = now.add(Duration(days: 2));
DateTime day3 = now.add(Duration(days: 3));
DateTime day4 = now.add(Duration(days: 4));
List<DateTime> dates = [now, day1, day2, day3, day4,];

class TimeTable1 extends StatefulWidget {
  static const String id = 'time';
  const TimeTable1({Key? key}) : super(key: key);
  @override
  State<TimeTable1> createState() => _TimeTable1State();
}

Map<int, List<List<String>>> Data1 = {};
Map<int, List<List<String>>> Data2 = {};

class _TimeTable1State extends State<TimeTable1> {
  int select = 0;
  int sel = -1;
  int sele = -1;

  @override
  Widget build(BuildContext context) {
    Future<Time> timetable = ApiCalling().getTimeTable(
        roll: context.read<LoginStore>().userData["rollno"] ?? "200101095");
    determiningSel();
    adjustTime();
    return FutureBuilder<Time>(
      future: timetable,
      builder: (BuildContext context, AsyncSnapshot<Time> snapshot) {
        if (snapshot.hasData) {
          addWidgets(data: snapshot.data!);
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 130,
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 4),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                select = index;
                              });
                            },
                            child: FittedBox(
                              child: Container(
                                height: 125,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: (select == index)
                                      ? Color.fromRGBO(101, 174, 130, 0.16)
                                      : Colors.transparent,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FittedBox(
                                          child: Text(
                                              kday[dates[index].weekday]!,
                                              style: MyFonts.medium.size(20).setColor(kWhite))
                                      ),
                                      FittedBox(
                                          child: Text(
                                            dates[index].day.toString(),
                                            style: MyFonts.extraBold.size(40).setColor(kWhite),
                                          )
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(height: 10,),
                ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: Data1[dates[select].weekday]!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: (sel == index)
                                ? Color.fromRGBO(101, 174, 130, 0.16) : Color.fromRGBO(120, 120, 120, 0.16),
                            border: (sel == index)
                                ? Border.all(color: Colors.blueAccent) : Border.all(color: Colors.transparent),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 50, width: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue,
                                        ),
                                        child: Image.asset('assets/images/class.png'),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        Data1[dates[select].weekday]![index][0],
                                        style: MyFonts.light.size(12).setColor(kWhite),
                                      ),
                                      SizedBox(height: 5.0,),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              Data1[dates[select].weekday]![index][1],
                                              style: MyFonts.medium.size(15).setColor(kWhite),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 3.0,),
                                      Row(
                                        children: [
                                          Text(
                                            Data1[dates[select].weekday]![index][2],
                                            style: MyFonts.light.size(13).setColor(Color.fromRGBO(212, 227, 255, 100)),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(height: 2,),
                Row(children: <Widget>[
                  Expanded(child: Divider(color: Colors.white,)),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Lunch Break',
                      style: MyFonts.medium.size(12).setColor(Colors.white),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.white,)),
                ]),
                SizedBox(height: 2,),
                ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: Data2[dates[select].weekday]!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: (sel == index)
                                ? Color.fromRGBO(101, 174, 130, 0.16)
                                : Color.fromRGBO(120, 120, 120, 0.16),
                            border: (sel == index)
                                ? Border.all(color: Colors.blueAccent)
                                : Border.all(color: Colors.transparent),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 50, width: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue,
                                        ),
                                        child: Image.asset('assets/images/class.png'),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        Data2[dates[select].weekday]![index][0],
                                        style: MyFonts.light.size(12).setColor(kWhite),
                                      ),
                                      SizedBox(height: 5.0,),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              Data2[dates[select].weekday]![index][1],
                                              style: MyFonts.medium.size(15).setColor(kWhite),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            Data2[dates[select].weekday]![index][2],
                                            style: MyFonts.light.size(13).setColor(Color.fromRGBO(212, 227, 255, 100)),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(height: 10,),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          Future.delayed(Duration.zero, () => _reload());
          return Column(
            children: [
              Container(
                height: 130,
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              select = index;
                            });
                          },
                          child: FittedBox(
                            child: Container(
                              height: 125,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: (select == index)
                                    ? Color.fromRGBO(101, 174, 130, 0.16)
                                    : Colors.transparent,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FittedBox(
                                        child: Text(kday[dates[index].weekday]!,
                                            style: MyFonts.medium.size(20).setColor(kWhite))),
                                    FittedBox(
                                        child: Text(
                                          dates[index].day.toString(),
                                          style: MyFonts.extraBold.size(40).setColor(kWhite),
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          );
        } else return Center(child: CircularProgressIndicator(),);
      },
    );
  }



  determiningSel() {
    DateTime now1 = DateTime.now();
    if (now1.hour < 10 && now1.minute < 56) {
      setState(() {
        sel = 0;
      });
    } else if (now1.hour >= 10 && now1.hour < 11 && now1.minute < 56) {
      setState(() {
        sel = 1;
      });
    } else if (now1.hour >= 11 && now1.hour < 12 && now1.minute < 56) {
      setState(() {
        sel = 2;
      });
    } else if (now1.hour >= 12 && now1.hour < 13 && now1.minute < 56) {
      setState(() {
        sel = 3;
      });
    } else {
      setState(() {
        sel = -1;
      });
    }

    if (now1.hour >= 14 && now1.hour < 15 && now1.minute < 56) {
      setState(() {
        sele = 0;
      });
    } else if (now1.hour >= 15 && now1.hour < 16 && now1.minute < 56) {
      setState(() {
        sele = 1;
      });
    } else if (now1.hour >= 16 && now1.hour < 17 && now1.minute < 56) {
      setState(() {
        sele = 2;
      });
    } else if (now1.hour >= 17 && now1.hour < 18 && now1.minute < 56) {
      setState(() {
        sele = 3;
      });
    } else {
      setState(() {
        sele = -1;
      });
    }
  }

  adjustTime() {
    dates[0] = DateTime.now();
    if (dates[0].weekday == 2) {
      dates[4] = dates[3].add(Duration(days: 3));
    } else if (dates[0].weekday == 3) {
      dates[3] = dates[2].add(Duration(days: 3));
      dates[4] = dates[3].add(Duration(days: 1));
    } else if (dates[0].weekday == 4) {
      dates[2] = dates[1].add(Duration(days: 3));
      dates[3] = dates[2].add(Duration(days: 1));
      dates[4] = dates[3].add(Duration(days: 1));
    } else if (dates[0].weekday == 5) {
      dates[1] = dates[0].add(Duration(days: 3));
      dates[2] = dates[1].add(Duration(days: 1));
      dates[3] = dates[2].add(Duration(days: 1));
      dates[4] = dates[3].add(Duration(days: 1));
    } else if (dates[0].weekday == 6) {
      dates[0] = dates[0].add(Duration(days: 2));
      dates[1] = dates[0].add(Duration(days: 1));
      dates[2] = dates[1].add(Duration(days: 1));
      dates[3] = dates[2].add(Duration(days: 1));
      dates[4] = dates[3].add(Duration(days: 1));
    } else if (dates[0].weekday == 7) {
      dates[0] = dates[0].add(Duration(days: 1));
      dates[1] = dates[0].add(Duration(days: 1));
      dates[2] = dates[1].add(Duration(days: 1));
      dates[3] = dates[2].add(Duration(days: 1));
      dates[4] = dates[3].add(Duration(days: 1));
    }
  }

  Future<void> _reload() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlertDialog(
              backgroundColor: Colors.transparent,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Error',
                    style: MyFonts.bold.size(24).setColor(kWhite),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'You\'ve run into the error,please reload.',
                    style: MyFonts.regular.size(14).setColor(Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(85, 95, 113, 100)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/Replay.png',
                          height: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Reload',
                          style: MyFonts.medium.size(14).setColor(Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class ApiCalling {
  Future<Time> getTimeTable({required String roll}) async {
    final response = await post(
      Uri.parse('https://hidden-depths-09275.herokuapp.com/get-my-courses'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        "roll_number": roll,
      }),
    );
    if (response.statusCode == 200) {
      return Time.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      throw Exception(response.statusCode);
    }
  }
}