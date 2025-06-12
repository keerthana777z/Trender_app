// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:trender_demo/pages/chat.dart';
import 'package:trender_demo/pages/swipe.dart';
import 'package:trender_demo/pages/logout.dart';
import 'package:trender_demo/pages/profile.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int _selectedIndex = 0; // Sets to Explore page
  // ignore: unused_field
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  // Sample item data
  List<Map<String, String>> _items = [
    {'name': 'White Midi', 'price': 'Rs.2000\\-', 'image': 'lib/images/card_1.png'},
    {'name': 'Presnte L', 'price': 'Rs.2000\\-', 'image': 'lib/images/card_2.png'},
    {'name': 'Black Dress', 'price': 'Rs.2000\\-', 'image': 'lib/images/card_3.png'},
    {'name': 'Vest VOX', 'price': 'Rs.2000\\-', 'image': 'lib/images/card_4.png'},
    {'name': 'White Midi', 'price': 'Rs.2000\\-', 'image': 'lib/images/card_1.png'},
    {'name': 'Presnte L', 'price': 'Rs.2000\\-', 'image': 'lib/images/card_2.png'},
    {'name': 'Black Dress', 'price': 'Rs.2000\\-', 'image': 'lib/images/card_3.png'},
    {'name': 'Vest VOX', 'price': 'Rs.2000\\-', 'image': 'lib/images/card_4.png'},
  ];

  // Navigation logic

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        // Already on Explore, do nothing
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
    }
  }

  //UI Design
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // White background
      backgroundColor: Colors.white,
      
      // App bar with logo and menu icon
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4, // Add shadow
        shadowColor: Colors.black.withOpacity(0.25),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.black), // Menu icon
            onPressed: () => Scaffold.of(context).openDrawer(), // Open drawer on tap
          ),
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Image.asset(
            'lib/images/trender_hori_red.png', // Logo image
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
                Navigator.pop(context); // Close drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context); // Close drawer
              },
            ),
          ],
        ),
      ),
      
      // Bottom navigation bar with custom icons
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore), // Explore icon
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat), // Chat icon
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? Image.asset('lib/images/trender_selected.png', height: 32) // Selected trender icon
                : Image.asset('lib/images/trender_unselected.png', height: 30), // Unselected trender icon
            label: 'Trender',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app), // Logout icon
            label: 'Logout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), // Profile icon
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, // Set the current index
        selectedItemColor: Colors.pink, // Color of the selected item
        unselectedItemColor: Color.fromARGB(255, 66, 66, 66), // Color of unselected items
        backgroundColor: Colors.white, // Set background color to 0xFFFD2C72
        onTap: _onItemTapped,
        showSelectedLabels: false, // Hide labels when selected
        showUnselectedLabels: false, // Hide labels when unselected
      ),
      
      // Body content for the Explore page
      body: Column(
        children: [
          // Banner Ad
          Container(
            height: 125,
            child: Image.asset(
              'lib/images/banner.png',
              fit: BoxFit.cover,
            ),
          ),

          // Filter Section
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('Women'),
                  _buildFilterChip('Men'),
                  _buildFilterChip('Shoes'),
                  _buildFilterChip('Accessories'),
                  _buildFilterChip('Sale'),
                  _buildFilterChip('+'),
                ],
              ),
            ),
          ),
          // Item Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return _buildItemCard(_items[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  //filtersss
  Widget _buildFilterChip(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Chip(
        label: Text(label),
        backgroundColor: Colors.pink,
        labelStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  //item cardss
   Widget _buildItemCard(Map<String, String> item) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                item['image']!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
              color: Colors.pink,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  item['name']!,
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                Text(
                  item['price']!,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}