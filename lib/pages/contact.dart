import 'package:flutter/material.dart';
import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import '../globals/my_colors.dart';
import '../globals/my_fonts.dart';
import 'package:accordion/accordion.dart';

class ContactPage extends StatefulWidget {
  static String id = "/contacto";
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
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
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8,14,8,14),
              child: ContactSearchBar(),
            ),
            Row(
              children: [
                Expanded(
                  flex: 16,
                  child: Container(),
                ),
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
                Expanded(
                  flex: 5,
                  child: Container(),
                ),
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
                Expanded(
                  flex: 5,
                  child: Container(),
                ),
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
                Expanded(
                  flex: 16,
                  child: Container(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(3,8,3,8),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('https://images.wallpapersden.com/image/wxl-loki-marvel-comics-show_78234.jpg'),
                ),
                title: Text('My Profile', style: MyFonts.bold.size(15).setColor(kWhite),),
              ),
            ),

            Expanded(
              child: AlphabetScrollView(
                list: list.map((e) => AlphaModel(e)).toList(),
                alignment: LetterAlignment.right,
                itemExtent: 50,
                unselectedTextStyle: MyFonts.regular.size(12).setColor(kbg),
                selectedTextStyle: MyFonts.bold.size(12).setColor(kbg),
                overlayWidget: (value) => Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 30,
                      color: Colors.grey,
                    ),
                    Container(
                      height: 50, width: 50,
                      decoration: BoxDecoration(shape: BoxShape.circle,),
                      alignment: Alignment.center,
                      child: Text(
                        '$value'.toUpperCase(),
                        style: TextStyle(fontSize: 18, color: kWhite),
                      ),
                    ),
                  ],
                ),
                itemBuilder: (_, k, id) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text('hello')
                  );
                },
              ),
            )


          ],
        )
    );
  }
}

class ContactSearchBar extends StatelessWidget {
  ContactSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        onSubmitted: (s) {
          /*context
              .read<RestaurantStore>()
              .setSearchHeader("Showing results for $s");
          context.read<RestaurantStore>().setSearchString(s);
          Navigator.pushNamed(context, SearchPage.id);*/
        },
        onChanged: (s) {
          /*context.read<RestaurantStore>().setSearchHeader("Showing results for $s");
          context.read<RestaurantStore>().setSearchString(s);*/
        },
        style: MyFonts.medium.setColor(kWhite),
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.0),
              borderSide: BorderSide(color: kBlueGrey, width: 1),
            ),
            filled: true,
            prefixIcon: Icon(
              Icons.search,
              color: kWhite,
            ),
            hintStyle: MyFonts.medium.size(13).setColor(kGrey2),
            hintText: "Search keyword (name, position etc)",
            contentPadding: EdgeInsets.zero,
            fillColor: kBlueGrey),
      ),
    );
  }
}

List<String> list = [
  'angel',
  'bubbles',
  'shimmer',
  'angelic',
  'bubbly',
  'glimmer',
  'baby',
  'pink',
  'little',
  'butterfly',
  'sparkly',
  'doll',
  'sweet',
  'sparkles',
  'dolly',
  'sweetie',
  'sprinkles',
  'lolly',
  'princess',
  'fairy',
  'honey',
  'snowflake',
  'pretty',
  'sugar',
  'cherub',
  'lovely',
  'blossom',
  'Ecophobia',
  'Hippophobia',
  'Scolionophobia',
  'Ergophobia',
  'Musophobia',
  'Zemmiphobia',
  'Geliophobia',
  'Tachophobia',
  'Hadephobia',
  'Radiophobia',
  'Turbo Slayer',
  'Cryptic Hatter',
  'Crash TV',
  'Blue Defender',
  'Toxic Headshot',
  'Iron Merc',
  'Steel Titan',
  'Stealthed Defender',
  'Blaze Assault',
  'Venom Fate',
  'Dark Carnage',
  'Fatal Destiny',
  'Ultimate Beast',
  'Masked Titan',
  'Frozen Gunner',
  'Bandalls',
  'Wattlexp',
  'Sweetiele',
  'HyperYauFarer',
  'Editussion',
  'Experthead',
  'Flamesbria',
  'HeroAnhart',
  'Liveltekah',
  'Linguss',
  'Interestec',
  'FuzzySpuffy',
  'Monsterup',
  'MilkA1Baby',
  'LovesBoost',
  'Edgymnerch',
  'Ortspoon',
  'Oranolio',
  'OneMama',
  'Dravenfact',
  'Reallychel',
  'Reakefit',
  'Popularkiya',
  'Breacche',
  'Blikimore',
  'StoneWellForever',
  'Simmson',
  'BrightHulk',
  'Bootecia',
  'Spuffyffet',
  'Rozalthiric',
  'Bookman'
];