import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import 'package:flutter/services.dart';
import '../../../globals/my_colors.dart';
import '../../../globals/my_fonts.dart';
import '../../../models/contact_model.dart';
import 'contact_detail.dart';
import 'contact_search_bar.dart';

Map<String, ContactModel> people= {};

class ContactPage extends StatefulWidget {
  static String id = "/contacto";
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}
class _ContactPageState extends State<ContactPage> {

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('lib/globals/contacts.json');
    final data = await json.decode(response);
    setState(() {});
    data.forEach((element) => people[element['name']] = ContactModel.fromJson(element));
  }

  @override
  void initState() {
    super.initState();
    people.clear();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kBlueGrey,
          leading: Container(),
          leadingWidth: 0,
          title: Text(
              'Contacts',
              style: MyFonts.medium.size(20).setColor(kWhite)
          ),
          actions: [
            IconButton(
                onPressed: () {Navigator.of(context).pop();},
                icon: Icon(IconData(0xe16a, fontFamily: 'MaterialIcons')))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8,14,8,14),
              child: ContactSearchBar(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0,0,10),
              child: Row(
                children: [
                  Expanded(flex: 16, child: Container(),),
                  Expanded(
                    flex: 106,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: lGrey,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.warning, color: kGrey8,),
                          Text('Emergency', style: MyFonts.medium.size(10).setColor(kWhite),),
                        ],
                      ),
                    ),
                  ),
                  Expanded(flex: 5, child: Container(),),
                  Expanded(
                    flex: 106,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: lGrey,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.directions_bus, color: kGrey8,),
                          Text('Transport', style: MyFonts.medium.size(10).setColor(kWhite),),
                        ],
                      ),
                    ),
                  ),
                  Expanded(flex: 5, child: Container(),),
                  Expanded(
                    flex: 106,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: lGrey,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.group, color: kGrey8,),
                          Text('Gymkhana', style: MyFonts.medium.size(10).setColor(kWhite),),
                        ],
                      ),
                    ),
                  ),
                  Expanded(flex: 16, child: Container(),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 6),
              child: Row(
                children: [
                  Icon(IconData(0xe5f9, fontFamily: 'MaterialIcons'), color: kGrey8, size: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text('Starred', style: MyFonts.regular.setColor(kGrey8),),
                  ),
                  Expanded(child: Container(),),
                ],
              ),
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      starredContact('Gensec SWC'),
                      starredContact('Admin, Finance'),
                      starredContact('Gensec SWC'),
                      starredContact('Admin, Finance'),
                      starredContact('Gensec SWC'),
                      starredContact('Admin, Finance'),
                    ]
                )
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(3,0,3,0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage('https://images.wallpapersden.com/image/wxl-loki-marvel-comics-show_78234.jpg'),
                ),
                title: Text('My Profile', style: MyFonts.bold.size(15).setColor(kWhite),),
              ),
            ),
            Expanded(
              child: AlphabetScrollView(
                list: people.keys.map((e) => AlphaModel(e)).toList(),
                alignment: LetterAlignment.right,
                itemExtent: 50,
                unselectedTextStyle: MyFonts.regular.size(12).setColor(kbg),
                selectedTextStyle: MyFonts.bold.size(12).setColor(kbg),
                overlayWidget: (value) => Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.circle, size: 30, color: Colors.grey,),
                    Container(
                      height: 50, width: 50,
                      decoration: BoxDecoration(shape: BoxShape.circle,),
                      alignment: Alignment.center,
                      child: Text('$value'.toUpperCase(), style: TextStyle(fontSize: 18, color: kWhite),),
                    ),
                  ],
                ),
                itemBuilder: (_, k, id) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Contacts2(contact: people[id], title: 'Campus')),);},
                      child: ListTile(title: Text(id, style: TextStyle(color: Colors.white),),),
                    ),
                  );
                },
              ),
            )
          ],
        )
    );
  }
}

starredContact(String contact)
{
  int size = contact.length;
  return TextButton(
    child: ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(40),
      ),
      child: Container(
        height: 32,
        width: 10*size+25,
        color: lGrey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              contact,
              style: MyFonts.regular.setColor(kWhite),
            ),
          ],
        ),
      ),
    ), onPressed: (){},);
}
