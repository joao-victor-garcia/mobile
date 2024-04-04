import 'package:cleaning_tracker/pages/auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cleaning_tracker/pages/profile/profile_screen.dart';
import 'package:cleaning_tracker/widgets/custom_drawer.dart';
import 'package:flutter/widgets.dart';

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
        elevation: 20,
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
      drawer: CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Welcome Kaiju!",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
                    ),
                    Container(
                      width: 300,
                      child: Text(
                        "Check your services of the day",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [],
                )
              ],
            ),
            Row(
              children: [
                Column(
                  children: [Text("Pending"), Row()],
                )
              ],
            ),
            Row(
              children: [
                Column(
                  children: [Text("Completed"), Row()],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
