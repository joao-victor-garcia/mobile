import 'package:cleaning_tracker/pages/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:cleaning_tracker/pages/home/home.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen();

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB7D3ED),
        leading: Builder(builder: (context) {
          return Row(
            children: [
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              Text("Profile"),
            ],
          );
        }),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                "Menu",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Color.fromARGB(255, 84, 95, 113),
              ),
              title: Text(
                "Home",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF545F71),
                ),
              ),
            ),
            ListTile(
                leading: Icon(
                  Icons.account_circle_outlined,
                  color: Color.fromARGB(255, 84, 95, 113),
                ),
                title: Text(
                  "Profile",
                  style: TextStyle(
                    color: Color.fromARGB(255, 84, 95, 113),
                    fontWeight: FontWeight.bold,
                  ),
                )),
            ListTile(
                leading: Icon(
                  Icons.calendar_today_outlined,
                  color: Color.fromARGB(255, 84, 95, 113),
                ),
                title: Text(
                  "Week view",
                  style: TextStyle(
                    color: Color.fromARGB(255, 84, 95, 113),
                    fontWeight: FontWeight.bold,
                  ),
                )),
            ListTile(
                leading: Icon(
                  Icons.paid_outlined,
                  color: Color.fromARGB(255, 84, 95, 113),
                ),
                title: Text(
                  "Income info",
                  style: TextStyle(
                    color: Color.fromARGB(255, 84, 95, 113),
                    fontWeight: FontWeight.bold,
                  ),
                )),
            ListTile(
              leading: Icon(
                Icons.logout_outlined,
                color: Color.fromARGB(255, 210, 110, 110),
              ),
              title: Text(
                "Logout",
                style: TextStyle(
                  color: Color.fromARGB(255, 210, 110, 110),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop;
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
