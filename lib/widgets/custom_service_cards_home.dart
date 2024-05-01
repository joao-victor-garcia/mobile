import 'package:flutter/material.dart';

class CustomCardHome extends StatelessWidget {
  final String title;
  final double hours;
  final int status;

  const CustomCardHome(
      {Key? key,
      required this.title,
      required this.hours,
      required this.status})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 217, 217, 217),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.schedule_outlined),
              Text(
                '$hours hrs',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.error_outline_outlined,
                color: Color.fromARGB(255, 244, 67, 54),
              ),
              Text(
                'status',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox()
        ],
      ),
    );
  }
}
