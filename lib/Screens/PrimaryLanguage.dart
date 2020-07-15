import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ruhakids/Screens/LoginScreen.dart';
import 'package:ruhakids/Screens/RegisterationScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrimaryLanguage extends StatefulWidget {
  @override
  static String id = "PrimaryLanguage";
  static String primaryLanguage = "English";

  @override
  _PrimaryLanguage createState() => _PrimaryLanguage();
}

class _PrimaryLanguage extends State<PrimaryLanguage> {
  @override
  String dropdownValue = 'English';

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
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(50)),
              child: Text(
                "Select your\nPrimary Language !",
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: ScreenUtil().setSp(35),
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF14308D)),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 50.h,
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(25)),
              decoration: ShapeDecoration(
                color: Color(0xFF14308D),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1.5,
                      style: BorderStyle.solid,
                      color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
              ),
              width: 300.w,
              child: DropdownButton<String>(
                dropdownColor: Color(0xFF14308D),
                underline: Padding(
                  padding: EdgeInsets.all(5),
                ),
                items: <String>[
                  'English',
                  'Sanskrit',
                  'Marathi',
                  'Hindi',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: ScreenUtil().setSp(20),
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  );
                }).toList(),
                isExpanded: true,
                value: dropdownValue,
                icon: Icon(
                  Icons.arrow_downward,
                  color: Colors.white,
                ),
                iconSize: 24,
                elevation: 16,
                onChanged: (String newValue) async {
                  SharedPreferences loginPrefs =
                      await SharedPreferences.getInstance();
                  setState(() {
                    dropdownValue = newValue;
                    PrimaryLanguage.primaryLanguage = dropdownValue;
                    loginPrefs.setString(
                        'primaryLanguage', PrimaryLanguage.primaryLanguage);
                  });
                },
              ),
            ),
            Container(
              decoration: ShapeDecoration(
                color: Color(0xFF14308D),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1.4,
                      style: BorderStyle.solid,
                      color: Color(0xFF14308D)),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
              margin: EdgeInsets.only(top: 20.h),
              width: 250.w,
              height: 50.h,
              child: FlatButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, RegisterationScreen.id);
                },
                child: Text(
                  "Next",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(17),
                      color: Colors.white,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 320.w,
                child: Image.asset('images/PeopleLanguages.png'),
              ),
            ),
          ],
        )),
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
                          loginPrefs.clear();
                          Navigator.pushReplacementNamed(context, LoginScreen.id);
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
