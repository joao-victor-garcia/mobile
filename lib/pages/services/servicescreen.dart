import 'package:flutter/material.dart';
import 'package:cleaning_tracker/widgets/custom_drawer.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen();

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

void _openAddEntryDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext) {
        return AlertDialog(
          title: Text(
            "Check in",
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Check your location, time and save the record"),
              ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                  Color(0xFFB7D3ED),
                )),
                onPressed: () {
                  //Salvar entrada
                },
                icon: Icon(Icons.check),
                label: Text(
                  "Save entry",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      });
}

void _openAddInvoiceDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext) {
        return AlertDialog(
          title: Text(
            "Invoice",
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Add a picture of the invoice and the value"),
              SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                  Color(0xFFB7D3ED),
                )),
                onPressed: () {
                  //Salvar entrada
                },
                icon: Icon(Icons.add_a_photo_outlined),
                label: Text(
                  "Add photo",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                decoration: InputDecoration(labelText: '£ Invoice value'),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      });
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        foregroundColor: Color.fromARGB(255, 53, 62, 69),
        backgroundColor: Color(0xFFB7D3ED),
        onPressed: () {
          _openServiceEntryDialog(context); //Função que abre o Modal
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Service'),
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
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Client",
                    style: TextStyle(fontSize: 30),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Color.fromARGB(255, 53, 62, 69),
                thickness: 1,
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Address",
                    style: TextStyle(fontSize: 30),
                  )
                ],
              ),
              SizedBox(
                height: 80,
              ),
              Row(
                children: [
                  Text(
                    "Localization",
                    style: TextStyle(fontSize: 30),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Color.fromARGB(255, 53, 62, 69),
                thickness: 1,
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Check in",
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    "Check out",
                    style: TextStyle(fontSize: 30),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  //Função para abrir o dialogo
  void _openServiceEntryDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: AlertDialog(
              backgroundColor: Colors.white,
              title: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(Icons.hail),
                  SizedBox(height: 10),
                  Text(
                    'Service details',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      'Add the check-in, check-out and location of the service. If you have a list of products, select the option, add the value and photo of the invoice.'),
                  SizedBox(height: 40),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                        Color(0xFFB7D3ED),
                      )),
                      onPressed: () {
                        //Navegue para a tela de adição de entrada quando o botão for pressionado
                        _openAddEntryDialog(context);
                      },
                      icon: Icon(Icons.location_on_outlined),
                      label: Text(
                        "Add entry",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                        Color(0xFFB7D3ED),
                      )),
                      onPressed: () {
                        _openAddInvoiceDialog(context);
                      },
                      icon: Icon(Icons.receipt_long_outlined),
                      label: Text(
                        "Add invoice",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
