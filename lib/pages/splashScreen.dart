// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

//guys the thing at the top ignores the errors in the file dont remove the comments
//imports
import 'package:flutter/material.dart';
import 'package:trender_demo/pages/auth_page.dart';
import 'package:trender_demo/pages/login.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});
  //so this is where we need to make our variables and methods if we are gonna use any and then comes the UI

  //variables-

  //methods-

  //UI design
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //gradient background
      body: Container(
        decoration: BoxDecoration(
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
              mainAxisAlignment: MainAxisAlignment.center, // to center stuff vertically
              children: [
                // trender logo
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Image.asset(
                    'lib/images/trender_splash.png',
                    height: 250, 
                  ),
                ),

                // Button -> loginpage
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    // Custom transition animation using PageRouteBuilder - idk if this works
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => AuthPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        var begin = 0.0;
                        var end = 1.0;
                        var tween = Tween(begin: begin, end: end);
                        var fadeAnimation = animation.drive(tween);

                        // Fade transition effect
                        return FadeTransition(
                          opacity: fadeAnimation,
                          child: child,
                        );
                      },
                    ),
                  ),
                  child: SizedBox(
                    width: 200, // button width
                    child: Container(
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
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), // Button padding
                      child: const Center(
                        child: Text(
                          'Swipe Now', // button text
                          style: TextStyle(
                            color: Color(0xFFC2185B), 
                            fontSize: 16, 
                            fontWeight: FontWeight.bold, 
                          ),
                          textAlign: TextAlign.center, 
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
