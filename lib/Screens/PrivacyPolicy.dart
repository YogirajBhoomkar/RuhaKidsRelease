import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:ruhakids/Screens/LoginScreen.dart';
import 'package:ruhakids/Screens/MainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  static String id = "PrivacyPolicyScreen";

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicyScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  WebViewController _controllerError;
  void initState(){
    checkConnectivity();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 414.0;
    double defaultScreenHeight = 896.0;
    ScreenUtil.init(context,
        width: defaultScreenWidth,
        height: defaultScreenHeight,
        allowFontScaling: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child:AppBar(
          title: Text("Privacy Policy",style: TextStyle(fontSize: ScreenUtil().setSp(22.w),fontFamily: "Raleway"),),
          backgroundColor: Color(0xFF076C3E),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.home,size: 25.h,),
              onPressed: () {
                Navigator.pushReplacementNamed(context, MainScreen.id);
              },
            ),
          ],
        ),
      ),
      body: WebView(
        initialUrl:
            "https://kidsapp.ruha.co.in/privacy_policy.php?rand_no=${MainScreen.session}",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webviewcontroller) {
          _controller.complete(webviewcontroller);
          _controllerError=webviewcontroller;
        },
          onWebResourceError:(WebResourceError error) async{
            String fileText = await rootBundle.loadString('Errorfile/errorfile.html');
            _controllerError.loadUrl( Uri.dataFromString(
                fileText,
                mimeType: 'text/html',
                encoding: Encoding.getByName('utf-8')
            ).toString());
          }
      ),
    );
  }
  void checkConnectivity() async{
    SharedPreferences loginPrefs = await SharedPreferences.getInstance();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(5.0)), //this right here
              child: Container(
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.error,color: Colors.redAccent,size: 50.w,),
                      SizedBox(height: 10.h,),
                      Text("No Internet Connection !",textAlign:TextAlign.center,style:TextStyle(fontFamily: "Raleway",fontSize: ScreenUtil().setSp(20),color: Colors.redAccent,fontWeight:FontWeight.w600),),
                      SizedBox(height: 10.h,),
                      Text("Loggin you Out !",textAlign:TextAlign.center,style:TextStyle(fontFamily: "Raleway",fontSize: ScreenUtil().setSp(15),color: Colors.green,fontWeight:FontWeight.w600),),
                      SizedBox(height: 30.h,),
                      RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, PrivacyPolicyScreen.id);
                        },
                        child: Text(
                          "Okay",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.redAccent,
                      )
                    ],
                  ),
                ),
              ),
            );
          });



    }
  }
  void dispose() {
    super.dispose();
  }
}
