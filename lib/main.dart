import 'package:flutter/material.dart';
import 'package:testflutter/Screens/wrapper.dart';
import 'package:testflutter/Services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:testflutter/constants/admin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamProvider<Admin>.value(
                initialData: null,
                value: AuthService().user,
                child: MaterialApp(
                  theme: ThemeData(
                    brightness: Brightness.dark,
                    primaryColor: Colors.blue,
                    primarySwatch: Colors.blue,
                    accentColor: Colors.white,
                  ),
                  home: Wrapper(),
                  debugShowCheckedModeBanner: false,
                ));
          }
          return Text("Chargement...");
        });
  }
}
