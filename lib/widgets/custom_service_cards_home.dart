import 'package:cleaning_tracker/pages/services/servicescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cleaning_tracker/routes/routes.dart';

class CustomCardHome extends StatelessWidget {
  final String title;
  final int hours;
  final int status;
  final DocumentSnapshot serviceDocument;

  const CustomCardHome({
    Key? key,
    required this.title,
    required this.hours,
    required this.status,
    required this.serviceDocument,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color iconColor;

    //Definindo a cor do icone com base no status
    if (status == 3) {
      iconData = Icons.check;
      iconColor = Color.fromARGB(255, 0, 168, 87);
    } else if (status == 2) {
      iconData = Icons.sync;
      iconColor = Colors.blueAccent;
    } else {
      iconData = Icons.error_outline_outlined;
      iconColor = Color.fromARGB(255, 244, 67, 54);
    }

    return GestureDetector(
      onTap: () {
        //Navegue para a tela de serviço quando o card for tocado
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ServiceScreen(serviceDocument: serviceDocument),
          ),
        );
      },
      child: Container(
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
                Icon(iconData, color: iconColor),
                Text(
                  'status',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox()
          ],
        ),
      ),
    );
  }
}
