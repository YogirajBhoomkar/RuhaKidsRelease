import 'dart:convert';
import 'dart:io';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:ruhakids/Screens/LoginScreen.dart';
import 'package:ruhakids/Screens/MainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';

class SettingsScreen extends StatefulWidget {
  static String id = "SettingsScreen";
  static String primaryLanguage;
  static var studentName = "Enter your Name here";
  static String mobileNumber = "Enter mobile Number here.";
  static var emailAddress = "Enter Email Address here.";
  static String updateStatus = "failure";
  static bool visited=false;

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String dropdownValue = 'English';

  void initState() {
    setState(() {
      SettingsScreen.visited=true;
    });
    checkConnectivity();
    getKidsInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (dropdownValue == null || SettingsScreen.primaryLanguage == null) {
      SettingsScreen.primaryLanguage = "English";
      dropdownValue = "English";
    }
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
          title: Text("Settings",style: TextStyle(fontSize: ScreenUtil().setSp(22.w),fontFamily: "Raleway"),),
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
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Image.asset("images/settings.png"),
                Text(
                  "Your Profile",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: ScreenUtil().setSp(35),
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0CBA9F),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(10), top: 5.h),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: SettingsScreen.studentName,
                      hintStyle: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: ScreenUtil().setSp(17),
                          fontWeight: FontWeight.w300),
                      suffixIcon: Icon(Icons.edit),
                    ),
                    onChanged: (value) {
                      setState(() {
                        SettingsScreen.studentName = value;
                      });
                    },
                  ),
                  height: 60.h,
                  width: 350.w,
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(35)),
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
                GestureDetector(
                  onTap: () {
                    WarningAlertBoxCenter(
                      context: context,
                      titleTextColor: Colors.redAccent,
                      messageText:
                          "\n\n Mobile Number Cannot be Updated ! \n\n",
                      buttonText: "Okay",
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(10), top: 5.h),
                    child: TextField(
                      enableInteractiveSelection: false,
                      // will disable paste operation
                      enabled: false,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        labelText: SettingsScreen.mobileNumber,
                        labelStyle: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: ScreenUtil().setSp(17),
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
                        suffixIcon: Icon(Icons.lock),
                      ),
                      onChanged: (value) {},
                    ),
                    height: 60.h,
                    width: 350.w,
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
                    decoration: ShapeDecoration(
                      color: Colors.blueGrey.shade50,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1.4,
                            style: BorderStyle.solid,
                            color: Color(0xFF0CBA9F)),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(10), top: 5.h),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      suffixIcon: Icon(Icons.edit),
                      hintText: SettingsScreen.emailAddress,
                      hintStyle: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: ScreenUtil().setSp(17),
                          fontWeight: FontWeight.w300),
                    ),
                    onChanged: (value) {
                      setState(() {
                        SettingsScreen.emailAddress = value;
                      });
                    },
                  ),
                  height: 60.h,
                  width: 350.w,
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
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
                  margin: EdgeInsets.only(top: 15.h),
                  height: 50.h,
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(25)),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1.5,
                          style: BorderStyle.solid,
                          color: Color(0xFF0CBA9F)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  width: 350.w,
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
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
                              color: Color(0xFF0CBA9F)),
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    value: dropdownValue,
                    icon: Icon(
                      Icons.arrow_downward,
                      color: Color(0xFF0CBA9F),
                    ),
                    iconSize: 24,
                    elevation: 16,
                    onChanged: (String newValue) async {
                      SharedPreferences loginPrefs =
                          await SharedPreferences.getInstance();
                      setState(() {
                        dropdownValue = newValue;
                        SettingsScreen.primaryLanguage = dropdownValue;
                        loginPrefs.setString(
                            'primaryLanguage', SettingsScreen.primaryLanguage);
                      });
                    },
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
                        final bool isValid = EmailValidator.validate(
                            SettingsScreen.emailAddress);
                        if (isValid == true) {
                          await updateInfo();
                          if (SettingsScreen.updateStatus == "success") {
                            SuccessAlertBox(
                              context: context,
                              titleTextColor: Colors.green,
                              messageText:
                                  "\n\nInformation Updated Successfully!\n\n",
                              buttonText: "Okay",
                            );
                          } else {
                            DangerAlertBoxCenter(
                              context: context,
                              titleTextColor: Colors.redAccent,
                              messageText:
                                  "\n\nSome Information is same as previous!\nCan't Update ! \n\n",
                              buttonText: "Okay",
                            );
                          }
                        } else {
                          DangerAlertBoxCenter(
                            context: context,
                            titleTextColor: Colors.redAccent,
                            messageText: "\n\nInvalid Email Address \n\n",
                            buttonText: "Okay",
                          );
                        }
                      },
                      child: Text(
                        "Set",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(17),
                            color: Colors.white,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getKidsInfo() async {
    SharedPreferences loginPrefs = await SharedPreferences.getInstance();
    setState(() {
      SettingsScreen.studentName = MainScreen.studentName;
      SettingsScreen.mobileNumber = loginPrefs.get('parentMobile');
    });
    var urlAddress = "https://kidsapp.ruha.co.in/flutterGetEmailAddress.php";
    var dataAddress = {
      'passcode': loginPrefs.get('passcode'),
    };
    var responseID =
        await http.post(urlAddress, body: json.encode(dataAddress));
    var address = jsonDecode(responseID.body);
    var urlPrimaryLanguage =
        "https://kidsapp.ruha.co.in/flutterGetPrimaryLanguage.php";
    var dataPrimaryLanguage = {
      'passcode': loginPrefs.get('passcode'),
    };

    var responsePrimaryLanguage = await http.post(urlPrimaryLanguage,
        body: json.encode(dataPrimaryLanguage));
    var primaryLanguage = jsonDecode(responsePrimaryLanguage.body);
    setState(() {
      SettingsScreen.emailAddress = address['email'];
      dropdownValue = primaryLanguage['language'];
      MainScreen.primaryLanguage=primaryLanguage['language'];
    });
  }

  void updateInfo() async {
    SharedPreferences loginPrefs = await SharedPreferences.getInstance();
    var urlUpdateInfo = "https://kidsapp.ruha.co.in/flutterUpdateProfile.php";
    var dataUpdateInfo = {
      'email': SettingsScreen.emailAddress,
      'language': SettingsScreen.primaryLanguage,
      'passcode': loginPrefs.get("passcode"),
    };
    var responseUpdateInfo =
        await http.post(urlUpdateInfo, body: json.encode(dataUpdateInfo));
    var urlNameInfo = "https://kidsapp.ruha.co.in/flutterUpdateName.php";
    var dataNameInfo = {
      'name': SettingsScreen.studentName,
      'rand_no': MainScreen.session,
    };
    var responseNameInfo =
        await http.post(urlNameInfo, body: json.encode(dataNameInfo));
    setState(() {
      if ((responseNameInfo.body == "success")) {
        SettingsScreen.updateStatus = "success";
      } else if ((responseUpdateInfo.body == "success")) {
        SettingsScreen.updateStatus = "success";
      } else {
        SettingsScreen.updateStatus = "faliure";
      }

      SettingsScreen.studentName = MainScreen.studentName;
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
                          Navigator.pushReplacementNamed(context, SettingsScreen.id);
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

}
