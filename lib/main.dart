import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.cyan),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String username, useremail;
  getName(name) {
    this.username = name;
  }

  getEmail(email) {
    this.useremail = email;
  }

  createData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Users").doc(username);

    Map<String, dynamic> users = {"username": username, "useremail": useremail};

    documentReference.set(users).whenComplete(() {
      print("$username created");
    });
  }

  readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Users").doc(username);

    documentReference.get().then((datasnapshot) {
      print(datasnapshot.data);
      print(datasnapshot.data());
    });
  }

  updateData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Users").doc(username);

    Map<String, dynamic> users = {"username": username, "useremail": useremail};

    documentReference.set(users).whenComplete(() {
      print("$username updated");
    });
  }

  deleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Users").doc(username);

    documentReference.delete().whenComplete(() {
      print("$username deleted");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter-Crud"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Name",
                    fillColor: Colors.white24,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String name) {
                  getName(name);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Email",
                    fillColor: Colors.white24,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String email) {
                  getEmail(email);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Text("Create"),
                  onPressed: () {
                    createData();
                  },
                ),
                RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Text("Read"),
                  onPressed: () {
                    readData();
                  },
                ),
                RaisedButton(
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Text("Update"),
                  onPressed: () {
                    updateData();
                  },
                ),
                RaisedButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Text("Delete"),
                  onPressed: () {
                    deleteData();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
