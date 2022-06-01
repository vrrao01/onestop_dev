import 'package:flutter/material.dart';
import 'package:onestop_dev/pages/home/body/home/quick_links.dart';
import '../../../../globals/my_colors.dart';
import '../../../../globals/my_fonts.dart';
import '../../../../widgets/mapBox.dart';
import '../../home_routes.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;

  void rebuildParent(int newSelectedIndex) {
    print('Reloaded');
    setState(() {
      selectedIndex = newSelectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          MapBox(
            lat: (lat != 0) ? lat : null,
            long: (long != 0) ? long : null,
            selectedIndex: selectedIndex,
            rebuildParent: rebuildParent,
            istravel: true,
          ),
          SizedBox(height: 10,),
          DateCourse(),
          SizedBox(height: 10,),
          QuickLinks(),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}

class DateCourse extends StatelessWidget {
  const DateCourse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                      child: Text('MON', style: MyFonts.medium.size(20).setColor(kWhite))
                  ),
                  FittedBox(
                      child: Text('24', style: MyFonts.extraBold.size(40).setColor(kWhite),)
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 10,),
        Expanded(
          flex: 5,
          child: Container(
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color.fromRGBO(101, 174, 130, 0.16)),
          ),
        ),
        SizedBox(width: 10,),
        Expanded(
          flex: 1,
          child: Container(
            height: 100,
            child: Icon(
              Icons.keyboard_arrow_down_sharp,
              color: Colors.green.shade800,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color.fromRGBO(101, 174, 130, 0.16)),
          ),
        )
      ],
    );
  }
}

