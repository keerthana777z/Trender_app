// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:trender_demo/pages/chat.dart';
import 'package:trender_demo/pages/explore.dart';
import 'package:trender_demo/pages/logout.dart';
import 'package:trender_demo/pages/profile.dart';

class SwipePage extends StatefulWidget {
  const SwipePage({super.key});

  @override
  State<SwipePage> createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  //i think when we need bottom navigation and side bar menu we need to do this setting index stuff
  int _selectedIndex = 2; //sets swipe page to default
  List<SwipeItem> _swipeItems = [];
  late MatchEngine _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _imagePaths = [
    {"url":'lib/images/couple_pic_1.png',"name":'desi',"swipe":false},
    {"url":'lib/images/couple_pic_2.png',"name":'streetwear',"swipe":false},
    {"url":'lib/images/couple_pic_3.png',"name":'minimalist_summer',"swipe":false},
    {"url":'lib/images/couple_pic_4.png',"name":"suburban_vintage","swipe":false}
    // Add more images as needed
  ];

  @override
  void initState() {
    for (String imagePath in _imagePaths) {
      _swipeItems.add(SwipeItem(
          content: Content(imagePath: imagePath),
          likeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Liked"),
              duration: Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Nope"),
              duration: Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Superliked"),
              duration: Duration(milliseconds: 500),
            ));
          },
          onSlideUpdate: (region) async {
            print("Region $region");
          }));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

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
        // Already on SwipePage, do nothing
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
        elevation: 4, // ADD SHADOW WHY IS THIS NOT WORKING
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
                // Handle navigation to Home
                Navigator.pop(context); // Close drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle navigation to Settings
                Navigator.pop(context); // Close drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                // Handle logout
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
      
      // Body content with swipeable cards
      body: Column(
        children: [
          Expanded(
            child: SwipeCards(
              matchEngine: _matchEngine,
              itemBuilder: (BuildContext context, int index) {
                return LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                      child: Container(
                        width: constraints.maxWidth,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 10,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.pink,
                            width: 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            _swipeItems[index].content.imagePath,
                            fit: BoxFit.cover,
                            width: constraints.maxWidth,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              onStackFinished: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Stack Finished"),
                  duration: Duration(milliseconds: 500),
                ));
              },
              itemChanged: (SwipeItem item, int index) {
                print("item: ${item.content.imagePath}, index: $index");
              },
              upSwipeAllowed: false, // Disable swipe up
              fillSpace: true,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCircularButton(
                icon: Icons.close,
                color: Colors.white,
                onPressed: () {
                  _matchEngine.currentItem?.nope();
                },
              ),
              _buildCircularButton(
                icon: Icons.star,
                color: Colors.white,
                onPressed: () {
                  _matchEngine.currentItem?.superLike();
                },
              ),
              _buildCircularButton(
                icon: Icons.favorite,
                color: Colors.white,
                onPressed: () {
                  _matchEngine.currentItem?.like();
                },
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCircularButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(20)
      ),
      child: Icon(
        icon,
        color: Colors.pink,
        size: 30,
      ),
    );
  }
}

class Content {
  final String imagePath;

  Content({required this.imagePath});
}