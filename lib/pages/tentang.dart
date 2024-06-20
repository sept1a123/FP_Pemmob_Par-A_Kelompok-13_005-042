import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TentangPage extends StatelessWidget {
  final List<Map<String, String>> profiles = [
    {
      'name': 'Dwi Septiajayanti',
      'ttl': 'Mojokerto, 06 September 2004',
      'alamat': 'Dsn.Sirno, Desa Purwojati, Kec.Ngoro, Kab.Mojokerto',
      'noHp': '081329129578',
      'email': 'dwiijayanti85@gmail.com',
      'urlGithub': 'https://github.com/sept1a123',
      'riwayatPendidikan':
          '\n1. SDN 2 Purwojati.\n2. SMP Islam Sedati.\n3. SMA Negeri 1 Ngoro',
      'imageUrl': 'https://iili.io/JLa4tls.jpg',
    },
    {
      'name': 'Yuana Istiqomah Dwi Koesmawati',
      'ttl': 'Jombang, 13 November 2003',
      'alamat': 'Dsn.Cukir, Desa Cukir, Kec.Diwek, Kab.Jombang',
      'noHp': '089665446991',
      'email': 'yuanaidk@gmail.com',
      'urlGithub': 'https://github.com/YuanaDwi',
      'riwayatPendidikan':
          '\n1. SDN Cukir 2\n2. SMPN 1 Diwek\n3. SMKN 1 Jombang',
      'imageUrl': 'https://iili.io/Jw7FnDl.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang Aplikasi'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Image.network(
                    'https://iili.io/JDorlm7.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'ClimbKit',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'ClimbKit adalah aplikasi mobile yang dirancang untuk memudahkan para pendaki dalam menyewa peralatan pendakian, mengembalikan peralatan, dan mendapatkan informasi lengkap tentang pegunungan di Indonesia. Pengguna dapat dengan mudah menyewa berbagai jenis peralatan pendakian, seperti tenda, sleeping bag, jaket, dan sepatu pendakian, dengan deskripsi, foto, dan harga sewa yang jelas. Proses pengembalian peralatan juga dilakukan dengan mudah melalui aplikasi, dengan opsi pengembalian melalui penjemputan atau pengantaran ke lokasi tertentu. ClimbKit menyediakan informasi terperinci tentang pegunungan di Indonesia yang selalu diperbarui melalui integrasi API.',
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  'Created by Kelompok 13',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: profiles
                      .map((profile) => ProfileCard(profile: profile))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final Map<String, String> profile;

  ProfileCard({required this.profile});

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green[50], // Light green background color
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.green[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(profile['imageUrl']!),
            ),
          ),
          SizedBox(height: 12),
          Text(
            profile['name']!,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green[900],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text('TTL: ${profile['ttl']}'),
          Text('Alamat: ${profile['alamat']}'),
          Text('No HP: ${profile['noHp']}'),
          Text('Email: ${profile['email']}'),
          GestureDetector(
            onTap: () => _launchURL(profile['urlGithub']!),
            child: Text(
              profile['urlGithub']!,
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          Text('Riwayat Pendidikan: ${profile['riwayatPendidikan']}'),
        ],
      ),
    );
  }
}
