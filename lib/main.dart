// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:trender_demo/pages/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}
//note for keer and gayu
//so basicallly if u have to run the main.dart file to run the whole thing
//this project has 7 pages in total :- splashscreen,login,swipe,explore,profile,chat,logout
//all the images are in the assets folder