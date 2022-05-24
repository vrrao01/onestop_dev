import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:onestop_dev/globals/my_colors.dart';
import 'package:onestop_dev/globals/my_fonts.dart';
import 'package:onestop_dev/globals/my_spaces.dart';
import 'package:onestop_dev/globals/size_config.dart';
import 'package:onestop_dev/stores/login_store.dart';
import 'package:onestop_dev/widgets/ui/powerup.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static String id = "/login";

  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  bool fetchingUserInfo = false;
  StreamController loginPageController = StreamController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
    flutterWebviewPlugin.onUrlChanged.listen((String url) async {
      if(fetchingUserInfo == false && url.startsWith("https://swc.iitg.ac.in/onestopapi/auth/microsoft/redirect?code")){
        fetchingUserInfo=true;
        // String? userInfoString = await flutterWebviewPlugin.evalJavascript("document.getElementById('userInfo').innerText");
        // var userInfo = jsonDecode(userInfoString!);
        SharedPreferences user = await SharedPreferences.getInstance();
        context.read<LoginStore>().saveToPreferences(user, {"displayName" : "Kunal Pal", "mail" : "k.pal@iitg.ac,in","surname" : "200104048","id" : "fskfl"});
        context.read<LoginStore>().saveToUserData(user);
        flutterWebviewPlugin.cleanCookies();
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      }
    });
    return Scaffold(
      body: StreamBuilder(
        stream: loginPageController.stream,
        builder: (context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return WebviewScaffold(
              url: "https://swc.iitg.ac.in/onestopapi/auth/microsoft",
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/bg_triangle.png'),
                        fit: BoxFit.fill,
                      )),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 91,
                        child: SafeArea(
                          bottom: false,
                          top: true,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: MySpaces.horizontalScreenPadding),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0),
                                            child: Text(
                                              'Welcome to',
                                              style: MyFonts.medium
                                                  .setColor(kWhite),
                                            ),
                                          ),
                                          Text('your OneStop',
                                              style: MyFonts.medium
                                                  .setColor(kWhite)),
                                          Text('solution for all',
                                              style: MyFonts.medium
                                                  .setColor(kWhite)),
                                          Text('things IITG',
                                              style: MyFonts.medium
                                                  .setColor(kWhite)),
                                        ],
                                      )),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Image.asset(
                                      'assets/images/login_illustration.png'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MySpaces.horizontalScreenPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(),
                        flex: 1,
                      ),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: kYellow,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18))),
                          onPressed: () {
                            loginPageController.sink.add("starting login process for user");
                            // setState(() {
                            //   loading = true;
                            // });
                            // context
                            //     .read<LoginStore>()
                            //     .signInWithMicrosoft(context);
                          },
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              'LOGIN WITH OUTLOOK',
                              style: MyFonts.medium
                                  .factor(3.66)
                                  .setColor(kBlack),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                        flex: 1,
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      )
    );
  }
}

