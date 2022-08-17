import 'package:flutter/material.dart';
import 'package:onestop_dev/globals/my_colors.dart';
import 'package:onestop_dev/globals/my_fonts.dart';
import 'package:onestop_dev/models/buysell/buy_model.dart';

import '../../models/lostfound/lost_model.dart';
import 'details_dialog.dart';

class BuyTile extends StatelessWidget {
  BuyTile({
    Key? key,
    required this.model,
  }) : super(key: key);

  final LostModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        detailsDialogBox(context, model);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 5.0),
        child: Container(
          height: 115,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(21),
            color: kBlueGrey,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 2.0, 3.0, 2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                model.title,
                                style: MyFonts.w600.size(16).setColor(kWhite),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                model.description,
                                style: MyFonts.w500.size(12).setColor(kGrey6),
                              ),
                            ),
                            //TODO::Implemnt the correct design
                            Expanded(
                              child: Text(
                                '\u{20B9}${model.date}/-',
                                style: MyFonts.w600.size(14).setColor(lBlue4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(21),
                      bottomRight: Radius.circular(21)),
                  child: Image.network(model.imageURL, fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}