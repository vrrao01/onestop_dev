import 'package:flutter/material.dart';
import 'package:onestop_dev/globals.dart';
import 'package:onestop_dev/globals/my_colors.dart';
import 'package:onestop_dev/globals/my_fonts.dart';
import 'package:onestop_dev/globals/size_config.dart';
import 'package:onestop_dev/pages/home/body/travel/travel.dart';
import 'package:onestop_dev/widgets/ui/appbar.dart';
import 'body/food/food_tab.dart';
import 'body/home/home.dart';
import 'body/timetable/helper_functions/home_helper.dart';
import 'body/timetable/timetable.dart';

class HomePage extends StatefulWidget {
  static String id = "/home2";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

double lat = userlat;
double long = userlong;

class _HomePageState extends State<HomePage> {
  int index = 0;
  final tabs = [
    HomeTab(),
    FoodTab(),
    TravelPage(),
    TimeTable1(),
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: appBar(context),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: lGrey,
            labelTextStyle:
                MaterialStateProperty.all(MyFonts.medium.setColor(kTabText)),
            iconTheme:
                MaterialStateProperty.all(IconThemeData(color: kTabText))),
        child: NavigationBar(
          backgroundColor: kTabBar,
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() {
            this.index = index;
          }),
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              selectedIcon: Icon(
                Icons.home_filled,
                color: lBlue2,
              ),
            ),
            NavigationDestination(
              icon: Icon(Icons.restaurant_outlined),
              label: 'Food',
              selectedIcon: Icon(
                Icons.restaurant_outlined,
                color: lBlue2,
              ),
            ),
            NavigationDestination(
              icon: Icon(Icons.directions_bus_outlined),
              label: 'Travel',
              selectedIcon: Icon(
                Icons.directions_bus,
                color: lBlue2,
              ),
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_today_outlined),
              label: 'Timetable',
              selectedIcon: Icon(
                Icons.calendar_today,
                color: lBlue2,
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: tabs[index],
        ),
      ),
      floatingActionButton: (index == 3)
          ? FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              onPressed: () {showMyDialog(context);},
              child: Icon(Icons.add),
            )
          : SizedBox(),
    );
  }
}





