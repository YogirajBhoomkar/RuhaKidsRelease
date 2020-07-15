import 'dart:io';

import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';
import 'package:ruhakids/Screens/LoginScreen.dart';
import 'package:ruhakids/Screens/MainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageColorScreen extends StatefulWidget {
  static String id = "LanguageColorScreen";

  @override
  _LanguageColorScreenState createState() => _LanguageColorScreenState();
}

class _LanguageColorScreenState extends State<LanguageColorScreen> {
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
      appBar: AppBar(
        title: Text("Language Colors",style: TextStyle(fontSize: ScreenUtil().setSp(22.w),fontFamily: "Raleway"),),
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
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top:35.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 370.w,
                height: 70.h,
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Text(
                        "Colors for Languages",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Roboto",
                            fontSize: 22.w),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "(Click on Below Buttons to Hear a Sample)",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Roboto",
                            fontSize: 12.w),
                      )
                    ])),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setSp(3),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () {
                  playLocal("Red Color for English", "Eng");
                },
                child: Container(
                  width: 370.w,
                  height: 70.h,
                  child: Center(
                      child: Text(
                    "Red Color for English",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Roboto",
                        fontSize: 22.w),
                  )),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(
                      ScreenUtil().setSp(3),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () {
                  playLocal(
                      "संस्कृतभाषायाहा कृते नारंगवर्णस्य उपयोगं कुरु", "Mar");
                },
                child: Container(
                  width: 370.w,
                  height: 70.h,
                  child: Center(
                      child: Text(
                    "Orange Color for Sanskrit",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Roboto",
                        fontSize: 22.w),
                  )),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(
                      ScreenUtil().setSp(3),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () {
                  playLocal("मराठीसाठी Brown रंग", "Mar");
                },
                child: Container(
                  width: 370.w,
                  height: 70.h,
                  child: Center(
                      child: Text(
                    "Brown Color for Marathi",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Roboto",
                        fontSize: 22.w),
                  )),
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(
                      ScreenUtil().setSp(3),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () {
                  playLocal("हिंदी के लिए हरा रंग", "Hin");
                },
                child: Container(
                  width: 370.w,
                  height: 70.h,
                  child: Center(
                      child: Text(
                    "Green Color for Hindi",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Roboto",
                        fontSize: 22.w),
                  )),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(
                      ScreenUtil().setSp(3),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Container(
                width: double.infinity,
                child: Image.asset('images/mainscreen.jpg'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  playLocal(String speaking, String languageCode) async {
    VoiceController controller = FlutterTextToSpeech.instance.voiceController();
    controller.init().then((_) {
      controller.setLanguage(languageCode);
      controller.speak(speaking, VoiceControllerOptions(delay: 0));
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
                          Navigator.pushReplacementNamed(context, LanguageColorScreen.id);
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
