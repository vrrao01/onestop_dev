import 'package:flutter/material.dart';
import '../../../globals/my_colors.dart';
import '../../../globals/my_fonts.dart';
import '../../../models/contact_model.dart';


class Contacts2 extends StatefulWidget {
  //final Contacts10;
  final String title;
  ContactModel ? contact;
  Contacts2({Key? key, this.contact, required this.title}) : super(key: key);
  @override
  State<Contacts2> createState() => _Contacts2State();
}

class _Contacts2State extends State<Contacts2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBlueGrey,
          leading: Container(),
          leadingWidth: 0,
          title: Text('Contacts', style: MyFonts.medium.size(20).setColor(kWhite)),
          actions: [
            IconButton(
                onPressed: () {Navigator.of(context).pop();},
                icon: Icon(IconData(0xe16a, fontFamily: 'MaterialIcons')))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      widget.contact!.name,
                      style: MyFonts.med6.size(16).setColor(kWhite),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      widget.title,
                      style: MyFonts.regular.size(14).setColor(kGrey2),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 2),
                  child: Text(
                    widget.contact!.contacts.length.toString()+' contacts',
                    style: MyFonts.medium.size(12).setColor(kGrey11),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                ContactTextHeader(text: 'Name', width: MediaQuery.of(context).size.width / 3 - 10, align: AlignmentDirectional.topStart),
                ContactTextHeader(text: 'Email id', width: MediaQuery.of(context).size.width / 3 - 10, align: AlignmentDirectional.center),
                ContactTextHeader(text: 'Contact No', width: MediaQuery.of(context).size.width / 3 - 15, align: AlignmentDirectional.bottomEnd),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.96,
              child: Divider(
                color: Colors.blueGrey,
                thickness: 1,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.contact!.contacts.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: Row(
                        children: [
                          ContactText(text: item.name, align: AlignmentDirectional.topStart),
                          ContactText(text: item.email, align: AlignmentDirectional.center),
                          ContactText(text: item.contact.toString(), align: AlignmentDirectional.bottomEnd),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ContactText extends StatelessWidget {
  final String text;
  final align;
  const ContactText({Key? key, required this.text, this.align}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          alignment: align,
          child: Text(
            text,
            style: MyFonts.regular.size(14).setColor(lBlue2),
          ),
        ),
      ),
    );
  }
}

class ContactTextHeader extends StatelessWidget {
  final text;
  final width;
  final align;
  const ContactTextHeader({Key? key, this.text, this.width, this.align}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
        alignment: align,
        width: width,
        child: Text(
          text,
          style: MyFonts.medium.size(12).setColor(kGrey11),
        ),
      ),
    );
  }
}

