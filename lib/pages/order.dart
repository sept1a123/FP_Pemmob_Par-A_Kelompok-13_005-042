import 'package:flutter/material.dart';
import 'package:climbkit/pages/home.dart'; // Assuming HalamanHome is imported from home.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:get_storage/get_storage.dart';

String generateUniqueId() {
  final DateTime now = DateTime.now();
  final int millisecondsSinceEpoch = now.millisecondsSinceEpoch;
  final int randomValue = Random().nextInt(100000);

  return '$millisecondsSinceEpoch$randomValue';
}

class HalamanOrder extends StatefulWidget {
  final Map<String, dynamic> item;

  HalamanOrder({required this.item});

  @override
  _HalamanOrderState createState() => _HalamanOrderState();
}

class _HalamanOrderState extends State<HalamanOrder> {
  DateTime? tanggalSewa;
  DateTime? tanggalKembali;
  int totalHarga = 0;
  int jumlahBarang = 1; // Menyimpan jumlah barang yang dipilih
  int? _selectedPaymentMethod;

  Future<void> _selectDate(BuildContext context, bool isTanggalSewa) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isTanggalSewa) {
          tanggalSewa = picked;
        } else {
          tanggalKembali = picked;
        }
        _calculateTotalHarga();
      });
    }
  }

  void _calculateTotalHarga() {
    if (tanggalSewa != null && tanggalKembali != null) {
      final durasi = tanggalKembali!.difference(tanggalSewa!).inDays +
          1; // Including the end date
      setState(() {
        totalHarga = widget.item['harga'] *
            durasi *
            jumlahBarang; // Total harga = harga barang * durasi * jumlah barang
      });
    }
  }

  // Method untuk menambah jumlah barang
  void _tambahJumlahBarang() {
    setState(() {
      jumlahBarang++;
      _calculateTotalHarga(); // Panggil method perhitungan total harga setelah jumlah barang diubah
    });
  }

  // Method untuk mengurangi jumlah barang
  void _kurangiJumlahBarang() {
    setState(() {
      if (jumlahBarang > 1) {
        jumlahBarang--;
        _calculateTotalHarga(); // Panggil method perhitungan total harga setelah jumlah barang diubah
      }
    });
  }

  Widget buildJumlahBarang() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jumlah :',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _kurangiJumlahBarang,
              icon: Icon(Icons.remove),
            ),
            Text(
              '$jumlahBarang', // Tampilkan jumlah barang yang dipilih
              style: TextStyle(fontSize: 18),
            ),
            IconButton(
              onPressed: _tambahJumlahBarang,
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildRadioButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Metode Pembayaran:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Column(
          children: [
            Row(
              children: [
                Radio(
                  value: 0,
                  groupValue: _selectedPaymentMethod,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                  },
                ),
                Text('Bayar di Tempat'),
              ],
            ),
            // Row(
            //   children: [
            //     Radio(
            //       value: 1,
            //       groupValue: _selectedPaymentMethod,
            //       onChanged: (int? value) {
            //         setState(() {
            //           _selectedPaymentMethod = value;
            //         });
            //       },
            //     ),
            //     Text('QRIS'),
            //   ],
            // ),
          ],
        ),
        if (_selectedPaymentMethod == 1)
          Center(
            child: Image.network(
              'https://iili.io/JppmebS.png',
              height: 200,
              width: 200,
            ),
          ),
      ],
    );
  }

  String getPaymentMethodText() {
    switch (_selectedPaymentMethod) {
      case 0:
        return 'Bayar di Tempat';
      case 1:
        return 'QRIS';
      default:
        return 'Tidak dipilih';
    }
  }

  final TextEditingController namaLengkapController = TextEditingController();
  final TextEditingController nikController = TextEditingController();
  final TextEditingController nomorTelponController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> saveOrderData({
    required String id,
    required String nama,
    required int harga,
    required String gambar,
    required String deskripsi,
    required String kategori,
    required String kondisi,
    required String email,
    required int rating,
    required int views,
    required DateTime tanggalSewa,
    required DateTime tanggalKembali,
    required int jumlah,
    required int totalHarga,
    required String metodePembayaran,
    required String namaLengkap,
    required String nik,
    required String nomorTelpon,
    required String login,
  }) async {
    final url = Uri.parse(
        'https://climbkit-f6608-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json');

    final response = await http.post(
      url,
      body: json.encode({
        'id': id,
        'nama': nama,
        'harga': harga,
        'gambar': gambar,
        'kategori': kategori,
        'kondisi': kondisi,
        'rating': rating,
        'views': views,
        'nama_lengkap': namaLengkap,
        'nik': nik,
        'nomor_telpon': nomorTelpon,
        'email': email,
        'login': login,
        'tanggal_sewa': tanggalSewa.toIso8601String(),
        'tanggal_kembali': tanggalKembali.toIso8601String(),
        'jumlah': jumlah,
        'total_harga': totalHarga,
        'metode_pembayaran': metodePembayaran,
        'uniqid': generateUniqueId(),
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to save order data');
    }
  }

  void _showSecondDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sewa Sukses'),
        content: Text(
            'Silahkan datang ke toko untuk mengambil barang anda, Jangan lupa membawa KTP atau SIM sebagai jaminan penyewaan!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => HalamanHome(
                          nama: '',
                        )), // Navigating to HalamanHome and removing all previous routes
                (Route<dynamic> route) => false,
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.green,
              ),
            ),
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
        backgroundColor: Color(0xFFE3E1C8),
        contentPadding: const EdgeInsets.all(20.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 252, 251),
      appBar: AppBar(
        title: Text(
          "Silahkan Isi Form Sewa",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 50),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              buildTextField("Nama Lengkap", "Masukkan Nama Lengkap", false,
                  namaLengkapController),
              buildTextField("NIK", "Masukkan NIK", false,
                  nikController), // Textbox for NIK
              buildTextField("Nomor Telepon", "Masukan Nomor Telepon", false,
                  nomorTelponController),
              buildTextField("E-mail", "Masukan Email", false, emailController),
              SizedBox(height: 20),
              buildDateField(
                context,
                "Tanggal Sewa",
                tanggalSewa != null
                    ? tanggalSewa!.toLocal().toString().split(' ')[0]
                    : '',
                () => _selectDate(context, true),
              ),
              SizedBox(height: 20),
              buildDateField(
                context,
                "Tanggal Kembali",
                tanggalKembali != null
                    ? tanggalKembali!.toLocal().toString().split(' ')[0]
                    : '',
                () => _selectDate(context, false),
              ),
              SizedBox(height: 20),
              buildJumlahBarang(), // Pindahkan widget untuk memilih jumlah barang ke atas metode pembayaran
              SizedBox(height: 20),
              buildRadioButton(),
              SizedBox(height: 20),
              Text(
                'Harga per hari: Rp ${widget.item['harga']}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Total harga: Rp $totalHarga',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final box = GetStorage();
                    await saveOrderData(
                      id: widget.item['id'],
                      nama: widget.item['nama'],
                      harga: widget.item['harga'],
                      gambar: widget.item['gambar'],
                      deskripsi: widget.item['deskripsi'],
                      kategori: widget.item['kategori'],
                      kondisi: widget.item['kondisi'],
                      rating: widget.item['rating'],
                      views: widget.item['views'],
                      login: box.read('email'),
                      namaLengkap: namaLengkapController.text,
                      nik: nikController.text,
                      nomorTelpon: nomorTelponController.text,
                      email: emailController.text,
                      tanggalSewa: tanggalSewa!,
                      tanggalKembali: tanggalKembali!,
                      jumlah: jumlahBarang,
                      totalHarga: totalHarga,
                      metodePembayaran: getPaymentMethodText(),
                    );

                    _showSecondDialog(context);
                  } catch (e) {
                    print('Error saving data: $e');
                  }
                },
                child: Text(
                  "Sewa",
                  style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 2,
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labeltext, String placeholder,
      bool isPasswordTextField, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        obscureText: isPasswordTextField,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  icon: Icon(Icons.remove_red_eye, color: Colors.grey),
                  onPressed: () {},
                )
              : null,
          contentPadding: EdgeInsets.symmetric(
              vertical: 15.0, horizontal: 10.0), // Add padding
          labelText: labeltext,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 15.0,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.green),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.green),
          ),
        ),
      ),
    );
  }

  Widget buildDateField(
      BuildContext context, String labeltext, String date, VoidCallback onTap) {
    return TextField(
      controller: TextEditingController(text: date),
      decoration: InputDecoration(
        labelText: labeltext,
        hintText: 'yyyy-mm-dd',
        contentPadding: EdgeInsets.symmetric(
            vertical: 15.0, horizontal: 10.0), // Add padding
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.green),
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: onTap,
          color: Colors.green,
        ),
      ),
      readOnly: true,
      onTap: onTap,
    );
  }
}
