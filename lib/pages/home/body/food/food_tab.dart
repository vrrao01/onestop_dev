import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onestop_dev/globals/my_colors.dart';
import 'package:onestop_dev/globals/my_fonts.dart';
import 'package:onestop_dev/widgets/food/favourite_food_details.dart';
import 'package:onestop_dev/widgets/food/food_search_bar.dart';
import 'package:onestop_dev/widgets/food/restaurant_tile.dart';

import '../../../../models/restaurant_model.dart';


class FoodTab extends StatelessWidget {
  const FoodTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 8,
          ),
          FoodSearchBar(),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MessMenu(),
                  SizedBox(height: 8),
                  FavoriteDishes(),
                  SizedBox(
                    height: 10,
                  ),
                  OutletsFilter(),
                  SizedBox(
                    height: 8,
                  ),
                  // restaurant(),
                  FutureBuilder<List<RestaurantModel>>(
                      future: ReadJsonData(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<RestaurantModel>> snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data);
                          List<Widget> foodList = snapshot.data!
                              .map(
                                (e) => RestaurantTile(
                                  restaurant_model: e,
                                ),
                              )
                              .toList();
                          return Column(
                            children: foodList,
                          );
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          return Center(
                              child: Text(
                            "An error occurred",
                            style: MyFonts.medium.size(18).setColor(kWhite),
                          ));
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OutletsFilter extends StatelessWidget {
  const OutletsFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 65,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Outlets near you",
                  style: MyFonts.medium.size(18).setColor(kWhite),
                )),
          ),
        ],
      ),
    );
  }
}

class MessMenu extends StatelessWidget {
  MessMenu({
    Key? key,
  }) : super(key: key);

  StreamController mealController = StreamController();
  StreamController<String> dayController = StreamController();
  StreamController<String> hostelController = StreamController();

  List<String> days = ["Sun", "Mon", "Tue","Wed","Thu","Fri","Sat"];
  List<String> hostels = ["Brahmaputra", "Lohit", "Kameng", "Umiam", "Barak", "Manas", "Dihing", "Disang"];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    print(screenWidth);
    return Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kBlueGrey,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            StreamBuilder(
              stream: mealController.stream,
              builder: (context, mealSnapshot) {
                return Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap : (){
                            if(mealSnapshot.hasData == true && mealSnapshot.data=="Breakfast"){
                              return;
                            }
                            mealController.sink.add("Breakfast");
                          },
                            child: MessMeal(mealName: "Breakfast",selected: (mealSnapshot.hasData == true && mealSnapshot.data=="Breakfast") ? true : false,)),
                        GestureDetector(
                            onTap : (){
                              if(mealSnapshot.hasData == true && mealSnapshot.data=="Lunch"){
                                return;
                              }
                              mealController.sink.add("Lunch");
                            },
                            child: MessMeal(mealName: "Lunch",selected: (mealSnapshot.hasData == true && mealSnapshot.data=="Lunch") ? true : false,)),
                        GestureDetector(
                          onTap: (){
                            if(mealSnapshot.hasData == true && mealSnapshot.data=="Dinner"){
                              return;
                            }
                            mealController.sink.add("Dinner");
                          },
                          child: MessMeal(
                            mealName: "Dinner",
                            selected: (mealSnapshot.hasData == true && mealSnapshot.data=="Dinner") ? true : false,
                          ),
                        ),
                      ],
                    ));
              }
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "8:00 pm - 10:15 pm",
                        style: MyFonts.medium.setColor(kTabText),
                      ),
                    ),
                    Expanded(
                        flex: 4,
                        child: SingleChildScrollView(
                            child: Text(
                                "Dal Makhani, Rasam, Green Peas, Cauliflower, Rice, Roti, Salad",
                                style:
                                    MyFonts.medium.size(15).setColor(kWhite)))),
                    Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(1, 0, 2, 0),
                              child: PopupMenuButton<String>(
                                onSelected: (value) => print(value),
                                itemBuilder: (context) {
                                  return days
                                      .map(
                                        (value) => PopupMenuItem(
                                      onTap: (){
                                        dayController.sink.add(value);
                                      },
                                      value: value,
                                      child: Text(value),
                                    ),
                                  )
                                      .toList();
                                },
                                offset: Offset(1, 40),
                                child: Container(
                                  padding: EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                      color: kGrey2,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            4, 0, 4, 2),
                                        child: StreamBuilder<String>(
                                            stream: dayController.stream,
                                            builder: (context, daySnapshot) {
                                              return Text(daySnapshot.hasData==true ? daySnapshot.data! : "Mon",
                                                  style: MyFonts.medium
                                                      .setColor(lBlue)
                                                      .size(screenWidth<=380 ? 10 : 13));
                                            }
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        color: lBlue,
                                        size:  screenWidth<=380 ? 15: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   width: 8,
                            // ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(2, 0, 1, 0),
                              child: PopupMenuButton<String>(
                                onSelected: (value) => print(value),
                                itemBuilder: (context) {
                                  return hostels
                                      .map(
                                        (value) => PopupMenuItem(
                                          onTap: (){
                                            hostelController.sink.add(value);
                                          },
                                          value: value,
                                          child: Text(
                                            value,
                                          ),
                                        ),
                                      )
                                      .toList();
                                },
                                offset: Offset(1, 40),
                                child: Container(
                                  padding: EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: lBlue),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            4, 4, 4, 4),
                                        child: StreamBuilder<String>(
                                          stream: hostelController.stream,
                                          builder: (context, hostelSnapshot) {
                                            return Text(hostelSnapshot.hasData == true ? hostelSnapshot.data! : "Brahmaputra",
                                                style: MyFonts.medium
                                                    .setColor(lBlue)
                                                    .size(screenWidth<=380 ? 9 : 13));
                                          }
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        color: lBlue,
                                        size: screenWidth<=380 ? 15: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ))
                  ],
                ))
          ]),
        ));
  }
}

