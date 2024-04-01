import 'package:flutter/material.dart';

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
    );
  }
}