import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nutri_track_ios/pages/child_info.dart';
import 'package:nutri_track_ios/pages/dashboard.dart';
import 'package:nutri_track_ios/pages/sign_in.dart';
import 'package:nutri_track_ios/pages/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutri_track_ios/pages/bmi_page.dart';
import 'package:nutri_track_ios/pages/z_score_page.dart';
import 'package:nutri_track_ios/pages/update_page.dart';
import 'package:nutri_track_ios/pages/diet_chart_page.dart';
import 'package:nutri_track_ios/pages/advice_page.dart';
import 'package:nutri_track_ios/pages/needs_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token'); // Token from SharedPreferences is nullable
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final token;  // Make token nullable
  const MyApp({this.token, Key? key}) : super(key: key); // Accept nullable token

  @override
  Widget build(BuildContext context) {
    // Check if token is not null and not expired
    String? validatedToken = (token != null && !JwtDecoder.isExpired(token)) ? token : null;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/signup': (context) => SignUp(),
        '/signin': (context) => SignIn(),
        '/dashboard': (context) => DashBoard(token: validatedToken), // Pass nullable token
        '/bmi': (context) => BMIPage(),
        '/zscore': (context) => ZScorePage(),
        '/update': (context) => UpdatePage(),
        '/dietchart': (context) => DietChartPage(),
        '/advice': (context) => AdvicePage(),
        '/needs': (context) => NeedsPage(),
        '/childEntry' : (context)=>childInfo(),
      },
      home: (token != null && JwtDecoder.isExpired(token) == false) ? DashBoard(token: token) : SignIn(),
      //home: DashBoard(),
      //home : childInfo(),
    );
  }
}
