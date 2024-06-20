import 'package:flutter/material.dart';
import 'detail_sewa.dart';

void main() {
  runApp(MaterialApp(
    home: HalamanSewa(),
  ));
}

class HalamanSewa extends StatefulWidget {
  @override
  _HalamanSewaState createState() => _HalamanSewaState();
}

class _HalamanSewaState extends State<HalamanSewa> {
  final List<Map<String, dynamic>> produk = [
    {
      "id": "1",
      "nama": "Sleep Bag",
      "harga": 50000,
      "gambar": "https://iili.io/JL770wg.png",
      "deskripsi": "Sleeping bag atau kantung tidur adalah alat yang digunakan sebagai alas tidur saat melakukan aktivitas outdoor. Sleeping bag yang berkualitas dapat menjaga suhu tubuh sehingga kamu bisa beristirahat dengan nyaman meski di alam terbuka.",
      "kategori": "Camping Gear",
      "kondisi": "Baru",
      "rating": 5,
      "views": 1000
    },
    {
      "id": "2",
      "nama": "Tenda",
      "harga": 200000,
      "gambar": "https://iili.io/JL7wBSe.png",
      "deskripsi": "Tenda merupakan peralatan yang penting untuk naik gunung. Mengingat cuaca di gunung berubah-ubah, bawalah tenda yang kukuh sehingga Anda tetap terlindungi dari hujan, angin, ataupun badai.",
      "kategori": "Camping Gear",
      "kondisi": "Bekas",
      "rating": 5,
      "views": 500
    },
    {
      "id": "3",
      "nama": "Tas Carrier",
      "harga": 150000,
      "gambar": "https://iili.io/JL76BUv.png",
      "deskripsi": "Tas Carrier 60L untuk mendaki gunung.",
      "kategori": "Camping Gear",
      "kondisi": "Baru",
      "rating": 5,
      "views": 800
    },
    {
      "id": "4",
      "nama": "Jas Hujan",
      "harga": 5000,
      "gambar": "https://iili.io/JZtfHSp.png",
      "deskripsi": "Mantel hujan ini dibuat dengan menggunakan bahan yang halus dan ringan, namun tetap kokoh. Jas ini terdiri dari dua lapisan, yakni bahan jaring di bagian dalam, serta luaran berbahan taslan waterproof danwindproof. ",
      "kategori": "Camping Gear",
      "kondisi": "Baru",
      "rating": 5,
      "views": 800
    },
    {
      "id": "5",
      "nama": "Hammock",
      "harga": 5000,
      "gambar": "https://iili.io/JZtxXzN.png",
      "deskripsi": "Tempat tidur gantung atau yang juga sering disebut dengan hammock adalah jenis tempat tidur berupa kain seperti ayunan yang digantung pada kedua ujungnya. Biasanya hammock digunakan sebagai peralatan pelengkap saat berkemah.",
      "kategori": "Camping Gear",
      "kondisi": "Baru",
      "rating": 5,
      "views": 800
    },
    {
      "id": "6",
      "nama": "Tracking Pole",
      "harga": 5000,
      "gambar": "https://iili.io/JZtamcN.png",
      "deskripsi": "Membantu mendapatkan ritme konsisten pendakian. \nMenjaga keseimbangan, sangat membantu saat kelelahan. \nMembantu mendorong tubuh bergerak ke depan. \nUjung tongkat dapat digunakan untuk memeriksa jalur trekking sebelum melangkah. \nMenjaga keseimbangan tubuh saat berjalan ditempat yang licin. \nMembantu mengurangi ketegangan tubuh. \nBahan kuat dan awet \nTersedia warna Hitam, Hijau, Biru, Merah \nPanjang minimum : 54 cm \nPanjang maksimal : 110 cm Ready Warna : silver, biru, merah",
      "kategori": "Camping Gear",
      "kondisi": "Baru",
      "rating": 5,
      "views": 800
    },
    {
      "id": "7",
      "nama": "Head Lamp",
      "harga": 5000,
      "gambar": "https://iili.io/JZtGdGa.png",
      "deskripsi": "Senter kepala / headlamp ini di lengkapi dengan model dimmer \nMenggunakan batrai Li-on isi ulang dengan kapasitas tinggi 2200mAh Menggunakan baterai yg awet, \nDapat dicas ulang lebih dari 500 kali. \nMenggunakan 10W Super LED yg sangat terang, hemat energi dan tahan lama. \nMode cahaya : model dimmer bisa ( terang dan di redup kan ) \nTersedia Lensa Untuk Merubah Cahaya ( menjadi kuning )",
      "kategori": "Camping Gear",
      "kondisi": "Baru",
      "rating": 5,
      "views": 800
    },
    {
      "id": "8",
      "nama": "Senter",
      "harga": 5000,
      "gambar": "https://iili.io/JZtWj94.png",
      "deskripsi": "Tenaga Baterai 3 x AAA TaffwareFlashlight ini ditenagai denganmenggunakan 3 buah baterai tipe AAA sebagai penggantinya.Baterai belum termasuk dalam kemasan produk. Bahan AluminiumAlloy Body dari senter LED ini terbuat darialuminum alloy, mencegah goresan yang mungkin terjadi pada badan senter. Membuat tampilan senter lebih keren dengan desain body anti slip yang membuat senter nyaman untuk di genggam. 3 Mode Switch untuk on/off terdapat dibagian belakang senter. Switch ini juga berfungsi untuk pengaturan mode pencahayaan. Terdapat 3 mode pencahayaan untuk senter ini, Mode pertama 100% pencahayaan, mode kedua 50% pencahayaan, dan mode ketiga SOS.",
      "kategori": "Camping Gear",
      "kondisi": "Baru",
      "rating": 5,
      "views": 800
    },
    {
      "id": "9",
      "nama": "Nesting",
      "harga": 6000,
      "gambar": "https://iili.io/JZthtaa.png",
      "deskripsi": "Ready alat masak camping cooking set + poci, ds 308 kelengkapan: \n1. Panci \n2.Teplon \n3. Mangkok \n4. Centong \n5. Spons \n6. Teko/poci",
      "kategori": "Camping Gear",
      "kondisi": "Baru",
      "rating": 5,
      "views": 800
    },
    {
      "id": "10",
      "nama": "Sarung Tangan",
      "harga": 2000,
      "gambar": "https://iili.io/JZtkx4I.png",
      "deskripsi": "Sarung tangan polar hangat digunakan disaat anda beraktifitas digunung, terdapat lubang dijari telunjuk dan ibu jari agar tetap bisa menggunakan ponsel anda meskipun sedang digunakan.",
      "kategori": "Camping Gear",
      "kondisi": "Baru",
      "rating": 5,
      "views": 800
    },
    {
      "id": "11",
      "nama": "Topi",
      "harga": 2000,
      "gambar": "https://iili.io/JZtggLb.png",
      "deskripsi": "Topi Rimba Gunung Hiking Outdoor Bucket Hat Tali Pria Wanita Dewasa digunakan untuk aktivitas lapangan seperti naik gunung, camping, berkebun, maupun ke pantai. \nInfo Spesifikasi Produk Topi Rimba Gunung Outdoor : \n- Ukuran Dewasa Pria dan Wanita 60cm \n- Dilengkapi Tali \n- Dilengkapi Cardlock / Stopper untuk mengukur panjang/pendek tali \n- Kain Ribstok 2 lapis luar dan dalam",
      "kategori": "Camping Gear",
      "kondisi": "Baru",
      "rating": 5,
      "views": 800
    },
    {
      "id": "12",
      "nama": "Jaket",
      "harga": 10000,
      "gambar": "https://iili.io/JZtZB1e.png",
      "deskripsi": "Sangat hangat, sehangat pelukan ibu. Berpetualang di alam bebas sangat menyenangkan. Kita dapat berinteraksi dengan alam, menikmati suasana yang jauh dari hiruk-pikuk perkotaan, dan bersentuhan dengan udara sejuk… setidaknya sebelum angin kencang dan dingin menerpa. Untuk menangkal angin kencang dan dingin itu, tentu kita perlu melapisi diri dengan satu jenis pakaian yang windproof dan juga dapat menjaga suhu tubuh kita agar tetap stabil dan tidak terkena gejala hipotermia.",
      "kategori": "Camping Gear",
      "kondisi": "Baru",
      "rating": 5,
      "views": 800
    },
    {
      "id": "13",
      "nama": "Matras",
      "harga": 5000,
      "gambar": "https://iili.io/JZtmgHu.png",
      "deskripsi": "Dilengkapi dengan tali pengikat yang elegan dengan klip pengunci praktis pada saat selesai digunakan / digulung Nyaman digunakan dan tidak mudah sobek. \nUkuran : \nPanjang 200cm \nLebar 60 cm \nTebal 3mm",
      "kategori": "Camping Gear",
      "kondisi": "Baru",
      "rating": 5,
      "views": 800
    },
    {
      "id": "14",
      "nama": "Sepatu",
      "harga": 15000,
      "gambar": "https://iili.io/JZDHXgS.png",
      "deskripsi": "Kualitas International Model dan design Elegan dan Kekinian. Bahan Pilihan, Kualitas terjaga . \nSpesifikasi Produk : \n- Sepatu Hipzo M 032 \n- Ready Size 39.40.41.42.43 \n- Upper Webbing Tebal dan Kuat \n- Insole Karet Sponge Lentur & Nyaman",
      "kategori": "Camping Gear",
      "kondisi": "Baru",
      "rating": 5,
      "views": 800
    },
    {
      "id": "15",
      "nama": "Kompor Portable",
      "harga": 10000,
      "gambar": "https://iili.io/JZDFnou.png",
      "deskripsi": "Spesifikasi: \n- Bodi Berbahan : Iron with Powder Coating \n- Jenis Kaleng Gas : Butane \n- Konsumsi Gas : 150g /jam \n- Tingkat Panas : 2.2 kW \n- Katup Pengaman Ganda \n- DILENGKAPI WINDSHIELD",
      "kategori": "Camping Gear",
      "kondisi": "Baru",
      "rating": 5,
      "views": 800
    },
  ];

  String query = '';

  @override
  Widget build(BuildContext context) {
    final filteredProduk = produk
        .where(
            (item) => item['nama'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Sewa'), // Judul "Sewa"
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Cari barang...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: filteredProduk.length,
                itemBuilder: (context, index) {
                  final item = filteredProduk[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HalamanDetailSewa(item: item),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.all(4.0),
                      color: Colors.lightGreen[100], // Mengubah warna latar belakang menjadi hijau muda
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.network(
                            item['gambar'],
                            height: 80,
                            width: 80,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                          SizedBox(height: 5),
                          Text(
                            item['nama'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Rp ${item['harga']}',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
