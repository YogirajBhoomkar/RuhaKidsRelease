import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ruhakids/Screens/ContactScreen.dart';
import 'package:ruhakids/Screens/FAQScreen.dart';
import 'package:ruhakids/Screens/LanguageColor.dart';
import 'package:ruhakids/Screens/LoginScreen.dart';
import 'package:ruhakids/Screens/MainScreen.dart';
import 'package:ruhakids/Screens/PrimaryLanguage.dart';
import 'package:ruhakids/Screens/PrivacyPolicy.dart';
import 'package:ruhakids/Screens/RegisterationScreen.dart';
import 'package:ruhakids/Screens/MobileVerification.dart';
import 'package:ruhakids/Screens/SettingsScreen.dart';
import 'package:ruhakids/Screens/ThanksGivingScreen.dart';
import 'Screens/SplashScreen.dart';
void main() {
  runApp(RuhaKids());
}

class RuhaKids extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Splashscreen.id,
      routes: {
        Splashscreen.id: (context) =>Splashscreen(),
        MainScreen.id:(context) =>MainScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterationScreen.id: (context) => RegisterationScreen(),
        MobileVerificationScreen.id: (context) => MobileVerificationScreen(),
        PrimaryLanguage.id: (context) => PrimaryLanguage(),
        LanguageColorScreen.id:(context) => LanguageColorScreen(),
        ThanksGivingScreen.id:(context) => ThanksGivingScreen(),
        SettingsScreen.id:(context) => SettingsScreen(),
        ContactScreen.id:(context) => ContactScreen(),
        FAQScreen.id:(context) => FAQScreen(),
        PrivacyPolicyScreen.id:(context) => PrivacyPolicyScreen(),
      },
    );

  }
}

