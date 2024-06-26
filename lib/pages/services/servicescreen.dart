import 'package:flutter/material.dart';
import 'package:cleaning_tracker/widgets/custom_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart'; // Adicionado para formatação de data/hora
import 'dart:io';

class ServiceScreen extends StatelessWidget {
  final DocumentSnapshot serviceDocument;

  const ServiceScreen({
    Key? key,
    required this.serviceDocument,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clientName = serviceDocument["clientName"];
    final clientAddress = serviceDocument["address"];
    final int status = serviceDocument["status"];
    final checkin = serviceDocument["checkin"];
    final checkout = serviceDocument["checkout"];

    Timestamp? startTime = checkin != null ? checkin["start_time"] : null;
    Timestamp? endTime = checkout != null ? checkout["end_time"] : null;

    String formatTime(Timestamp? timestamp) {
      if (timestamp == null) return "";
      return DateFormat.jm().format(timestamp.toDate());
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        foregroundColor: Color.fromARGB(255, 53, 62, 69),
        backgroundColor: Color(0xFFB7D3ED),
        onPressed: () {
          _openServiceEntryDialog(context, serviceDocument.id);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
          title: Text('Service'),
          backgroundColor: Color(0xFFB7D3ED),
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          )),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Client: ",
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    "$clientName",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
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
                    "Address:",
                    style: TextStyle(fontSize: 30),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  child: AutoSizeText(
                    clientAddress,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.justify,
                    maxLines: 4,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    "Location",
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
                  Column(
                    children: [
                      Text(
                        "Check in",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(height: 10),
                      if (status == 2 || status == 3) ...[
                        if (startTime != null) ...[
                          Chip(
                            label: Text(
                              formatTime(startTime),
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ],
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Check out",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(height: 10),
                      if (status == 3) ...[
                        if (endTime != null) ...[
                          Chip(
                            label: Text(
                              formatTime(endTime),
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ],
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

void _openAddEntryDialog(BuildContext context, String serviceId) async {
  // Obter o status do serviço antes de abrir o diálogo
  DocumentSnapshot serviceDoc = await FirebaseFirestore.instance
      .collection("services")
      .doc(serviceId)
      .get();
  int currentStatus = serviceDoc["status"];

  String dialogTitle = (currentStatus == 1) ? "Check in" : "Check out";

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          dialogTitle,
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
                ),
              ),
              onPressed: () async {
                await _saveEntry(context, serviceId);
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
    },
  );
}

Future<void> _saveEntry(BuildContext context, String serviceId) async {
  try {
    var status = await Permission.location.request();
    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      Timestamp timestamp = Timestamp.now();

      DocumentSnapshot serviceDoc = await FirebaseFirestore.instance
          .collection("services")
          .doc(serviceId)
          .get();
      int currentStatus = serviceDoc["status"];

      if (currentStatus == 1) {
        await FirebaseFirestore.instance
            .collection("services")
            .doc(serviceId)
            .update({
          "checkin": {
            "start_time": timestamp,
            "checkin_geoloc": GeoPoint(position.latitude, position.longitude),
          },
          "status": 2,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Check-in recorded successfully")),
        );
      } else if (currentStatus == 2) {
        await FirebaseFirestore.instance
            .collection("services")
            .doc(serviceId)
            .update({
          "checkout": {
            "end_time": timestamp,
            "checkout_geoloc": GeoPoint(position.latitude, position.longitude),
          },
          "status": 3,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Check-out recorded successfully")),
        );
      }

      // Obter documento atualizado
      DocumentSnapshot updatedServiceDoc = await FirebaseFirestore.instance
          .collection("services")
          .doc(serviceId)
          .get();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ServiceScreen(serviceDocument: updatedServiceDoc),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location permission denied")),
      );
    }
  } catch (e) {
    print("Error: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed to record check-in")),
    );
  }
}

void _openAddInvoiceDialog(BuildContext context, String serviceId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "Invoice",
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Add a picture of the invoice and the value"),
            SizedBox(height: 10),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color(0xFFB7D3ED)),
              ),
              onPressed: () {
                _pickImage(context, serviceId);
              },
              icon: Icon(Icons.add_a_photo_outlined),
              label: Text(
                "Add photo",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              decoration: InputDecoration(labelText: '£ Invoice value'),
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
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Save"),
          ),
        ],
      );
    },
  );
}

Future<void> _pickImage(BuildContext context, String serviceId) async {
  final ImagePicker _picker = ImagePicker();
  XFile? image;

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Select Image"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                Navigator.of(context).pop();
                image = await _picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  await _uploadImageToFirebase(context, image!, serviceId);
                }
              },
              icon: Icon(Icons.camera),
              label: Text("Camera"),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                Navigator.of(context).pop();
                image = await _picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  await _uploadImageToFirebase(context, image!, serviceId);
                }
              },
              icon: Icon(Icons.photo_library),
              label: Text("Gallery"),
            ),
          ],
        ),
      );
    },
  );
}

Future<void> _uploadImageToFirebase(
    BuildContext context, XFile image, String serviceId) async {
  try {
    // Referência ao Firebase Storage
    final storageRef = FirebaseStorage.instance.ref().child(
        'service_images/$serviceId/${DateTime.now().millisecondsSinceEpoch}.jpg');

    // Faz o upload do arquivo para o Firebase Storage
    final uploadTask = storageRef.putFile(File(image.path));
    final snapshot = await uploadTask.whenComplete(() => null);

    // Obtém a URL da imagem carregada
    final downloadUrl = await snapshot.ref.getDownloadURL();

    // Salva a URL no Firestore
    await _saveImageUrlToFirestore(serviceId, downloadUrl);

    // Mostrar mensagem de sucesso
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Image uploaded successfully")),
      );
    }
  } catch (e) {
    // Mostrar mensagem de erro
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to upload image: $e")),
      );
    }
  }
}

Future<void> _saveImageUrlToFirestore(String serviceId, String imageUrl) async {
  await FirebaseFirestore.instance
      .collection('services')
      .doc(serviceId)
      .update({
    'invoice_data.image_location': imageUrl,
  });
}

void _openServiceEntryDialog(BuildContext context, String serviceId) {
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
                    ),
                  ),
                  onPressed: () {
                    _openAddEntryDialog(context, serviceId);
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
                    ),
                  ),
                  onPressed: () {
                    _openAddInvoiceDialog(context, serviceId);
                  },
                  icon: Icon(Icons.receipt_long_outlined),
                  label: Text(
                    "Add invoice",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
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
    },
  );
}
