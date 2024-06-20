import 'package:flutter/material.dart';
import 'package:climbkit/pages/pengguna.dart'; // Import DataPenggunaPage
import 'package:climbkit/pages/tentang.dart'; // Import TentangPage
import 'package:climbkit/main.dart'; // Import MainPage
import 'package:get_storage/get_storage.dart';

class HalamanProfil extends StatelessWidget {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                    'https://iili.io/dHzxrPI.jpg'), // User's profile picture URL
              ),
            ),
            SizedBox(height: 16),
            Text(
              box.read('displayName'), // User's name
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
            SizedBox(height: 32),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.green),
                    title: Text(
                      'Data Pengguna',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.arrow_forward, color: Colors.green),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DataPenggunaPage(),
                        ),
                      );
                    },
                  ),
                  Divider(color: Colors.green[300], thickness: 1),
                  ListTile(
                    leading: Icon(Icons.info, color: Colors.green),
                    title: Text(
                      'Tentang Aplikasi',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.arrow_forward, color: Colors.green),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TentangPage(),
                        ),
                      );
                    },
                  ),
                  Divider(color: Colors.green[300], thickness: 1),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.green),
                    title: Text(
                      'Log Out',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.arrow_forward, color: Colors.green),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Log Out'),
                            content: Text('Apakah Anda yakin ingin keluar?'),
                            backgroundColor: Colors.lightGreen[
                                50], // Set background color to light green
                            actions: <Widget>[
                              TextButton(
                                child: Text('Tidak'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Ya'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AplikasiSewaAlat(),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
