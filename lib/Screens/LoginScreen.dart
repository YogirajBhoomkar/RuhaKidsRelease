import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ruhakids/Screens/PrimaryLanguage.dart';
import 'package:ruhakids/Screens/RegisterationScreen.dart';
import 'package:ruhakids/Screens/MobileVerification.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  static String id = "LoginScreen";
  static String name = null;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  void initState() {
    if (RegisterationScreen.visitedRegisterationScreen == true) {
      setState(() {
        RegisterationScreen.visitedRegisterationScreen = false;
        LoginScreen.name=null;
      });
    }
    super.initState();
  }

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
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      left: 120.w, top: 20.h, right: 120.w, bottom: 40.h),
                  child: Container(child: Image.asset('images/small.png'))),
              Text(
                "Personalize your child’s\nlearning experience",
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: ScreenUtil().setSp(27),
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF0CBA9F)),
                textAlign: TextAlign.center,
              ),
              Container(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Enter child's name here.",
                    hintStyle: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: ScreenUtil().setSp(17),
                        fontWeight: FontWeight.w300),
                  ),
                  onChanged: (value) {
                    setState(() {
                      LoginScreen.name = value;
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
                        color: Color(0xFF0CBA9F)),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
              ),
              Container(
                decoration: ShapeDecoration(
                  color: Color(0xFF0CBA9F),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1.4,
                        style: BorderStyle.solid,
                        color: Color(0xFF0CBA9F)),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
                margin: EdgeInsets.only(top: 30.h),
                width: 300.w,
                height: 50.h,
                child: FlatButton(
                    onPressed: () async {
                      SharedPreferences loginPrefs =
                          await SharedPreferences.getInstance();
                      loginPrefs.setString('name', LoginScreen.name);
                      if (LoginScreen.name != null) {
                        if (LoginScreen.name.length != 0) {
                          Navigator.pushNamed(context, PrimaryLanguage.id);
                        } else {
                          DangerAlertBoxCenter(
                            context: context,
                            titleTextColor: Colors.redAccent,
                            messageText:
                                "Please check the age or name entered is incorrect",
                            buttonText: "Okay",
                          );
                        }
                      } else {
                      }
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(17),
                          color: Colors.white,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400),
                    )),
              ),
              Container(
                decoration: ShapeDecoration(
                  color: Color(0xFFFFC400),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1.4,
                      style: BorderStyle.solid,
                      color: Color(0xFFFFC402),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
                margin: EdgeInsets.only(top: 15.h),
                width: 300.w,
                height: 50.h,
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      RegisterationScreen.visitedRegisterationScreen = false;
                    });

                    Navigator.pushNamed(context, MobileVerificationScreen.id);
                  },
                  child: Text(
                    "Enter Passcode",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(17),
                        color: Colors.white,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.h, right: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      constraints:
                          BoxConstraints.expand(width: 250.w, height: 245.h),
                      width: 250.w,
                      height: 150.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/kidsStudy.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dispose() {
    super.dispose();
  }
}
