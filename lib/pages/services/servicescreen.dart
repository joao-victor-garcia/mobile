import 'package:flutter/material.dart';
import 'package:cleaning_tracker/widgets/custom_drawer.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen();

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Color.fromARGB(255, 53, 62, 69),
        backgroundColor: Color(0xFFB7D3ED),
        onPressed: () {
          _openServiceEntryDialoge(context); //Função que abre o Modal
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

  //Função para abrir o dialogo
  void _openServiceEntryDialoge(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
      
      title: Column(
        children: [
          Icon(Icons.hail),
          SizedBox(height: 10),
          Text('Service details',style: TextStyle(fontWeight: FontWeight.bold),),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.max,
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add the check-in, check-out and location of the service. If you have a list of products, select the option, add the value and photo of the invoice.'),
          SizedBox(height: 10),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
        });
  }
}
