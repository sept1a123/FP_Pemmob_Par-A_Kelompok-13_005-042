import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:climbkit/pages/home.dart'; // Import HalamanHome if not already imported

class DetailPengembalianPage extends StatefulWidget {
  final Map<String, dynamic> barang;

  DetailPengembalianPage({required this.barang});

  @override
  _DetailPengembalianPageState createState() => _DetailPengembalianPageState();
}

class _DetailPengembalianPageState extends State<DetailPengembalianPage> {
  String _selectedMetodePengembalian = '';
  TextEditingController _alamatController = TextEditingController();
  bool _addressError = false;

  Future<void> _saveData() async {
    final url = 'https://climbkit-f6608-default-rtdb.asia-southeast1.firebasedatabase.app/pengembalian.json';
    
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': widget.barang['email'],
          'gambar': widget.barang['gambar'],
          'harga': widget.barang['harga'],
          'id': widget.barang['id'],
          'jumlah': widget.barang['jumlah'],
          'kategori': widget.barang['kategori'],
          'kondisi': widget.barang['kondisi'],
          'login': widget.barang['login'],
          'metode_pembayaran': widget.barang['metode_pembayaran'],
          'nama': widget.barang['nama'],
          'nama_lengkap': widget.barang['nama_lengkap'],
          'nik': widget.barang['nik'],
          'nomor_telpon': widget.barang['nomor_telpon'],
          'rating': widget.barang['rating'],
          'tanggal_kembali': widget.barang['tanggal_kembali'],
          'tanggal_sewa': widget.barang['tanggal_sewa'],
          'total_harga': widget.barang['total_harga'],
          'views': widget.barang['views'],
          'metode_pengembalian': _selectedMetodePengembalian,
          'alamat': _alamatController.text,
          'tanggal_input': DateTime.now().toIso8601String(),
          'uniqid': widget.barang['uniqid'],
          'status': _selectedMetodePengembalian == 'antar_ke_toko' ? 'Sudah dikembalikan' : 'Driver sudah menjemput barang sewa'
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('Data saved successfully');
      } else {
        print('Failed to save data');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pengembalian'),
        backgroundColor: Colors.green, // Set app bar color to green
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.barang['gambar'],
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                widget.barang['nama'],
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900]),
              ),
            ),
            SizedBox(height: 10),
            Divider(color: Colors.green, thickness: 1.5),
            SizedBox(height: 10),
            Text(
              'Tanggal Sewa: ${widget.barang['tanggal_sewa']}',
              style: TextStyle(fontSize: 16, color: Colors.green[800]),
            ),
            Text(
              'Tanggal Kembali: ${widget.barang['tanggal_kembali']}',
              style: TextStyle(fontSize: 16, color: Colors.green[800]),
            ),
            SizedBox(height: 20),
            Text(
              'Total Harga: Rp. ${widget.barang['total_harga']}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green[900]),
            ),
            SizedBox(height: 20),
            Text(
              'Metode Pengembalian:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green[900]),
            ),
            SizedBox(height: 10),
            RadioListTile(
              activeColor: Colors.green,
              title: Text('Antar ke Toko'),
              value: 'antar_ke_toko',
              groupValue: _selectedMetodePengembalian,
              onChanged: (value) {
                setState(() {
                  _selectedMetodePengembalian = value.toString();
                });
              },
            ),
            RadioListTile(
              activeColor: Colors.green,
              title: Text('Dijemput'),
              value: 'dijemput',
              groupValue: _selectedMetodePengembalian,
              onChanged: (value) {
                setState(() {
                  _selectedMetodePengembalian = value.toString();
                });
              },
            ),
            if (_selectedMetodePengembalian == 'dijemput') ...[
              SizedBox(height: 20),
              TextFormField(
                controller: _alamatController,
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(),
                  errorText: _addressError ? 'Alamat tidak boleh kosong' : null,
                ),
              ),
            ],
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Proses pengembalian
                  if (_selectedMetodePengembalian == 'antar_ke_toko') {
                    await _saveData();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Kami Tunggu,'),
                          content: Text('Silahkan Kembalikan Barang Ke Toko!'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HalamanHome(
                                            nama: '',
                                          )),
                                  (Route<dynamic> route) => false,
                                );
                              },
                              child: Text('OK'),
                            ),
                          ],
                          backgroundColor: Colors.lightGreen[
                              200], // Set background color to light green
                        );
                      },
                    );
                  } else if (_selectedMetodePengembalian == 'dijemput') {
                    setState(() {
                      if (_alamatController.text.isEmpty) {
                        _addressError = true;
                      } else {
                        _addressError = false;
                      }
                    });

                    if (!_addressError) {
                      await _saveData();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Tunggu Yaa'),
                            content: Text('Kami akan segera menuju tempatmu!'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HalamanHome(
                                              nama: '',
                                            )),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                child: Text('OK'),
                              ),
                            ],
                            backgroundColor: Colors.lightGreen[
                                200], // Set background color to light green
                          );
                        },
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  shadowColor: Colors.black38,
                ),
                child: Text(
                  'Kembalikan Barang',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
