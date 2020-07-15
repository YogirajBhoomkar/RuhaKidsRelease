import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ruhakids/Screens/LoginScreen.dart';
import 'package:ruhakids/Screens/MainScreen.dart';
import 'package:ruhakids/Screens/RegisterationScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MobileVerificationScreen extends StatefulWidget {
  @override
  static String id = "MobileVerificationScreen";
  static String passcode;
  static String parentMobile = null;

  @override
  _MobileVerificationScreen createState() => _MobileVerificationScreen();
}

class _MobileVerificationScreen extends State<MobileVerificationScreen> {
  void init() async {
    SharedPreferences loginPrefs = await SharedPreferences.getInstance();
    setState(() {
      MobileVerificationScreen.parentMobile = loginPrefs.get('parentMobile');
    });
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: double.infinity,
                  child: Image.asset('images/kidOnLaptop.png'),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(60),
                      bottom: ScreenUtil().setHeight(10)),
                  child: Text(
                    "Enter the Passcode.",
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: ScreenUtil().setSp(30),
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF63609B)),
                    textAlign: TextAlign.center,
                  ),
                ),
                RegisterationScreen.visitedRegisterationScreen == false
                    ? Container(
                        padding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "Enter Mobile Number here",
                              hintStyle: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: ScreenUtil().setSp(17),
                                  fontWeight: FontWeight.w300)),
                          onChanged: (value) {
                            setState(() {
                              MobileVerificationScreen.parentMobile = value;
                            });
                          },
                        ),
                        height: 50.h,
                        width: 300.w,
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(25)),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.4,
                                style: BorderStyle.solid,
                                color: Color(0xFF63609B)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                          ),
                        ),
                      )
                    : Container(),
                Container(
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Enter the passcode here",
                        hintStyle: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: ScreenUtil().setSp(17),
                            fontWeight: FontWeight.w300)),
                    onChanged: (value) {
                      setState(() {
                        MobileVerificationScreen.passcode = value;
                      });
                    },
                  ),
                  height: 50.h,
                  width: 300.w,
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(25)),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1.4,
                          style: BorderStyle.solid,
                          color: Color(0xFF63609B)),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(50),
                  ),
                  child: Container(
                    decoration: ShapeDecoration(
                      color: Color(0xFF63609B),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1.4,
                            style: BorderStyle.solid,
                            color: Color(0xFF63609B)),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                    ),
                    margin: EdgeInsets.only(top: 30.h),
                    width: 300.w,
                    height: 50.h,
                    child: FlatButton(
                      onPressed: () {
                          check();
                      },
                      child: Text(
                        "Check",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(17),
                            color: Colors.white,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void dispose() {
    super.dispose();
  }

  void check() async {
    SharedPreferences loginPrefs = await SharedPreferences.getInstance();
    String finalNumber;
    if (RegisterationScreen.visitedRegisterationScreen == false) {
      if (MobileVerificationScreen.parentMobile.length < 10) {
        DangerAlertBoxCenter(
          context: context,
          titleTextColor: Colors.redAccent,
          messageText: "Please check if mobile number or passcode entered is correct",
          buttonText: "Okay",
        );
      } else {
        finalNumber = MobileVerificationScreen.parentMobile;
        loginPrefs.setString('parentMobile', finalNumber);
      }
    } else {
      finalNumber = RegisterationScreen.mobileNumber;
    }
    var url = "https://kidsapp.ruha.co.in/flutterCheckPasscode.php";
    var data = {
      'passcode': MobileVerificationScreen.passcode,
      'parentMobile': finalNumber,
    };

    var response = await http.post(url, body: json.encode(data));
    var message = jsonDecode(response.body);
    if (message == "Login Matched") {
      loginPrefs.setBool('isLogged', true);
      loginPrefs.setString('passcode', MobileVerificationScreen.passcode);
      MainScreen mainScreen=MainScreen();
      Navigator.pushReplacementNamed(context, MainScreen.id);
    } else {
      DangerAlertBoxCenter(
        context: context,
        titleTextColor: Colors.redAccent,
        messageText: "Invalid Passcode or Mobile Number",
        buttonText: "Okay",
      );
    }
  }
  void checkConnectivity() async{
    SharedPreferences loginPrefs = await SharedPreferences.getInstance();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      DangerAlertBoxCenter(
        context: context,
        titleTextColor: Colors.redAccent,
        messageText:
        "Please check the age or name entered is incorrect",
        buttonText: "Okay",
      );
      loginPrefs.clear();
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    }
  }
}
