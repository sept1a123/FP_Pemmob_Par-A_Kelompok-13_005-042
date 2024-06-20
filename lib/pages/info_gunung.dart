import 'dart:convert';
import 'dart:io';

import 'package:climbkit/models/mountain_response_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';

class InfoGunungPage extends StatefulWidget {
  @override
  _InfoGunungPageState createState() => _InfoGunungPageState();
}

class _InfoGunungPageState extends State<InfoGunungPage> {
  List<Data>? list = [];
  List<String> topImageUrls = [
    'https://iili.io/dHxWBZN.jpg',
    'https://iili.io/dHxhWQV.jpg',
    'https://iili.io/dHxjBZQ.jpg',
  ];

  List<String> topImageNames = [
    'Gunung Penanggungan',
    'Gunung Andong',
    'Gunung Bromo',
  ];

  List<File?> selectedTopImages = [null, null, null];

  List<String> defaultImageUrls = [
    'https://iili.io/dHxNVjf.jpg',
    'https://iili.io/dHxOnn4.jpg',
    'https://iili.io/dHxOXAg.jpg',
    'https://iili.io/dHxOgHX.jpg',
    'https://iili.io/dHxezzJ.jpg',
    'https://iili.io/dHxeNee.jpg',
    'https://iili.io/dHxk3Is.jpg',
    'https://iili.io/dHxkWZJ.jpg',
    'https://iili.io/dHxvqwg.jpg',
    'https://iili.io/dHxvXR9.jpg',
    'https://iili.io/dHxvDUN.jpg',
    'https://iili.io/dHx8GLJ.jpg',
    'https://iili.io/dHx8UBf.jpg',
    'https://iili.io/dHxgOmP.jpg',
    'https://iili.io/dHxgZhX.jpg',
    'https://iili.io/dHxrEyN.jpg',
    'https://iili.io/dHx4HPa.jpg',
    'https://iili.io/dHx4Tlf.jpg',
    'https://iili.io/dHx6Aqg.jpg',
    'https://iili.io/dHx6UBe.jpg',
    'https://iili.io/dHxQjbR.jpg',
    'https://iili.io/dHxQp5b.jpg',
    'https://iili.io/dHxtG9a.jpg',
    'https://iili.io/dHxtUNf.jpg',
    'https://iili.io/dHxDcx4.jpg',
    'https://iili.io/dHxbkTG.jpg',
    'https://iili.io/dHxbbCQ.jpg',
    'https://iili.io/dHxmbNs.jpg',
    'https://iili.io/dHxpT0B.jpg',
    'https://iili.io/dHxy1Tu.jpg',
    'https://iili.io/dHz9SR9.jpg',
    'https://iili.io/dHzHYbe.png',
    'https://iili.io/dHzH6mX.jpg',
    'https://iili.io/dHzH6mX.jpg',
    'https://iili.io/dHzJUCb.jpg',
    'https://iili.io/dHzdqns.jpg',
    'https://iili.io/dHzdjVa.jpg',
    'https://iili.io/dHz2ugR.jpg',
    'https://iili.io/dHxjBZQ.jpg',
    'https://iili.io/dHz24kB.jpg',
    'https://iili.io/dHz3ACu.jpg',
    'https://iili.io/dHz3waR.jpg',
    'https://iili.io/dHzFqoF.jpg',
    'https://iili.io/dHzFT9p.jpg',
    'https://iili.io/dHxhWQV.jpg',
    'https://iili.io/dHzFUOB.jpg',
    'https://iili.io/dHzFmbI.jpg',
    'https://iili.io/dHzKT0b.jpg',
    'https://iili.io/dHxWBZN.jpg',
    'https://iili.io/dHzKZBe.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _getDataMountains();
  }

  _getDataMountains() async {
    try {
      var response = await http.get(
        Uri.parse("https://mountain.santanadev.my.id/"),
        headers: {
          "Content-Type": "application/json",
        },
      );
      print("success");
      var convertData = jsonDecode(response.body);
      MountainResponseModel data = MountainResponseModel.fromJson(convertData);
      setState(() {
        list = data.data;
      });
    } on HttpException {
      print("Error found on server");
    }
  }

  Future<void> _pickImage(int index) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          selectedTopImages[index] = File(pickedFile.path);
        });
      } else {
        // Pengguna tidak memilih gambar
        print('No image selected.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No image selected.'),
          ),
        );
      }
    } catch (e) {
      // Tampilkan pesan kesalahan
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info Gunung'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Top 3 Gunung untuk Pemula',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            CarouselSlider(
              options: CarouselOptions(
                height: 180.0,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: List.generate(3, (index) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () => _pickImage(index),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: selectedTopImages[index] != null
                                  ? Image.file(
                                      selectedTopImages[index]!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    )
                                  : Image.network(
                                      topImageUrls[index],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              right: 10,
                              child: Text(
                                topImageNames[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 32.0), // Adjusted spacing here
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Daftar Gunung di Indonesia',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            list!.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12.0,
                      crossAxisSpacing: 12.0,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: list!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.lightGreen[
                            100], // Set the background color of the card to light green
                        margin: EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15.0),
                                ),
                                child: Image.network(
                                  defaultImageUrls[
                                      index % defaultImageUrls.length],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    list![index].nama.toString(),
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    "Ketinggian: ${list![index].ketinggianMeter.toString()} meter",
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.black54),
                                  ),
                                  Text(
                                    "Jenis: ${list![index].jenis.toString()}",
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.black54),
                                  ),
                                  Text(
                                    "Lokasi: ${list![index].lokasi.toString()}",
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
