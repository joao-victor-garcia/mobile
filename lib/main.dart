import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cleaning_tracker/routes/routes.dart';

void main() async {
  //A linha abaixo permite que a main seja assincrona e que inicie normamente no Android
  DateTime now = DateTime.now();
  print("Timestamp atual do dispositivo: ${now.microsecondsSinceEpoch}");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final ThemeData dialogTheme = ThemeData(
    dialogBackgroundColor: Color.fromARGB(255, 255, 255, 255),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(
          Color.fromARGB(255, 107, 125, 142),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(
          Color.fromARGB(255, 107, 125, 142),
        ),
      ),
    ),
    listTileTheme: ListTileThemeData(
      selectedColor: Color.fromARGB(255, 183, 211, 237),
    ),
    fontFamily: 'Quicksand',
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cleaning Tracker',
      initialRoute: '/splash',
      routes: Routes.routes,
      builder: (BuildContext context, Widget? child) {
        return Theme(data: dialogTheme, child: child!);
      },
    );
  }
}
