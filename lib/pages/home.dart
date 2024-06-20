import 'package:flutter/material.dart';
import 'package:climbkit/pages/riwayat.dart';
import 'package:climbkit/pages/sewa.dart';
import 'package:climbkit/pages/pengembalian.dart';
import 'package:climbkit/pages/info_gunung.dart';
import 'package:climbkit/pages/profil.dart'; // Import HalamanProfil

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClimbKit',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HalamanHome(nama: 'Nama Pengguna'), // Pass the user name
    );
  }
}

class HalamanHome extends StatefulWidget {
  final String nama;

  HalamanHome({required this.nama});

  @override
  _HalamanHomeState createState() => _HalamanHomeState();
}

class _HalamanHomeState extends State<HalamanHome> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions(String nama) {
    return [
      HalamanBeranda(nama: nama),
      HalamanRiwayat(),
      HalamanProfil(), // Replace HalamanAboutUs with HalamanProfil
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions(widget.nama)[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class HalamanBeranda extends StatelessWidget {
  final String nama;

  HalamanBeranda({required this.nama});

  final List<Map<String, dynamic>> produkTerlaris = [
    {
      "nama": "Sleep Bag",
      "harga": 7000,
      "rating": 4.8,
      "gambar": "https://iili.io/JL770wg.png"
    },
    {
      "nama": "Tenda",
      "harga": 20000,
      "rating": 4.9,
      "gambar": "https://iili.io/JL7wBSe.png"
    },
    {
      "nama": "Tas Carrier",
      "harga": 10000,
      "rating": 4.9,
      "gambar": "https://iili.io/JL76BUv.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Selamat datang, $nama!',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900])),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 65, 175, 71),
                      Color.fromARGB(255, 187, 220, 189)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Temukan kebutuhan pendakianmu disini',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 150,
                      height: 150,
                      child: Image.network(
                        'https://iili.io/JDIxZ4S.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      InkResponse(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HalamanSewa()),
                          );
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.green[100],
                          child: Icon(Icons.shopping_bag),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('Sewa'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      InkResponse(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HalamanPengembalian()),
                          );
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.green[100],
                          child: Icon(Icons.assignment_return),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('Pengembalian'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      InkResponse(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InfoGunungPage()),
                          );
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.green[100],
                          child: Icon(Icons.info),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('Info Gunung'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(' Sewa Terpopuler',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900])),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 11.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.9,
                ),
                itemCount: produkTerlaris.length,
                itemBuilder: (context, index) {
                  final produk = produkTerlaris[index];
                  return Stack(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.green[50],
                        elevation: 4,
                        shadowColor: Colors.black38,
                        child: InkResponse(
                          borderRadius: BorderRadius.circular(10.0),
                          onTap: () {
                            // Aksi saat card diklik
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    produk['gambar'],
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  produk['nama'],
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[800]),
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      'Rp ${produk['harga']}',
                                      style: TextStyle(
                                          color: Colors.green[800],
                                          fontSize: 14),
                                    ),
                                    Text(
                                      ' /hari',
                                      style: TextStyle(
                                          color: Colors.green[800],
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: List.generate(5, (starIndex) {
                                    return Icon(
                                      starIndex < produk['rating']
                                          ? Icons.star
                                          : Icons.star_border,
                                      size: 14,
                                      color: Colors.yellow[600],
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Populer',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
