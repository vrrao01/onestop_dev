//
// // ignore_for_file: file_names
//
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:convert';
// import 'package:flutter_web_browser/flutter_web_browser.dart';
// import 'package:webfeed/domain/rss_feed.dart';
//
// import 'package:progress_dialog/progress_dialog.dart';
// class RssFeed1 extends StatefulWidget {
//   const RssFeed1({Key? key}) : super(key: key);
//
//   @override
//   _RssFeedState createState() => _RssFeedState();
// }
// class MyCustomScrollBehavior extends MaterialScrollBehavior {
//   // Override behavior methods and getters like dragDevices
//   @override
//   Set<PointerDeviceKind> get dragDevices => {
//     PointerDeviceKind.touch,
//     PointerDeviceKind.mouse,
//   };
// }
// class _RssFeedState extends State<RssFeed1> {
//   List _feeds=[];
//   var heading;
//   Future<void> readJson() async {
//     // final String response = await rootBundle.loadString('assets/json/medium.json');
//     // final data = await json.decode(response);
//      var rss=await RssFeed.parse("https://medium.com/feed/@cepstrumeeeiitg");
//     final data =await json.decode(rss.toString());
//     setState((){
//       _feeds=data["items"];
//       heading=data["feed"];
//     });
//   }
//   Future<void> openFeed(String url) async {
//     try {
//       //await launch(url);
//       await FlutterWebBrowser.openWebPage(url: url);
//       //WebBrowser( initialUrl: url,);
//     }
//     catch (e) {
//
//     }
//
//   }
//   subtitle(subTitle) {
//     return Text(
//       subTitle,
//       style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w100,color: Colors.black),
//       maxLines: 1,
//       overflow: TextOverflow.ellipsis,
//     );
//   }
//   rightIcon() {
//     return Icon(
//       Icons.keyboard_arrow_right,
//       color: Colors.grey,
//       size: 30.0,
//     );
//   }
//   thumbnail(url) {
//     return Padding(
//       padding: EdgeInsets.only(left: 15.0),
//       child: Image.network(url,width : 100.0,height : 200.0),
//       // child: Image(image: AssetImage('assets/images/img.png'),
//       //   height: 40,
//       //   width: 50,
//       //   alignment: Alignment.center,
//       //   fit:BoxFit.fill,)
//       //
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     readJson();
//     String Title="Pawaneet";
//     String subTitle="Wait while screen is loading";
//
//     if(heading!=null){
//       Title=heading["title"];
//       subTitle=heading["description"];
//     }
//     return MaterialApp(
//       scrollBehavior: MyCustomScrollBehavior(),
//       title: Title,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text(subTitle),
//         ),
//         body: ListView.builder(
//           itemCount: _feeds.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text('${_feeds[index]["title"]}'),
//               subtitle: subtitle(_feeds[index]["pubDate"].toString()),
//               leading: thumbnail(_feeds[index]["thumbnail"]),
//               trailing: rightIcon(),
//               contentPadding: const EdgeInsets.all(10.0),
//               onTap: () {
//                 openFeed(_feeds[index]["guid"].toString());
//               },
//
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: file_names, constant_identifier_names, avoid_print, valid_regexps, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class blogitem{
  late String title;
  late String pubdate;
  late String guid;
  blogitem({required this.title,required this.pubdate,required this.guid});
}
class MediumArticle {

  String title;
  String link;
  String datePublished;
  String image;
  MediumArticle({required this.title, required this.link, required this.datePublished,required this.image});
  factory MediumArticle.fromJson(Map<String, dynamic> jsonData) {
    return MediumArticle(
      title: jsonData['title'],
      link: jsonData['link'],
      datePublished: jsonData['datePublished'],
      image : jsonData['image'],
     );
  }

  static Map<String, dynamic> toMap(MediumArticle music) => {
    'title': music.title,
    'link': music.link,
    'datePublished': music.datePublished,
    'image': music.image,
      };
  static String encode(List<MediumArticle> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => MediumArticle.toMap(music))
        .toList(),
  );

  static List<MediumArticle> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<MediumArticle>((item) => MediumArticle.fromJson(item))
          .toList();
}
class _HomeState extends State<Home> {

   late RssFeed _rssFeed; // RSS Feed Object

  static const String MEDIUM_PROFILE_RSS_FEED_URL = 'https://medium.com/feed/@cepstrumeeeiitg';

   List<MediumArticle> _mediumArticles = [];
   String title="Wait until data is loading";
   String image="https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.cyberark.com%2Fwp-content%2Fuploads%2F2019%2F11%2FDeveloper.jpg&imgrefurl=https%3A%2F%2Fwww.cyberark.com%2Fresources%2Fblog%2Fsecure-developer-workstations-without-slowing-them-down&tbnid=fJMc6OspVdPfgM&vet=12ahUKEwivmoytyOb1AhXlZWwGHZAPBZkQMygAegUIARDTAQ..i&docid=X2dX4HlN_niOsM&w=943&h=536&q=developer&ved=2ahUKEwivmoytyOb1AhXlZWwGHZAPBZkQMygAegUIARDTAQ";
  // Get the Medium RSSFeed data
  Future<RssFeed?> getMediumRSSFeedData() async {
    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(MEDIUM_PROFILE_RSS_FEED_URL));
      return RssFeed.parse(response.body);
     } catch (e) {
      print(e);
    }
    return null;
  }

  updateFeed(feed) {
    setState(() {
      _rssFeed = feed;
    });
  }

  Future<void> launchArticle(String url) async {
    if (await canLaunch(url)) {
      await launch(
          url
      );
      return;
    }
  }
  Future<void> getDetails() async{
    final SharedPreferences prefs =  await SharedPreferences.getInstance();
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _mediumArticles.clear();
        getMediumRSSFeedData().then((feed) {

          updateFeed(feed);

          title=_rssFeed.title!;
          image=_rssFeed.image!.url!;
          var items=feed!.items;
          for(RssItem x in items!){
            if(x.pubDate!=null){
              final text=x.content!.value;
              String imagelink = text.split("<img")[1].split("/>")[0].split(" src=")[1];
              //  print(image);
              int p=imagelink.length;
              String imagelink2=imagelink.substring(1,p-2);

              print(imagelink2);
              String pdate=x.pubDate.toString();
              MediumArticle res=MediumArticle(title: x.title!, link: x.guid!, datePublished: pdate, image: imagelink2);
              _mediumArticles.add(res);
            }
          }
        }
        );

        // Encode and store data in SharedPreferences
        final String encodedData = MediumArticle.encode(_mediumArticles
        );

        prefs.setString('medium_data', encodedData);

      }
    } on SocketException catch (_) {
      final String? musicsString = prefs.getString('medium_data');

      _mediumArticles= MediumArticle.decode(musicsString!);

    }

  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();

    getDetails();

    // Fetch and decode data

    }


   thumbnail(url) {
     return Padding(
       padding: const EdgeInsets.only(left: 15.0),
       child: Image.network(url,width : 100.0,height : 200.0),
       
     );
   }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _mediumArticles.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (BuildContext buildContext, int index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(_mediumArticles[index].title.toString()),
              subtitle: Text(_mediumArticles[index].datePublished.toString()),
              leading: thumbnail(_mediumArticles[index].image),
              onTap: () => launchArticle(_mediumArticles[index].link.toString()),
              trailing: const Icon(Icons.arrow_right),
            ),
          );
        },
      ),
    );
  }

}