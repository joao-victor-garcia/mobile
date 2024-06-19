import 'package:cleaning_tracker/pages/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:cleaning_tracker/pages/home/home.dart';
import 'package:cleaning_tracker/widgets/custom_drawer.dart';

class IncomeInfoScreen extends StatefulWidget {
  const IncomeInfoScreen();

  @override
  State<IncomeInfoScreen> createState() => _IncomeInfoScreenState();
}

class _IncomeInfoScreenState extends State<IncomeInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Income Info"),
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
            ],
          );
        }),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
