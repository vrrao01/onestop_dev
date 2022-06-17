import 'dart:async';

import 'package:flutter/material.dart';
import 'package:onestop_dev/stores/login_store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginWebView extends StatelessWidget {
  const LoginWebView({
    Key? key,
    required Completer<WebViewController> controller,
  }) : _controller = controller, super(key: key);

  final Completer<WebViewController> _controller;

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: "https://swc.iitg.ac.in/onestopapi/auth/microsoft",
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (controller){
        _controller.complete(controller);
      },
      onPageFinished: (url) async {
        if(url.startsWith("https://swc.iitg.ac.in/onestopapi/auth/microsoft/redirect?code")){
          WebViewController controller = await _controller.future;
          var checkString = await controller.runJavascriptReturningResult("document.querySelector('h1').innerText");
          print(checkString);
          await controller.runJavascriptReturningResult("document.querySelector('#userInfo').innerText").then((value) => print(value)).catchError((err) => print(err));
          var userInfoString = await controller.runJavascriptReturningResult("document.querySelector('#userInfo').innerText");
          print(userInfoString);
          var userInfo = {};
          String check = "";
          int count=1;

          List<String> values = userInfoString.substring(1,userInfoString.length-1).split("/");
          var capName = values[0];
          userInfo["displayName"] = "";
          userInfo["mail"] = values[1];
          userInfo["surname"] = values[2];
          userInfo["id"]=values[3];
          print(userInfo["id"]);
          print(capName);
          for(int i=0;i<capName.length;i++){
            print(i);
            if(i>0 && capName[i-1]!=' '){
              userInfo["displayName"] = userInfo["displayName"] + capName[i].toLowerCase();
            }
            else{
              userInfo["displayName"] = userInfo["displayName"] + capName[i];
            }
          }
          print(userInfo["displayName"]);
          SharedPreferences user = await SharedPreferences.getInstance();
          context
              .read<LoginStore>()
              .saveToPreferences(user, userInfo);
          context
              .read<LoginStore>()
              .saveToUserData(user);
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        }
      },
    );
  }
}
