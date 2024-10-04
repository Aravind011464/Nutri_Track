import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nutri_track/pages/dashboard.dart';
import 'package:nutri_track/pages/sign_in.dart';
import 'package:nutri_track/pages/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        '/dashboard' : (context)=>DashBoard()
      },
      home: (token != null && JwtDecoder.isExpired(token) == false) ? DashBoard(token: token) : SignIn(),
    );
  }
}


