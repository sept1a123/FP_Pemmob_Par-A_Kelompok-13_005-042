import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:climbkit/pages/detail_pengembalian.dart';
import 'package:get_storage/get_storage.dart';

class HalamanPengembalian extends StatefulWidget {
  @override
  _HalamanPengembalianState createState() => _HalamanPengembalianState();
}

class _HalamanPengembalianState extends State<HalamanPengembalian> {
  List<Map<String, dynamic>> barangDisewa = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBarangDisewa();
  }

  Future<void> fetchBarangDisewa() async {
    final url1 =
        'https://climbkit-f6608-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json';
    final url2 =
        'https://climbkit-f6608-default-rtdb.asia-southeast1.firebasedatabase.app/pengembalian.json';

    final response1 = await http.get(Uri.parse(url1));
    final response2 = await http.get(Uri.parse(url2));
    final box = GetStorage();

    if (response1.statusCode == 200 && response2.statusCode == 200) {
      final Map<String, dynamic> data1 = json.decode(response1.body);
      final Map<String, dynamic> data2 = json.decode(response2.body);
      final List<Map<String, dynamic>> filteredData = [];

      DateTime now = DateTime.now();
      String formatDate(String isoDateString) {
        DateTime dateTime = DateTime.parse(isoDateString);
        return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
      }

      data1.forEach((key1, value1) {
        if (value1['login'] == box.read('email')) {
          value1['tanggal_sewa'] = formatDate(value1['tanggal_sewa']);
          value1['tanggal_kembali'] = formatDate(value1['tanggal_kembali']);

          // Merge status from the second API based on the uniqid
          String uniqid = value1['uniqid'];
          value1['status'] = 'Status tidak tersedia'; // default value

          data2.forEach((key2, value2) {
            if (value2['uniqid'] == uniqid) {
              value1['status'] = value2['status'];
            }
          });

          filteredData.add(value1);
        }
      });

      setState(() {
        barangDisewa = filteredData;
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengembalian Barang'),
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: barangDisewa.length,
              itemBuilder: (context, index) {
                final barang = barangDisewa[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.green[50],
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          barang['gambar'],
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        barang['nama'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.green[800],
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text(
                            'Tanggal Sewa: ${barang['tanggal_sewa']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            'Tanggal Kembali: ${barang['tanggal_kembali']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            barang['status'] == 'Status tidak tersedia' ? _checkReturnDate(barang['tanggal_kembali']) : barang['status'],
                            style: TextStyle(
                              color: barang['status'] == 'Status tidak tersedia' ? (_checkReturnDate(barang['tanggal_kembali']) == "Belum Waktunya Mengembalikan" ? Colors.green : Colors.red) : Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        barang['status'] == 'Status tidak tersedia' ? (_checkReturnDate(barang['tanggal_kembali']) == "Waktunya Mengembalikan Barang!" ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPengembalianPage(
                              barang: barang,
                            ),
                          ),
                        ) : "") : "";
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }

  String _checkReturnDate(String tanggalKembali) {
    DateTime returnDate = DateTime.parse(tanggalKembali);
    DateTime now = DateTime.now();
    if (now.isAfter(returnDate)) {
      return "Waktunya Mengembalikan Barang!";
    } else {
      return "Belum Waktunya Mengembalikan";
    }
  }
}
