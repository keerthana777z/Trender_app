// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trender_demo/pages/swipe.dart';

//here we are using statefull widget because we need to get updates from the screen
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //variables
  // controllers to get username and password input
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //methods-
 void signIn() async{
   await FirebaseAuth.instance.signInWithEmailAndPassword(email:_usernameController.text , 
   password: _passwordController.text);

 }
  //UI Design
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // gradient background
      body: Container(
        decoration: BoxDecoration(
          // Linear gradient from top left to bottom right
          gradient: LinearGradient(
            colors: [Color(0xFFFE5048), Color(0xFFFD2C72)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
              children: [

                // Logo
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    'lib/images/trender_hori_white.png',
                    height: 120, // Set logo height
                  ),
                ),

                // Text
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Swipe to find your Match\nin Style and LOVE!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 50), // Space between input field and button


                // Username input field
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    controller: _usernameController, // Set controller to capture input
                    decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white24,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                // Password input field
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    controller: _passwordController, // Set controller to capture input
                    obscureText: true, // Mask the password input
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white24,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                SizedBox(height: 20), // Space between input field and button

                // for horizontal arrangement of the buttons gayu
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Evenly space the buttons
                  children: [
                    // Login button
                    GestureDetector(
                      onTap: signIn,
                        /*String username = _usernameController.text;
                        String password = _passwordController.text;
                         
                        // Handle login logic here
                        print('Username: $username, Password: $password');


                        //COMMENTING TO MAKE FUN ;p

                        //navigate to swipe page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SwipePage()),
                        );*/
                      
                      child: Container(
                        width: 120, // Set button width
                        decoration: BoxDecoration(
                          color: Colors.white, 
                          borderRadius: BorderRadius.circular(25), 
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26, 
                              blurRadius: 10, 
                              offset: Offset(0, 4), 
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10), // Button padding
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Color(0xFFC2185B), 
                              fontSize: 16, 
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Register button
                    GestureDetector(
                      onTap: () {
                        String username = _usernameController.text;
                        String password = _passwordController.text;
                        // Handle register logic here
                        print('Username: $username, Password: $password');
                        print("Registered!");
                      },
                      child: Container(
                        width: 120, // Set button width
                        decoration: BoxDecoration(
                          color: Colors.white, 
                          borderRadius: BorderRadius.circular(25), 
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26, 
                              blurRadius: 10, 
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10), // Button padding
                        child: Center(
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Color(0xFFC2185B), 
                              fontSize: 16, 
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}