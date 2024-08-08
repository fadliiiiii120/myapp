import 'package:flutter/material.dart';
import '../all page/detailPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BarangList extends StatefulWidget {
  final String id_kategori;
  final String kategori;

  static var length;

  BarangList({required this.id_kategori, required this.kategori});

  @override
  State<BarangList> createState() => _BarangListState();
}

class _BarangListState extends State<BarangList> {
  final List<Map<String, dynamic>> barangData = [
    {
      'title': 'Beras Bulog',
      'category': 'Beras',
      'subtitle': 'Rp.21.500',
      'price': 21500,
      'description':
          'Beras Bulog adalah beras yang disediakan oleh Perum Bulog untuk memenuhi kebutuhan pokok masyarakat dengan beras berkualitas dan harga yang terjangkau.',
      'image': 'assets/beras.png',
      'availability': 'tersedia',
    },
    {
      'title': 'Beras Rojo Lele',
      'category': 'Beras',
      'subtitle': 'Rp.28.000',
      'price': 28000,
      'description':
          'Beras Rojo Lele adalah beras yang dikenal dengan kualitasnya yang tinggi dan rasanya yang enak, cocok untuk segala jenis masakan.',
      'image': 'assets/beras.png',
      'availability': 'tersedia',
    },
    {
      'title': 'Beras Pandan Wangi',
      'category': 'Beras',
      'subtitle': 'Rp.20.000',
      'price': 20000,
      'description':
          'Beras Pandan Wangi memiliki aroma khas pandan yang wangi dan tekstur yang pulen, membuatnya sangat populer di kalangan masyarakat.',
      'image': 'assets/beras.png',
      'availability': 'tersedia',
    },
    {
      'title': 'Beras Setra Ramos',
      'category': 'Beras',
      'subtitle': 'Rp.18.500',
      'price': 18500,
      'description':
          'Beras Setra Ramos adalah beras dengan kualitas medium yang sering digunakan untuk kebutuhan sehari-hari dengan harga yang terjangkau.',
      'image': 'assets/beras.png',
      'availability': 'tersedia',
    },
    {
      'title': 'Gula Pasir',
      'category': 'Gula',
      'subtitle': 'Rp.18.000',
      'price': 18000,
      'description':
          'Gula pasir dapat digunakan sebagai penyedap makanan dan merupakan jenis gula yang paling banyak digunakan dalam rumah tangga.',
      'image': 'assets/gula.png',
      'availability': 'tersedia',
    },
    {
      'title': 'Gula Jawa',
      'category': 'Gula',
      'subtitle': 'Rp.14.000',
      'price': 14000,
      'description':
          'Gula Jawa adalah gula yang dibuat dari nira pohon kelapa atau aren, memberikan rasa manis yang khas dan aroma yang enak untuk masakan tradisional.',
      'image': 'assets/gula.png',
      'availability': 'tersedia',
    },
    {
      'title': 'Indomie',
      'category': 'Mie',
      'subtitle': 'Rp.2.500',
      'price': 2500,
      'description':
          'Indomie adalah mie instan yang populer di Indonesia dan di seluruh dunia, dengan berbagai rasa yang lezat dan mudah disiapkan.',
      'image': 'assets/mie.png',
      'availability': 'tersedia',
    },
    {
      'title': 'Mie Sedap',
      'category': 'Mie',
      'subtitle': 'Rp.2.000',
      'price': 2000,
      'description':
          'Mie Sedap adalah mie instan yang dikenal dengan teksturnya yang kenyal dan bumbu yang kuat, memberikan cita rasa yang nikmat.',
      'image': 'assets/mie.png',
      'availability': 'tersedia',
    },
    {
      'title': 'Kapal Api',
      'category': 'Kopi',
      'subtitle': 'Rp.10.000',
      'price': 10000,
      'description':
          'Kapal Api adalah kopi yang terkenal di Indonesia, dengan rasa dan aroma yang kuat, cocok untuk dinikmati kapan saja.',
      'image': 'assets/kopi.png',
      'availability': 'tersedia',
    },
    {
      'title': 'Coffee Mix',
      'category': 'Kopi',
      'subtitle': 'Rp.8.000',
      'price': 8000,
      'description':
          'Coffee Mix adalah kopi instan dengan campuran gula dan creamer, praktis dan nikmat untuk diminum setiap saat.',
      'image': 'assets/kopi.png',
      'availability': 'tersedia',
    },
    {
      'title': 'ABC Coffee',
      'category': 'Kopi',
      'subtitle': 'Rp.9.000',
      'price': 9000,
      'description':
          'ABC Coffee adalah kopi instan dengan rasa yang nikmat dan aroma yang harum, cocok untuk dinikmati di pagi hari atau saat santai.',
      'image': 'assets/kopi.png',
      'availability': 'tersedia',
    },
    {
      'title': 'Frisian Flag',
      'category': 'Susu',
      'subtitle': 'Rp.15.000',
      'price': 15000,
      'description':
          'Frisian Flag adalah susu kental manis yang dapat digunakan sebagai tambahan dalam minuman atau makanan penutup.',
      'image': 'assets/susu.png',
      'availability': 'tersedia',
    },
    {
      'title': 'Ultra Mik',
      'category': 'Susu',
      'subtitle': 'Rp.16.000',
      'price': 16000,
      'description':
          'Ultra Milk Full cream mengandung berbagai kebaikan protein, vitamin dan mineral.',
      'image': 'assets/susu.png',
      'availability': 'tersedia',
    },
    {
      'title': 'Bendera',
      'category': 'Susu',
      'subtitle': 'Rp.14.000',
      'price': 14000,
      'description':
          'Bendera adalah susu cair yang kaya akan nutrisi dan baik untuk kesehatan, bisa diminum langsung atau dicampur dengan sereal.',
      'image': 'assets/susu.png',
      'availability': 'tersedia',
    },
    {
      'title': 'Minyak Kita',
      'category': 'Minyak',
      'subtitle': 'Rp.12.000',
      'price': 12000,
      'description':
          'Minyak Kita adalah minyak goreng yang dibuat dari kelapa sawit, cocok untuk menggoreng dan menumis makanan sehari-hari.',
      'image': 'assets/minyak.png',
      'availability': 'tersedia',
    },
    {
      'title': 'Bimoli',
      'category': 'Minyak',
      'subtitle': 'Rp.13.000',
      'price': 13000,
      'description':
          'Bimoli adalah minyak goreng berkualitas tinggi yang dihasilkan dari kelapa sawit pilihan, memberikan hasil gorengan yang renyah dan lezat.',
      'image': 'assets/minyak.png',
      'availability': 'tersedia',
    },
    {
      'title': 'Sunco',
      'category': 'Minyak',
      'subtitle': 'Rp.14.000',
      'price': 14000,
      'description':
          'Sunco adalah minyak goreng dengan kualitas tinggi yang tidak mudah beku, sehingga sangat praktis untuk digunakan.',
      'image': 'assets/minyak.png',
      'availability': 'tersedia',
    },
    {
      'title': 'Telur Bebek',
      'category': 'Telur',
      'subtitle': 'Rp.3.000',
      'price': 3000,
      'description':
          'Telur bebek adalah telur dengan rasa yang lebih kuat dan tekstur yang lebih kenyal dibandingkan telur ayam, cocok untuk berbagai hidangan.',
      'image': 'assets/telur.png',
      'availability': 'tersedia',
    },
    {
      'title': 'Telur Ayam',
      'category': 'Telur',
      'subtitle': 'Rp.2.500',
      'price': 2500,
      'description':
          'Telur ayam adalah sumber protein hewani yang memiliki rasa yang lezat, mudah dicerna, dan bergizi tinggi.',
      'image': 'assets/telur.png',
      'availability': 'tersedia',
    },
    {
      'title': 'Tepung Cakra',
      'category': 'Tepung',
      'subtitle': 'Rp.10.000',
      'price': 10000,
      'description':
          'Tepung Cakra adalah tepung terigu berkualitas tinggi yang cocok untuk membuat roti dan kue dengan tekstur yang lembut.',
      'image': 'assets/tepung.png',
      'availability': 'tersedia',
    },
    {
      'title': 'Tepung Payung',
      'category': 'Tepung',
      'subtitle': 'Rp.9.000',
      'price': 9000,
      'description':
          'Tepung Payung adalah tepung serbaguna yang dapat digunakan untuk berbagai jenis masakan dan kue.',
      'image': 'assets/tepung.png',
      'availability': 'tersedia',
    },
    {
      'title': 'Tepung Segitiga Biru',
      'category': 'Tepung',
      'subtitle': 'Rp.8.000',
      'price': 8000,
      'description':
          'Tepung Segitiga Biru adalah tepung terigu serbaguna yang cocok untuk membuat aneka kue, roti, dan masakan lainnya.',
      'image': 'assets/tepung.png',
      'availability': 'tersedia',
    },
    {
      'title': 'Tepung Lencana',
      'category': 'Tepung',
      'subtitle': 'Rp.7.000',
      'price': 7000,
      'description':
          'Tepung Lencana adalah tepung terigu dengan kualitas baik yang bisa digunakan untuk berbagai keperluan memasak dan memanggang.',
      'image': 'assets/tepung.png',
      'availability': 'tersedia',
    },
  ];