class MessMeal extends StatelessWidget {
  const MessMeal({
    Key? key,
    required this.mealName,
    this.selected = false,
  }) : super(key: key);

  final String mealName;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(150),
            color: selected ? lBlue2 : lGrey,
          ),
          alignment: Alignment.center,
          child: Text(
            mealName,
            style: selected
                ? MyFonts.medium.size(screenWidth<=380 ? 13 : 17).setColor(kBlueGrey)
                : MyFonts.medium.size(screenWidth<=380 ? 13 : 17).setColor(lBlue),
          ),),
    );
  }
}

class FavoriteDishes extends StatelessWidget {
  const FavoriteDishes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kHomeTile,
      ),
      child: Container(
        //height: 160,
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: FittedBox(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 15, 0),
                  child: Text(
                    'Your Favourite Dishes',
                    style: MyFonts.medium.size(20).setColor(kWhite),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              flex: 4,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FavouriteFoodDetails(
                    foodName: "Noodles",
                    img: Image.asset('assets/images/food.jpeg'),
                  ),
                  FavouriteFoodDetails(
                    foodName: "Fried Rice",
                    img: Image.asset('assets/images/food2.jpeg'),
                  ),
                  FavouriteFoodDetails(
                    foodName: "Biryani",
                    img: Image.asset('assets/images/food.jpeg'),
                  ),
                  FavouriteFoodDetails(
                    foodName: "Chinese",
                    img: Image.asset('assets/images/food.jpeg'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1),
            Expanded(
              flex: 4,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FavouriteFoodDetails(
                    foodName: "Chinese",
                    img: Image.asset('assets/images/food.jpeg'),
                  ),
                  FavouriteFoodDetails(
                    foodName: "Cakes",
                    img: Image.asset('assets/images/food.jpeg'),
                  ),
                  FavouriteFoodDetails(
                    foodName: "Sandwich",
                    img: Image.asset('assets/images/food2.jpeg'),
                  ),
                  FavouriteFoodDetails(
                    foodName: "Continental",
                    img: Image.asset('assets/images/food2.jpeg'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<RestaurantModel>> ReadJsonData() async {
  final jsondata = await rootBundle.loadString('lib/globals/restaurants.json');
  final list = json.decode(jsondata) as List<dynamic>;

  return list.map((e) => RestaurantModel.fromJson(e)).toList();
}
