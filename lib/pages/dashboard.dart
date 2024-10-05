import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class DashBoard extends StatefulWidget {
//   final token;
//   const DashBoard({@required this.token,super.key});
//
//   @override
//   State<DashBoard> createState() => _DashBoardState();
// }
//
// class _DashBoardState extends State<DashBoard> {
//
//   late String email;
//   late SharedPreferences prefs;
//   late bool removeToken;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     print("HELLLOOOOO");
//     Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
//     email = jwtDecodedToken['email'];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body : Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(email),
//             ElevatedButton(
//                 onPressed: () async{
//                   prefs = await SharedPreferences.getInstance();
//                   removeToken = await prefs.remove('token');
//                   if(removeToken){
//                     Navigator.pushNamed(context, '/signin');
//                   }
//                 },
//                 child: Container(
//                   child: Text("Logout"),
//                 )
//             )
//           ],
//         ),
//       )
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'bmi_page.dart';            // Import your BMI page
import 'z_score_page.dart';      // Import your Z-Score page
import 'update_page.dart';       // Import your Update page
import 'diet_chart_page.dart';   // Import your Diet Chart page
import 'advice_page.dart';        // Import your Advice page
import 'needs_page.dart';         // Import your Needs page

class DashBoard extends StatelessWidget {
  // Define a GlobalKey for the Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String userName = "Clarence"; // Initialize the name variable

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
            // Open the drawer when the icon is pressed
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Text("Hi $userName,", style: TextStyle(color: Colors.black)), // Use the variable here
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
                childAspectRatio: 2, // Adjust the ratio to make them smaller
                children: [
                  _buildTappableBox(context, 'BMI', BMIPage()),
                  _buildTappableBox(context, 'Z-Score', ZScorePage()),
                  _buildTappableBox(context, 'Update', UpdatePage()),
                  _buildTappableBox(context, 'Suggest Diet Chart', DietChartPage()),
                  _buildTappableBox(context, 'Seek Advice', AdvicePage()),
                  _buildTappableBox(context, 'Needs', NeedsPage()),
                ],
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'), // Keep Dashboard
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'), // Keep Profile
        ],
        selectedItemColor: Colors.blue,
      ),
      // Drawer for the hamburger menu
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.all(0), // Set header padding to zero
              child: Container(
                height: 100, // Adjust the height of the header as needed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                  crossAxisAlignment: CrossAxisAlignment.start, // Align left
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0), // Padding for "Welcome"
                      child: Text(
                        'Welcome',
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0), // Padding for the name
                      child: Text(
                        userName + " !",
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF673AB7), // Deep Purple
              ),
            ),
            ListTile(
              title: Text('About Us'),
              onTap: () {
                // Handle About Us tap here
                Navigator.pop(context); // Close the drawer first
                // Show About Us dialog or navigate to an About Us page
              },
            ),
            ListTile(
              title: Text('Feedback'),
              onTap: () {
                // Handle Feedback tap here
                Navigator.pop(context); // Close the drawer first
                // Show Feedback form or navigate to a Feedback page
              },
            ),
            Divider(), // Add a divider to separate sections
            ListTile(
              title: Text('Contact Us'),
              onTap: () {
                // Handle Contact Us tap here
                Navigator.pop(context); // Close the drawer first
                // Show Contact Us form or navigate to a Contact Us page
              },
            ),
            ListTile(
              title: Text('Privacy Policy'),
              onTap: () {
                // Handle Privacy Policy tap here
                Navigator.pop(context); // Close the drawer first
                // Show Privacy Policy dialog or navigate to a Privacy Policy page
              },
            ),
            ListTile(
              title: Text('Terms of Service'),
              onTap: () {
                // Handle Terms of Service tap here
                Navigator.pop(context); // Close the drawer first
                // Show Terms of Service dialog or navigate to a Terms of Service page
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
          MaterialPageRoute(builder: (context) => page), // Navigate to the specified page
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: Text(
              action,
              style: TextStyle(
                fontSize: 16, // Make font size smaller
                color: Colors.grey[600], // Change to a greyish color
              ),
            ),
          ),
        ),
      ),
    );
  }
}
