import 'package:flutter/material.dart';
import 'package:cleaning_tracker/pages/auth/login.dart';
import 'package:cleaning_tracker/routes/routes.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                color: Color.fromARGB(255, 84, 95, 113),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
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
            ),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
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
            ),
            onTap: () {
              Navigator.pushNamed(context, '/weekview');
            },
          ),
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
            ),
            onTap: () {
              Navigator.pushNamed(context, '/incomeinfo');
            },
          ),
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
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', ((route) => false));
            },
          ),
        ],
      ),
    );
  }
}
