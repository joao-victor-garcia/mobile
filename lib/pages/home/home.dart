import 'package:flutter/material.dart';
import 'package:cleaning_tracker/widgets/custom_progress_indicator.dart';
import 'package:cleaning_tracker/widgets/custom_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cleaning_tracker/widgets/custom_service_cards_home.dart';
import 'package:flutter/widgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String mensagemBoasVindas = "Welcome!";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getDisplayName(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          String displayName = snapshot.data ?? "Usuário";
          mensagemBoasVindas = "Welcome $displayName!";
          return _buildContent();
        }
      },
    );
  }

  Future<String?> acessarDocumentoPorEmail(String email) async {
    try {
      CollectionReference employees =
          FirebaseFirestore.instance.collection('employees');

      QuerySnapshot querySnapshot =
          await employees.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        String name = data['name'];

        return name;
      } else {
        print("Documento não encontrado para o e-mail fornecido.");
      }
    } catch (e) {
      print("Erro ao acessar o documento por e-mail: $e");
    }
    return null;
  }

  Future<String?> _getDisplayName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? email = user.email;
      if (email != null) {
        return acessarDocumentoPorEmail(email);
      }
    }
    return null;
  }

  Widget _buildContent() {
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: SizedBox(
                  height: 15,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 250,
                          child: Text(
                            mensagemBoasVindas,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 35),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: 250,
                          child: Text(
                            "Check your services of the day",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      child: Column(
                        children: [CustomProgressIndicator(progresso: 1)],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: SizedBox(
                  height: 10,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(
                      "Pending",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        CustomCardHome(title: 'Deborah', hours: 2, status: 1),
                        CustomCardHome(title: 'Deborah', hours: 2, status: 1),
                        CustomCardHome(title: 'Deborah', hours: 2, status: 1),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(
                      "Completed",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        CustomCardHome(title: 'Elena', hours: 5, status: 1),
                        CustomCardHome(title: 'Elena', hours: 5, status: 1),
                      ],
                    ),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
