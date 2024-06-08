/*
import 'package:flutter/material.dart';
import 'package:cleaning_tracker/widgets/custom_progress_indicator.dart';
import 'package:cleaning_tracker/widgets/custom_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cleaning_tracker/widgets/custom_service_cards_home.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String mensagemBoasVindas = "Welcome!";
  String? userId; // ID do usuário atual
  int pendingCardsCount = 0;
  int completedCardsCount = 0;

  @override
  void initState() {
    super.initState();
    _getUserId(); // Obter o ID do usuário atual ao iniciar a tela
  }

  void printnumbercards() {
    print("Pendentes = $pendingCardsCount");
    print("Completos = $completedCardsCount");
  }

  Future<void> _getUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String email = user.email ?? "";
      try {
        CollectionReference employees =
            FirebaseFirestore.instance.collection("employees");
        QuerySnapshot querySnapshot =
            await employees.where("email", isEqualTo: email).get();
        if (querySnapshot.docs.isNotEmpty) {
          String userId = querySnapshot.docs.first.id;
          setState(() {
            this.userId = userId;
          });
        }
      } catch (e) {
        print("Erro ao obter ID do usuário: $e");
      }
    }
  }

  Future<String?> _getDisplayName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? id = user.uid;
      if (id != null) {
        return acessarDocumentoPorID(id);
      }
    }
    return null;
  }

  Future<String?> acessarDocumentoPorID(String id) async {
    try {
      CollectionReference employees =
          FirebaseFirestore.instance.collection('employees');

      QuerySnapshot querySnapshot =
          await employees.where('id', isEqualTo: id).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        String name = data['name'];

        return name;
      } else {
        print("Documento não encontrado para o ID fornecido.");
      }
    } catch (e) {
      print("Erro ao acessar o documento por e-mail: $e");
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
                        children: [
                          CustomProgressIndicator(
                            progresso: (1 / 3),
                          )
                        ],
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
                    child: Row(
                      children: [
                        Text(
                          "Pending",
                          style: TextStyle(fontSize: 22),
                        ),
                        SizedBox(height: 30)
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("services")
                          .where("employeemail",
                              isEqualTo: FirebaseAuth.instance.currentUser
                                  ?.email) // Filtrar serviços do usuário atual
                          .where("status",
                              whereIn: [1, 2]) //Filtrar status 1 e 2
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        final services = snapshot.data!.docs;
                        pendingCardsCount =
                            services.length; // Atualiza pendingCardsCount
                        print(pendingCardsCount);
                        return Row(
                          children: services.map<Widget>((service) {
                            final clientName = service["clientName"];
                            final hours = service["hour"];
                            final status = service["status"];
                            return CustomCardHome(
                              title: clientName,
                              hours: hours,
                              status: status,
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Row(
                      children: [
                        Text(
                          "Completed",
                          style: TextStyle(fontSize: 22),
                        ),
                        SizedBox(height: 30)
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("services")
                          .where("employeemail",
                              isEqualTo: FirebaseAuth.instance.currentUser
                                  ?.email) // Filtrar serviços do usuário atual
                          .where("status", whereIn: [3]) //Filtrar status 3
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        final services = snapshot.data!.docs;
                        completedCardsCount =
                            services.length; // Atualiza pendingCardsCount
                        print(completedCardsCount);
                        return Row(
                          children: services.map<Widget>((service) {
                            final clientName = service["clientName"];
                            final hours = service["hour"];
                            final status = service["status"];
                            return CustomCardHome(
                              title: clientName,
                              hours: hours,
                              status: status,
                            );
                          }).toList(),
                        );
                      },
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
}

*/
import 'package:flutter/material.dart';
import 'package:cleaning_tracker/widgets/custom_progress_indicator.dart';
import 'package:cleaning_tracker/widgets/custom_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cleaning_tracker/widgets/custom_service_cards_home.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String mensagemBoasVindas = "Welcome!";
  String? userId; // ID do usuário atual
  int pendingCardsCount = 0;
  int totalCardsCount = 0;
  final startOfDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final endOfDay = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 23, 59, 59);

  @override
  void initState() {
    super.initState();
    _getUserId(); // Obter o ID do usuário atual ao iniciar a tela
  }

  Future<void> _getUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
        print(
            "UID do usuário logado: $userId"); // Debug: Imprime o UID do usuário logado
        _countServices(); //Contar os serviços após obter o ID do usuário
      });
    }
  }

  Future<String?> _getDisplayName() async {
    if (userId != null) {
      return acessarDocumentoPorId(userId!);
    }
    return null;
  }

  Future<String?> acessarDocumentoPorId(String id) async {
    try {
      print(
          "Procurando documento com ID: $id"); // Debug: Imprime o ID do documento procurado
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("employees")
          .where("id", isEqualTo: id)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        String name = data["name"];
        print("Nome encontrado: $name"); // Debug: Imprime o nome encontrado
        return name;
      } else {
        print("Documento não encontrado pelo ID fornecido: $id");
      }
    } catch (e) {
      print("Erro ao acessar o documento por ID: $e");
    }
    return null;
  }

  Future<void> _countServices() async {
    if (userId == null) return;

    //Consultar serviços pendentes (status 1 ou 2)
    QuerySnapshot pendingSnapshot = await FirebaseFirestore.instance
        .collection("services")
        .where("idemployee", isEqualTo: userId)
        .where("status", whereIn: [1, 2])
        .where("execution_date", isGreaterThanOrEqualTo: startOfDay)
        .where("execution_date", isLessThanOrEqualTo: endOfDay)
        .get();
    //Consultar todos os serviços do dia (status 1, 2 e 3)
    QuerySnapshot totalSnapshot = await FirebaseFirestore.instance
        .collection("services")
        .where("idemployee", isEqualTo: userId)
        .where("status", whereIn: [1, 2, 3])
        .where("execution_date", isGreaterThanOrEqualTo: startOfDay)
        .where("execution_date", isLessThanOrEqualTo: endOfDay)
        .get();

    setState(() {
      pendingCardsCount = pendingSnapshot.docs.length;
      totalCardsCount = totalSnapshot.docs.length;
    });
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
                        children: [
                          CustomProgressIndicator(
                            progresso: totalCardsCount == 0
                                ? 0
                                : (totalCardsCount - pendingCardsCount) /
                                    totalCardsCount,
                          )
                        ],
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
                    child: Row(
                      children: [
                        Text(
                          "Pending",
                          style: TextStyle(fontSize: 22),
                        ),
                        SizedBox(height: 30)
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("services")
                          .where("idemployee",
                              isEqualTo: FirebaseAuth.instance.currentUser
                                  ?.uid) // Filtrar serviços do usuário atual
                          .where("status",
                              whereIn: [1, 2]) //Filtrar status 1 e 2
                          .where("execution_date",
                              isGreaterThanOrEqualTo: startOfDay) //
                          .where("execution_date",
                              isLessThanOrEqualTo: endOfDay)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        final services = snapshot.data!.docs;
                        print(pendingCardsCount);
                        return Row(
                          children: services.map<Widget>((service) {
                            final clientName = service["clientName"];
                            final hours = service["hour"];
                            final status = service["status"];
                            return CustomCardHome(
                              title: clientName,
                              hours: hours,
                              status: status,
                              serviceDocument: service,
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Row(
                      children: [
                        Text(
                          "Completed",
                          style: TextStyle(fontSize: 22),
                        ),
                        SizedBox(height: 30)
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("services")
                          .where("idemployee",
                              isEqualTo: FirebaseAuth.instance.currentUser
                                  ?.uid) // Filtrar serviços do usuário atual
                          .where("status", whereIn: [3]) //Filtrar status 3
                          .where("execution_date",
                              isGreaterThanOrEqualTo: startOfDay) //
                          .where("execution_date",
                              isLessThanOrEqualTo: endOfDay)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        final services = snapshot.data!.docs;
                        print(totalCardsCount);
                        return Row(
                          children: services.map<Widget>((service) {
                            final clientName = service["clientName"];
                            final hours = service["hour"];
                            final status = service["status"];
                            return CustomCardHome(
                              title: clientName,
                              hours: hours,
                              status: status,
                              serviceDocument: service,
                            );
                          }).toList(),
                        );
                      },
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getDisplayName(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          String displayName = snapshot.data ?? "Usuário";
          mensagemBoasVindas = "Welcome $displayName!";
          return _buildContent();
        }
      },
    );
  }
}
