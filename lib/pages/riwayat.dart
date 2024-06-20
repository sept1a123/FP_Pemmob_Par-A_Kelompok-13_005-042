import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class RiwayatPenyewaan {
  final String namaAlat;
  final String tanggalSewa;
  final String tanggalKembali;
  final double biaya;
  final String namaPenyewa;
  final String gambarAlat;

  RiwayatPenyewaan({
    required this.namaAlat,
    required this.tanggalSewa,
    required this.tanggalKembali,
    required this.biaya,
    required this.namaPenyewa,
    required this.gambarAlat,
  });

  factory RiwayatPenyewaan.fromJson(Map<String, dynamic> json) {
    String formatDate(String isoDateString) {
      DateTime dateTime = DateTime.parse(isoDateString);
      return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
    }

    return RiwayatPenyewaan(
      namaAlat: json['nama'],
      tanggalSewa: formatDate(json['tanggal_sewa']),
      tanggalKembali: formatDate(json['tanggal_kembali']),
      biaya: json['total_harga'].toDouble(),
      namaPenyewa: json['nama_lengkap'],
      gambarAlat: json['gambar'],
    );
  }
}

class HalamanRiwayat extends StatefulWidget {
  @override
  _HalamanRiwayatState createState() => _HalamanRiwayatState();
}

class _HalamanRiwayatState extends State<HalamanRiwayat> {
  late Future<List<RiwayatPenyewaan>> futureRiwayatPenyewaan;

  @override
  void initState() {
    super.initState();
    futureRiwayatPenyewaan = fetchRiwayatPenyewaan();
  }

  Future<List<RiwayatPenyewaan>> fetchRiwayatPenyewaan() async {
    final response = await http.get(Uri.parse(
        'https://climbkit-f6608-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json'));
    final box = GetStorage();

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<RiwayatPenyewaan> riwayatList = [];

      data.forEach((key, value) {
        if (value['login'] == box.read('email')) {
          riwayatList.add(RiwayatPenyewaan.fromJson(value));
        }
      });

      return riwayatList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Penyewaan'),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<List<RiwayatPenyewaan>>(
        future: futureRiwayatPenyewaan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No rental history found.'));
          } else {
            final riwayatPenyewaan = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: riwayatPenyewaan.length,
                itemBuilder: (context, index) {
                  final riwayat = riwayatPenyewaan[index];
                  return Card(
                    color: Colors.lightGreen[100], // Change the color here
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  riwayat.gambarAlat,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      riwayat.namaAlat,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[800],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Penyewa: ${riwayat.namaPenyewa}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(color: Colors.grey[300], height: 32),
                          Text(
                            'Tanggal Sewa: ${riwayat.tanggalSewa}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            'Tanggal Kembali: ${riwayat.tanggalKembali}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Harga',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[800],
                                ),
                              ),
                              Text(
                                'Rp ${riwayat.biaya.toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[800],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
