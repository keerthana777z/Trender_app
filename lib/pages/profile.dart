// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trender_demo/pages/explore.dart';
import 'package:trender_demo/pages/chat.dart';
import 'package:trender_demo/pages/swipe.dart';
import 'package:trender_demo/pages/logout.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 4; // Sets to Profile page
  // ignore: unused_field
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
 String _userEmail = ''; // Initialize an empty string to store the user's email

  @override
  void initState() {
    super.initState();
    _getUserEmail(); // Call the function to get the user's email
  }

  Future<void> _getUserEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userEmail = user.email ?? ''; // Update the _userEmail variable with the user's email
      });
    }
  }
 // This should be fetched from the login page

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ExplorePage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SwipePage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LogoutPage()),
        );
        break;
      case 4:
        // Already on Profile, do nothing
        break;
    }
  }

  //UI Design
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // App bar with logo and menu icon
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.25),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Image.asset(
            'lib/images/trender_hori_red.png',
            height: 40,
          ),
        ),
      ),

      // Drawer that opens on menu icon tap
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFE5048), Color(0xFFFD2C72)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: Image.asset(
                  'lib/images/trender_hori_white.png',
                  height: 40,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      // Bottom navigation bar with custom icons
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? Image.asset('lib/images/trender_selected.png', height: 32)
                : Image.asset('lib/images/trender_unselected.png', height: 30),
            label: 'Trender',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Logout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Color.fromARGB(255, 66, 66, 66),
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),

      // Body content for the Profile page
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFFFE5048), Color(0xFFFD2C72)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('lib/images/profile_pic.png'),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.pink,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        // Handle edit profile picture
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom:0,
                  child: Container(
                    width: 170,
                    height: 37,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [Color(0xFFFE5048), Color(0xFFFD2C72)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Text(
                      _userEmail,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            _buildProfileButton(Icons.shopping_bag, 'Orders'),
            _buildProfileButton(Icons.help_center, 'Help Center'),
            _buildProfileButton(Icons.star, 'Myntra Insider'),
            _buildProfileButton(Icons.emoji_events, 'Challenges'),
            _buildProfileButton(Icons.favorite, 'Wishlist'),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileButton(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink,
          side: BorderSide(color: Colors.white, width: 2), // White outline
          elevation: 5, // Elevated appearance
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(18),
        ),
        onPressed: () {
          // Handle button press
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}