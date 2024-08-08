import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:myapp/USER/all%20page/searchPage.dart';
import 'package:myapp/USER/primary/barang.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List? kategori_list;
  List<Map<String, String>> Kategori = [
    {
      "id": "1",
      "name": "Beras",
      "description": "Bahan pokok utama yang dikonsumsi masyarakat Indonesia",
      "imageassets": "assets/beras.png"
    },
    {
      "id": "2",
      "name": "Gula",
      "description":
          "Bahan pokok yang digunakan sebagai pemanis makanan dan minuman",
      "imageassets": "assets/gula.png"
    },
    {
      "id": "3",
      "name": "Kopi",
      "description":
          "Minuman hasil seduhan biji kopi yang telah disangrai dan dihaluskan menjadi bubuk.",
      "imageassets": "assets/kopi.png"
    },
    {
      "id": "4",
      "name": "Mie",
      "description":
          "Mie yang sudah dikeringkan dulu, agar dapat disajikan secara instant",
      "imageassets": "assets/mie.png"
    },
    {
      "id": "5",
      "name": "Minyak",
      "description": "Minyak yang digunakan untuk menggoreng makanan",
      "imageassets": "assets/minyak.png"
    },
    {
      "id": "6",
      "name": "Susu",
      "description":
          "Minuman kaya nutrisi yang memberikan banyak manfaat bagi kesehatan tubuh",
      "imageassets": "assets/susu.png"
    },
    {
      "id": "7",
      "name": "Telur",
      "description":
          "Sumber protein hewani yang memiliki rasa yang lezat, mudah dicerna, dan bergizi tinggi",
      "imageassets": "assets/telur.png"
    },
    {
      "id": "8",
      "name": "Tepung",
      "description":
          "Bubuk halus yang berasal dari bulir gandum yang di haluskan, biasanya digunakan untuk mie, kue dan roti",
      "imageassets": "assets/tepung.png"
    },
  ];

  Future _kategori() async {
    final Response = await http.post(
        Uri.parse("https://mobileapp.my.id/API/index.php"),
        body: {"action": "kategori"});

    var data = jsonDecode(Response.body);

    if (data == '1') {
      kategori_list = null;
      print(data);
    } else {
      kategori_list = data;
    }
  }

  List<Map<String, String>> diskonImages = [
    {"image": "assets/DiskonKopi.png"},
    {"image": "assets/DiskonTepung.png"},
    {"image": "assets/DiskonSusu.png"},
  ];

  @override
  void initState() {
    _kategori();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Sembako",
      home: Scaffold(
        backgroundColor: Color.fromARGB(206, 197, 197, 197),
        appBar: AppBar(
          title: Text(
            "Dashboard",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
//Search
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                  right:
                      16.0), // Geser sedikit ke kiri dengan margin di sebelah kanan
              child: Container(
                width: 40, // Lebar lingkaran
                height: 40, // Tinggi lingkaran
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(243, 162, 11, 1), // Warna lingkaran
                ),
                child: IconButton(
                  icon: Icon(Icons.search,
                      color: Colors.black, size: 20), // Warna dan ukuran ikon
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(kategori: Kategori),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
//Diskon
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < diskonImages.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset(
                        diskonImages[i]['image']!,
                        width: 300,
                        height: 120,
                      ),
                    ),
                ],
              ),
            ),
            if (kategori_list == null) Container(),

//Kategori & Barang
            if (kategori_list != null)
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: (120 / 160),
                  children: [
                    for (int i = 0; i < kategori_list!.length; i++)
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BarangList(
                                id_kategori: kategori_list![i]['kategori_id']!,
                                kategori: kategori_list![i]['nama_kategori']!,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(125, 155, 153, 153),
                          ),
                          child: Column(
                            children: [
                              if (kategori_list![i]['image'] != null)
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Image.network(
                                    kategori_list![i]['image']!,
                                    width: 120,
                                    height: 120,
                                  ),
                                ),
                              Text(
                                kategori_list![i]['nama_kategori'] ?? "-",
                                style: TextStyle(
                                  color: Color.fromRGBO(138, 96, 6, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                kategori_list![i]['deskripsi'] ?? "-",
                                style: TextStyle(fontSize: 10),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
