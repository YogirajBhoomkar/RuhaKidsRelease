import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ruhakids/Screens/LoginScreen.dart';
import 'package:ruhakids/Screens/MainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Splashscreen extends StatefulWidget {
  static String id = "Splashscreen";

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 414.0;
    double defaultScreenHeight = 896.0;
    ScreenUtil.init(context,
        width: defaultScreenWidth,
        height: defaultScreenHeight,
        allowFontScaling: false);
    return Center(
      child: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/splashChildren.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 120.h),
              child: Container(child: Image.asset('images/Logo.png'))),
        ],
      ),
    );
  }

  startTime() async {
    var duration = new Duration(seconds: 5);
    return new Timer(duration, route);
  }

  route() async {
    SharedPreferences loginPrefs = await SharedPreferences.getInstance();
    if (loginPrefs.get('isLogged') == null) {
      loginPrefs.setBool('isLogged', false);
    }
    if (loginPrefs.getBool('isLogged')) {
      Navigator.pushReplacementNamed(context, MainScreen.id);
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
