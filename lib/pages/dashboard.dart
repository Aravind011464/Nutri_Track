import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {
  final token;
  const DashBoard({@required this.token,super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  late String email;
  late SharedPreferences prefs;
  late bool removeToken;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("HELLLOOOOO");
    Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(email),
            ElevatedButton(
                onPressed: () async{
                  prefs = await SharedPreferences.getInstance();
                  removeToken = await prefs.remove('token');
                  if(removeToken){
                    Navigator.pushNamed(context, '/signin');
                  }
                },
                child: Container(
                  child: Text("Logout"),
                )
            )
          ],
        ),
      )
    );
  }
}
