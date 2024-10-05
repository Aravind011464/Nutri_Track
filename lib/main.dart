import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nutri_track/pages/dashboard.dart';
import 'package:nutri_track/pages/sign_in.dart';
import 'package:nutri_track/pages/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutri_track/pages/bmi_page.dart';
import 'package:nutri_track/pages/z_score_page.dart';
import 'package:nutri_track/pages/update_page.dart';
import 'package:nutri_track/pages/diet_chart_page.dart';
import 'package:nutri_track/pages/advice_page.dart';
import 'package:nutri_track/pages/needs_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  runApp(MyApp(token : token));
}

class MyApp extends StatelessWidget {
  final token;
  const MyApp({@required this.token, Key? key}) :  super(key:key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/signup' : (context)=> SignUp(),
        '/signin' : (context)=>SignIn(),
        '/dashboard' : (context)=>DashBoard(),
        '/bmi': (context) => BMIPage(),                       // Route for BMI Page
        '/zscore': (context) => ZScorePage(),                 // Route for Z-Score Page
        '/update': (context) => UpdatePage(),                 // Route for Update Page
        '/dietchart': (context) => DietChartPage(),           // Route for Diet Chart Page
        '/advice': (context) => AdvicePage(),                 // Route for Advice Page
        '/needs': (context) => NeedsPage(),
      },
      // home: (token != null && JwtDecoder.isExpired(token) == false) ? DashBoard(token: token) : SignIn(),
      home:DashBoard(),
    );
  }
}


