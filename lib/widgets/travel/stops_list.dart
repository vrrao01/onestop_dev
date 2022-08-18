import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onestop_dev/functions/travel/check_weekday.dart';
import 'package:onestop_dev/functions/travel/next_time.dart';
import 'package:onestop_dev/globals/my_colors.dart';
import 'package:onestop_dev/globals/my_fonts.dart';
import 'package:onestop_dev/services/data_provider.dart';
import 'package:onestop_dev/stores/mapbox_store.dart';
import 'package:onestop_dev/widgets/ui/list_shimmer.dart';
import 'package:provider/provider.dart';

class BusStopList extends StatelessWidget {
  const BusStopList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: context.read<MapBoxStore>().allLocationData.length,
        itemBuilder: (BuildContext context, int index) {
          var map_store = context.read<MapBoxStore>();
          return FutureBuilder(
            future: DataProvider.getBusTimings(),
            builder: (context, snapshot){
              if(snapshot.hasData)
                {
                  var busTime = snapshot.data as List<List<String>>;
                  print(busTime);
                  bool weekDay = checkWeekday();
                  print(weekDay);
                  print(nextTime(busTime[0]));
                  return Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: GestureDetector(
                      onTap: () {
                        map_store.selectedCarousel(index);
                        map_store.zoomTwoMarkers(
                            LatLng(
                                map_store.allLocationData[
                                map_store.selectedCarouselIndex]['lat'],
                                map_store.allLocationData[
                                map_store.selectedCarouselIndex]['long']),
                            LatLng(map_store.userlat, map_store.userlong),
                            100.0
                        );
                      },
                      child: Observer(builder: (context) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          decoration: BoxDecoration(
                            color: kTileBackground,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                                color: (map_store.selectedCarouselIndex == index)
                                    ? lBlue5
                                    : kTileBackground),
                          ),
                          child: ListTile(
                            textColor: kWhite,
                            leading: const CircleAvatar(
                              backgroundColor: lYellow2,
                              radius: 20,
                              child: Icon(
                                FluentIcons.vehicle_bus_24_filled,
                                color: kBlueGrey,
                              ),
                            ),
                            title: Text(
                              map_store.allLocationData[index]['name'],
                              style: MyFonts.w500.setColor(kWhite).size(14),
                            ),
                            subtitle: Text(
                                map_store.allLocationData[index]['distance']
                                    .toString() +
                                    " km",
                                style: MyFonts.w500.setColor(kGrey13).size(11)),
                            // trailing: (map_store.allLocationData[index]['status'] ==
                            //     'left')
                            //     ? Column(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Text(
                            //       'Left',
                            //       style: MyFonts.w500
                            //           .setColor(Color.fromRGBO(135, 145, 165, 1)),
                            //     ),
                            //     Text(
                            //       map_store.allLocationData[index]['time'],
                            //       style: MyFonts.w500
                            //           .setColor(Color.fromRGBO(195, 198, 207, 1)),
                            //     ),
                            //   ],
                            // )
                            //     :
                            //
                            trailing: weekDay ? Text(
                            nextTime(busTime[1]),
                              style: MyFonts.w500.setColor(lBlue2).size(14),
                            ) : Text(
                              nextTime(busTime[0]),
                              style: MyFonts.w500.setColor(lBlue2).size(11),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                }
              return ListShimmer();
            },
          );
        });
  }
}
