import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:ruhakids/Screens/ContactScreen.dart';
import 'package:ruhakids/Screens/FAQScreen.dart';
import 'package:ruhakids/Screens/LanguageColor.dart';
import 'package:ruhakids/Screens/LoginScreen.dart';
import 'package:ruhakids/Screens/PrivacyPolicy.dart';
import 'package:ruhakids/Screens/SettingsScreen.dart';
import 'package:ruhakids/Screens/ThanksGivingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainScreen extends StatefulWidget {
  static String id = "MainScreen";
  static var session;
  static var kidsId;
  static String studentName = "Student Name";
  static String primaryLanguage;
  static bool loadcount = false;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  static String setLanguage;

  void initState() {
    checkConnectivity();
    getPrimaryLanguage();
    getStudentName();
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
        child: AppBar(
          title: Text(
            "Ruha Kids",
            style: TextStyle(
                fontSize: ScreenUtil().setSp(22.w),
                fontFamily: "Raleway",
                fontWeight: FontWeight.w600),
          ),
          backgroundColor: Color(0xFF076C3E),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                size: 25.h,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, MainScreen.id);
              },
            ),
          ],
        ),
      ),
      drawer: Container(
        width: 270.w,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                height: 280.h,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                          width: 160.w,
                          height: 160.h,
                          child: Image.asset("images/small.png")),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        MainScreen.studentName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(24),
                          color: Color(0xFF0CBA9F),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
//                  ListTile(
//                    leading: Icon(
//                      Icons.home,
//                      size: ScreenUtil().setHeight(25),
//                    ),
//                    title: Text(
//                      'Home',
//                      style: TextStyle(
//                          fontSize: ScreenUtil().setSp(15),
//                          fontFamily: "Roboto",
//                          fontWeight: FontWeight.w400),
//                    ),
//                    onTap: () {
//                      Navigator.pop(context);
//                    },
//                  ),
//                  ListTile(
//                    leading: Icon(
//                      Icons.search,
//                      size: ScreenUtil().setHeight(25),
//                    ),
//                    title: Text(
//                      'Search',
//                      style: TextStyle(
//                          fontSize: ScreenUtil().setSp(15),
//                          fontFamily: "Roboto",
//                          fontWeight: FontWeight.w400),
//                    ),
//                    onTap: () {
//                      Navigator.pop(context);
//                    },
//                  ),
                  ListTile(
                    leading: Icon(
                      Icons.supervised_user_circle,
                      size: ScreenUtil().setHeight(25),
                    ),
                    title: Text(
                      'Profile',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(15),
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, SettingsScreen.id);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.color_lens,
                      size: ScreenUtil().setHeight(25),
                    ),
                    title: Text(
                      'Language Colors',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(15),
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, LanguageColorScreen.id);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.star,
                      size: ScreenUtil().setHeight(25),
                    ),
                    title: Text(
                      'Thanksgiving',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(15),
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, ThanksGivingScreen.id);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.contact_mail,
                      size: ScreenUtil().setHeight(25),
                    ),
                    title: Text(
                      'Contact',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(15),
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, ContactScreen.id);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.question_answer,
                      size: ScreenUtil().setHeight(25),
                    ),
                    title: Text(
                      'FAQ',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(15),
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, FAQScreen.id);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.insert_drive_file,
                      size: ScreenUtil().setHeight(25),
                    ),
                    title: Text(
                      'Privacy Policy',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(15),
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, PrivacyPolicyScreen.id);
                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  ListTile(
                    leading: Icon(
                      Icons.input,
                      size: ScreenUtil().setHeight(25),
                    ),
                    title: Text(
                      'Sign Out',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(15),
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400),
                    ),
                    onTap: () {
                      signOut();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: WebView(
        initialUrl:
            "https://kidsapp.ruha.co.in/kids_select_category.php?lang=${MainScreen.primaryLanguage}&rand_no=${MainScreen.session}",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webviewcontroller) {
          _controller.complete(webviewcontroller);
          if (SettingsScreen.visited == true) {
            setState(() {
              print(
                  "\n\n\n\n\n\n\n\n\n\n\n\nCondition is ${SettingsScreen.visited}\n\n\n\n\n\n\n\n\n\n\n\n");
              SettingsScreen.visited = false;
            });
            webviewcontroller.loadUrl(
                "https://kidsapp.ruha.co.in/kids_select_category.php?lang=${SettingsScreen.primaryLanguage}&rand_no=${MainScreen.session}");
          }
        },
      ),
    );
  }

  void getPrimaryLanguage() async {
    SharedPreferences loginPrefs = await SharedPreferences.getInstance();
    var url = "https://kidsapp.ruha.co.in/flutterGetPrimaryLanguage.php";
    var data = {
      'passcode': loginPrefs.get('passcode'),
    };
    var response = await http.post(url, body: json.encode(data));
    try {
      var message = jsonDecode(response.body);
      loginPrefs.setString('primaryLanguage', message['language']);
      loginPrefs.setString('setLanguage', message['language']);
      setState(() {
        setLanguage = message['language'];
        MainScreen.primaryLanguage = message['language'];
        if (MainScreen.loadcount == false) {
          MainScreen.loadcount = true;
          Navigator.pushReplacementNamed(context, MainScreen.id);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void signOut() async {
    SharedPreferences loginPrefs = await SharedPreferences.getInstance();
    loginPrefs.clear();
    Navigator.pushReplacementNamed(context, LoginScreen.id);
  }

  void getStudentName() async {
    SharedPreferences loginPrefs = await SharedPreferences.getInstance();
    try {
      var url2 = "https://kidsapp.ruha.co.in/flutterGetStudentName.php";
      var url1 = "https://kidsapp.ruha.co.in/flutterGetStudentId.php";
      var data = {
        'parentMobile': loginPrefs.get('parentMobile'),
      };
      var response = await http.post(url1, body: json.encode(data));
      var message = jsonDecode(response.body);
      setState(() {
        MainScreen.kidsId = message['kids_id'];
        loginPrefs.setString("kidsId", MainScreen.kidsId);
      });

      var data1 = {
        'id': MainScreen.kidsId,
      };
      var response1 = await http.post(url2, body: json.encode(data1));
      var name = jsonDecode(response1.body);
      setState(() {
        MainScreen.studentName = name['name'];
      });
      await setSessionId();
    } catch (e) {
      print(e);
    }
  }

  void setSessionId() async {
    var url3 = "https://kidsapp.ruha.co.in/flutterGetSession.php";
    var data = {
      'kids_id': MainScreen.kidsId,
    };
    var response = await http.post(url3, body: json.encode(data));
    var message = jsonDecode(response.body);
    setState(() {
      MainScreen.session = message['rand_no'];
    });
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
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.error,color: Colors.redAccent,size: 50.w,),
                      SizedBox(height: 10.h,),
                      Text("You have Still Not Connected to any Network ! ",textAlign:TextAlign.center,style:TextStyle(fontFamily: "Raleway",fontSize: ScreenUtil().setSp(20),color: Colors.redAccent,fontWeight:FontWeight.w600),),
                      SizedBox(height: 10.h,),
                      Text("Please Connect to Internet \nto learn exciting things !",textAlign:TextAlign.center,style:TextStyle(fontFamily: "Raleway",fontSize: ScreenUtil().setSp(15),color: Colors.green,fontWeight:FontWeight.w600),),
                      SizedBox(height: 30.h,),
                      RaisedButton(
                        onPressed: () {
                          exit(0);
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
