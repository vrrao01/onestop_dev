import 'package:flutter/material.dart';
import 'package:onestop_dev/globals/my_colors.dart';
import 'package:onestop_dev/globals/my_fonts.dart';

class ProgressBar extends StatelessWidget {
  final int blue;
  final int grey;
  const ProgressBar({Key? key,required this.blue,required this.grey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> bars = [];
    if(blue!=0){
      bars.add(Expanded(
          child: Container(
            height: 4,
            color: lBlue2,
            margin: EdgeInsets.only(right: 2),
          )),);
    }
    for(int i=1;i<blue;i++){
      bars.add(Expanded(
          child: Container(
            height: 4,
            color: lBlue2,
            margin: EdgeInsets.symmetric(horizontal: 2),
          )),);
    }
    for(int i=0;i<grey-1;i++){
      bars.add(Expanded(
          child: Container(
            height: 4,
            color: kGrey,
            margin: EdgeInsets.symmetric(horizontal: 2),
          )),);
    }
    if(grey!=0){
      bars.add(Expanded(
          child: Container(
            height: 4,
            color: kGrey,
            margin: EdgeInsets.only(left: 2),
          )),);
    }
    return Row(
      children: bars,
    );
  }
}

class NewPageButton extends StatelessWidget {
  final String title;
  const NewPageButton({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 12,right: 12,bottom: 20),
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          color: lBlue2,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: MyFonts.medium.size(22),
          ),
        ],
      ),
    );
  }
}

class ItemTypeBar extends StatelessWidget {
  final text;
  TextStyle textStyle;
  Color backgroundColor;
  EdgeInsets margin;
  ItemTypeBar({Key? key, required this.text, required this.textStyle,required this.backgroundColor,required this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100)
      ),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}