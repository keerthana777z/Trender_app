import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:trender_demo/pages/login.dart";
import 'package:trender_demo/pages/swipe.dart';
class AuthPage extends StatelessWidget{
  const AuthPage({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context, snapshot) {
          //user loggedin
          if(snapshot.hasData){
            // ignore: prefer_const_constructors
            return SwipePage();
          }
          //user not logged in
          else{
            return LoginPage();
          }
        },
        ),
    );
  }
}