  List? list_barang;
  Future _barangList() async {
    final Response = await http.post(
        Uri.parse("https://mobileapp.my.id/API/index.php"),
        body: {"action": "barang", "id_kategori": '${widget.id_kategori}'});

    var data = jsonDecode(Response.body);

    if (data == '1') {
      list_barang = null;
      print(data);
    } else {
      list_barang = data;
    }
  }

  @override
  void initState() {
    _barangList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(206, 197, 197, 197),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(243, 162, 11, 1),
          centerTitle: true,
          title: Text(
            widget.kategori,
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
            ),
          ),
          leadingWidth: 70,
        ),
        body: list_barang == null
            ? Container()
            : ListView(
                children: list_barang!.map((item) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            title: item['nama_barang'] ?? "",
                            price: item['harga_barang'] ?? "",
                            description:
                                item['create_barang'], //ganti dengan deskripsi
                            image: item['image'], //belum ada
                            category: '${widget.kategori}', //belum ada
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      contentPadding: EdgeInsets.all(7),
                      title: Text(item['nama_barang']),
                      subtitle: Text(item['harga_barang']),
                      // leading: Image.asset(
                      //   item['image'],
                      //   width: 50,
                      // ),
                      // trailing: Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: [
                      //     SizedBox(width: 50),
                      //     Text(item['availability']),
                      //   ],
                      // ),
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
