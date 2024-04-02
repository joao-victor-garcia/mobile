import 'package:cleaning_tracker/pages/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:cleaning_tracker/pages/profile/profile_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB7D3ED),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
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
                Navigator.pushNamed(context, '/login');
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
