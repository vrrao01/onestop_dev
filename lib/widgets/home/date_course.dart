import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:onestop_dev/globals/days.dart';
import 'package:onestop_dev/globals/my_colors.dart';
import 'package:onestop_dev/globals/my_fonts.dart';
import 'package:onestop_dev/stores/timetable_store.dart';
import 'package:onestop_dev/widgets/timetable/dropdown_arrow.dart';
import 'package:onestop_dev/widgets/timetable/home_shimmer.dart';
import 'package:onestop_dev/widgets/timetable/timetable_row.dart';
import 'package:provider/provider.dart';

class DateCourse extends StatefulWidget {
  const DateCourse({
    Key? key,
  }) : super(key: key);

  @override
  State<DateCourse> createState() => _DateCourseState();
}

class _DateCourseState extends State<DateCourse> {
  late LifecycleEventHandler lifeCycleHandler;

  @override
  void initState() {
    super.initState();
    // Lifecycle Handler to ensure that timetable gets updated when
    // app is brought to foreground from background
    lifeCycleHandler =
        LifecycleEventHandler(resumeCallBack: () => setState(() {}));
    WidgetsBinding.instance.addObserver(lifeCycleHandler);
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    context.read<TimetableStore>().initialiseDates();
    return Observer(builder: (context) {
      if (context.read<TimetableStore>().coursesLoaded) {
        var classes = context.read<TimetableStore>().homeTimeTable;
        bool showArrow = classes.length > 1;
        if (showArrow) {
          context.read<TimetableStore>().setDropDown(false);
        }
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(kday[now.weekday]!,
                          style: MyFonts.w500.size(15).setColor(kWhite)),
                      Text(
                        now.day.toString(),
                        style: MyFonts.w600.size(30).setColor(kWhite),
                      )
                    ],
                  ),
                ),
                Expanded(flex: 36, child: classes[0]),
                const SizedBox(
                  width: 8,
                ),
                ArrowButton(
                  showArrow: showArrow,
                ),
              ],
            ),
            TimetableRow(classes: classes.skip(1).toList()),
          ],
        );
      }
      return const HomeTimetableShimmer();
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(lifeCycleHandler);
  }
}

class LifecycleEventHandler extends WidgetsBindingObserver {
  final Function resumeCallBack;

  LifecycleEventHandler({
    required this.resumeCallBack,
  });

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        resumeCallBack();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        break;
    }
  }
}
