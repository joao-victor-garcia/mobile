import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double progresso;

  const CustomProgressIndicator({Key? key, required this.progresso})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        SizedBox(
          width: 95,
          height: 95,
          child: CircularProgressIndicator(
            value: progresso,
            backgroundColor: Color.fromARGB(255, 107, 125, 142),
            valueColor: AlwaysStoppedAnimation<Color>(
                Color.fromARGB(255, 183, 211, 237)),
            strokeWidth: 5.0,
          ),
        ),
        SizedBox(height: 20),
        Text(
          '${(progresso * 100).toInt()}%',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
