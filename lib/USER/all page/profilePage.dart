import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/USER/Screen/LoginScreen.dart';
import 'package:myapp/USER/all%20page/profilesetting.dart';
import 'dart:io';

class Profilepage extends StatefulWidget {
  const Profilepage();

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  File? _profileImage;

  void _handleTileTap(String title) async {
    switch (title) {
      case "Setting":
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Profilesetting()),
        );
        if (result != null && result is File) {
          setState(() {
            _profileImage = result;
          });
        }
        break;
      case "Notification":
        // This will be handled by the ExpansionTile
        break;
      case "Logout":
        print("Logging out");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("Profil",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        leadingWidth: 70,
      ),
      backgroundColor: Color.fromARGB(206, 197, 197, 197),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          // COLUMN THAT WILL CONTAIN THE PROFILE
          Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : AssetImage('assets/fadli.png'),
              ),
              SizedBox(height: 20),
              Text(
                "Muhammad Chafidzul Fadzli",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...List.generate(
            customListTiles.length,
            (index) {
              final tile = customListTiles[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.black12,
                  child: tile.title == "Notification"
                      ? ExpansionTile(
                          leading: Icon(tile.icon),
                          title: Text(tile.title),
                          children: [
                            ListTile(
                              title: Text('lengkapi profil anda'),
                              onTap: () {
                                // Handle notification 1 tap
                              },
                            ),
                            ListTile(
                              title: Text('keranjang anda kosong'),
                              onTap: () {
                                // Handle notification 2 tap
                              },
                            ),
                            ListTile(
                              title: Text('cek promo terbaru kami'),
                              onTap: () {
                                // Handle notification 3 tap
                              },
                            ),
                          ],
                        )
                      : ListTile(
                          leading: Icon(tile.icon),
                          title: Text(tile.title),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _handleTileTap(tile.title),
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomListTile {
  final IconData icon;
  final String title;
  CustomListTile({
    required this.icon,
    required this.title,
  });
}

List<CustomListTile> customListTiles = [
  CustomListTile(
    icon: Icons.settings_accessibility_outlined,
    title: "Setting",
  ),
  CustomListTile(
    title: "Notification",
    icon: CupertinoIcons.bell,
  ),
  CustomListTile(
    title: "Logout",
    icon: CupertinoIcons.power,
  ),
];
