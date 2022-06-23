import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:onestop_dev/functions/timetable/time_range.dart';
import 'package:onestop_dev/globals/days.dart';
import 'package:onestop_dev/globals/my_colors.dart';
import 'package:onestop_dev/globals/my_fonts.dart';
import 'package:onestop_dev/models/timetable.dart';
import 'package:onestop_dev/stores/timetable_store.dart';
import 'package:onestop_dev/widgets/timetable/home_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class DateCourse extends StatefulWidget {
  const DateCourse({
    Key? key,
  }) : super(key: key);

  @override
  State<DateCourse> createState() => _DateCourseState();
}

class _DateCourseState extends State<DateCourse> {
  bool show=false;
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (BuildContext context){
      if(context.read<TimetableStore>().loadOperation.status == FutureStatus.fulfilled){
        var next_class = context.read<TimetableStore>().selectedCourseforHome;
        DateTime now=DateTime.now();
        return Center(child: Text('scbjn'),);
        // return Column(
        //   children: [
        //     Row(
        //       children: [
        //         Expanded(
        //           flex: 2,
        //           child: FittedBox(
        //             child: Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   FittedBox(
        //                       child: Text(kday[now.weekday]!,
        //                           style: MyFonts.w500.size(20).setColor(kWhite))),
        //                   FittedBox(
        //                       child: Text(
        //                         now.day.toString(),
        //                         style: MyFonts.w800.size(40).setColor(kWhite),
        //                       ))
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //         SizedBox(
        //           width: 10,
        //         ),
        //         Expanded(
        //           flex: 5,
        //           child: Container(
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(25),
        //               color: Color.fromRGBO(101, 174, 130, 0.16),
        //               border: Border.all(color: Colors.transparent),
        //             ),
        //             child: Padding(
        //               padding: const EdgeInsets.only(top: 8.0, bottom: 8),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: [
        //                   Padding(
        //                     padding: const EdgeInsets.only(
        //                         left: 20.0, right: 20.0),
        //                     child: Column(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       children: [
        //                         (next_class.timing =='')
        //                             ? Container(
        //                           height: 50,
        //                           width: 50,
        //                           decoration: BoxDecoration(
        //                             shape: BoxShape.circle,
        //                             color: Colors.blue,
        //                           ),
        //                           child: Image.asset(
        //                               'assets/images/class.png'),
        //                         )
        //                             : SizedBox(),
        //                       ],
        //                     ),
        //                   ),
        //                   Expanded(
        //                     child: Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       mainAxisAlignment:
        //                       MainAxisAlignment.spaceBetween,
        //                       children: [
        //                         Text(
        //                           next_class.timing,
        //                           style: MyFonts.w300.size(12).setColor(kWhite),
        //                         ),
        //                         SizedBox(
        //                           height: 5.0,
        //                         ),
        //                         Row(
        //                           children: [
        //                             Expanded(
        //                               child: Text(
        //                                 next_class.course!,
        //                                 style: MyFonts.w600
        //                                     .size(15)
        //                                     .setColor(kWhite),
        //                               ),
        //                             ),
        //                           ],
        //                         ),
        //                         SizedBox(
        //                           height: 3.0,
        //                         ),
        //                         Row(
        //                           children: [
        //                             Text(
        //                               next_class.instructor!,
        //                               style: MyFonts.w300.size(13).setColor(
        //                                   Color.fromRGBO(212, 227, 255, 100)),
        //                             )
        //                           ],
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //         SizedBox(
        //           width: 10,
        //         ),
        //         (now.weekday < 6)?Expanded(
        //           flex: 1,
        //           child: GestureDetector(
        //             onTap: () {
        //               setState(() {
        //                 show = !show;
        //               });
        //             },
        //             child: Container(
        //               height: 100,
        //               child: Icon(
        //                 (!show)
        //                     ? Icons.keyboard_arrow_down_sharp
        //                     : Icons.keyboard_arrow_up_sharp,
        //                 color: Colors.green.shade800,
        //               ),
        //               decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(25),
        //                   color: Color.fromRGBO(101, 174, 130, 0.16)),
        //             ),
        //           ),
        //         ):SizedBox(),
        //       ],
        //     ),
        //     (show)?context.read<TimetableStore>().todayTimeTable.first:SizedBox(),
        //   ],
        // );
      }
      else{
        return HomeTimetableShimmer();
      }
    });
  }
}
