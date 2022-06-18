import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:onestop_dev/stores/timetable_store.dart';
import 'package:onestop_dev/widgets/timetable/dateSlider.dart';
import 'package:provider/provider.dart';

class TimeTableTab extends StatefulWidget {
  static const String id = 'time';
  const TimeTableTab({Key? key}) : super(key: key);
  @override
  State<TimeTableTab> createState() => _TimeTableTabState();
}

class _TimeTableTabState extends State<TimeTableTab> {
  @override
  Widget build(BuildContext context) {
    print("Rebuild timetable.dart");
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 130,
            child: DateSlider(),
          ),
          SizedBox(
            height: 10,
          ),
          Observer(
            builder: (context) {
              context.read<TimetableStore>().changePage(false);
              return ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: context.read<TimetableStore>().todayTimeTable.length,
                  itemBuilder: (context, index) =>
                      context.read<TimetableStore>().todayTimeTable[index]);
            }
          ),
        ],
      ),
    );
  }
}
