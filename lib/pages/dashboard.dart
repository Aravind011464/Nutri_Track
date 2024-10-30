import 'package:flutter/material.dart';
import 'bmi_page.dart';            // Import your BMI page
import 'z_score_page.dart';      // Import your Z-Score page
import 'update_page.dart';       // Import your Update page
import 'diet_chart_page.dart';   // Import your Diet Chart page
import 'advice_page.dart';        // Import your Advice page
import 'needs_page.dart';         // Import your Needs page

class DashBoard extends StatefulWidget {
  final String? token; // JWT token is nullable now

  const DashBoard({this.token, Key? key}) : super(key: key); // Constructor accepts nullable token

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late String userName;

  @override
  void initState() {
    super.initState();
    // Check if token is null and extract userName or set default
    if (widget.token != null) {
      // Decode token and extract data
      // Example: Map<String, dynamic> decodedToken = JwtDecoder.decode(widget.token!);
      userName = "SaiKrishnan";  // Replace this with actual extraction from token
    } else {
      userName = "Guest";  // Fallback if token is null
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black), // Hamburger menu icon
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Open the drawer
          },
        ),
        title: Text("Hi $userName,", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Display
            Text(
              'Child Chart',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'What do you want to do today?',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 20),

            // Action Buttons (Routing to different pages)
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2,
                children: [
                  _buildTappableBox(context, 'BMI', BMIPage()),
                  _buildTappableBox(context, 'Z-Score', ZScorePage()),
                  _buildTappableBox(context, 'Update', UpdatePage()),
                  _buildTappableBox(context, 'Suggest Diet Chart', DietChartPage(calories: 700, lifestyle: 'Moderately Active',)),
                  _buildTappableBox(context, 'Seek Advice', AdvicePage()),
                  _buildTappableBox(context, 'Needs', NeedsPage()),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.blue,
      ),
      // Drawer for the hamburger menu
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.all(0),
              child: Container(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Welcome',
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        userName + " !",
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF673AB7),
              ),
            ),
            ListTile(
              title: Text('About Us'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Feedback'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              title: Text('Contact Us'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Privacy Policy'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Terms of Service'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),  // Use 'leading' for the icon on the left
              title: Text('Log out'),
              onTap: () {
                Navigator.pushNamed(context, '/signin');
              },
            ),

          ],
        ),
      ),
    );
  }

  // Tappable Box Widget with Navigation
  Widget _buildTappableBox(BuildContext context, String action, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              action,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ),
        ),
      ),
    );
  }
}
