import 'package:flutter/material.dart';
import 'order.dart'; // Import file order.dart di sini

class HalamanDetailSewa extends StatelessWidget {
  final Map<String, dynamic> item;

  HalamanDetailSewa({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('${item['nama']}'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.green, // Mengatur warna header menjadi hijau
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 200,
                width: double.infinity,
                child: Image.network(
                  item['gambar'],
                  fit: BoxFit
                      .contain, // Memastikan gambar menyesuaikan kontainer dan berada di tengah
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                item['nama'],
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Text(
                    "Rp ${item['harga']}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  const Text(
                    "/hari",
                    style: TextStyle(
                      color: Color.fromARGB(255, 56, 153, 4),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            DescriptionProduct(
              nameDescription: "Category",
              description: item['kategori'],
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 20),
            const PinTitleWidget(nameDescription: "📍 Deskripsi"),
            const SizedBox(height: 10),
            PinContentWidget(
              description: item['deskripsi'],
            ),
            const SizedBox(height: 20),
            const PinTitleWidget(nameDescription: "📍 Syarat Sewa"),
            const SizedBox(height: 10),
            PinContentWidget(
              description:
                  "Harus menyertakan KTP / SIM yang masih berlaku (dibawa saat pengambilan barang)",
            ),
            const SizedBox(height: 20),
            const PinTitleWidget(nameDescription: "📍 Kondisi Produk"),
            const SizedBox(height: 10),
            PinContentWidget(description: item['kondisi']),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HalamanOrder(item: item),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      shadowColor: Colors.grey,
                      elevation: 5,
                    ),
                    child: Text(
                      'Sewa Sekarang',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}

class DescriptionProduct extends StatelessWidget {
  final String nameDescription;
  final String description;

  const DescriptionProduct({
    Key? key,
    required this.nameDescription,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Text(
            "$nameDescription: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(description),
        ],
      ),
    );
  }
}

class PinTitleWidget extends StatelessWidget {
  final String nameDescription;

  const PinTitleWidget({
    Key? key,
    required this.nameDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        nameDescription,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}

class PinContentWidget extends StatelessWidget {
  final String description;

  const PinContentWidget({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(description),
    );
  }
}
