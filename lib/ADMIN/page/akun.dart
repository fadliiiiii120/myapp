import 'package:flutter/material.dart';
import 'package:myapp/ADMIN/page/AkunDetail.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({Key? key}) : super(key: key);

  @override
  _AkunPageState createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  final List<Map<String, dynamic>> akun = [
    {
      'nama': 'Bagio',
      'No Hp': '089111221221',
      'alamat': 'Tegalsari',
      'email': 'Bagio211@gmail.com',
    },
    {
      'nama': 'Ardi',
      'No Hp': '089333223223',
      'alamat': 'Tegalrejo',
      'email': 'Ardi233@gmail.com',
    },
    {
      'nama': 'Sapardi',
      'No Hp': '089444224224',
      'alamat': 'Magetan',
      'email': 'Sapardi244@gmail.com',
    },
    // Tambahkan akun lainnya di sini
  ];

  String searchQuery = '';
  List<Map<String, dynamic>> filteredAkun = [];

  @override
  void initState() {
    super.initState();
    filteredAkun = akun;
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredAkun = akun
          .where((akunItem) => akunItem['nama']
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  void cetakAkun() {
    for (var akunItem in filteredAkun) {
      print('Nama: ${akunItem['nama']}');
      print('No HP: ${akunItem['No Hp']}');
      print('Alamat: ${akunItem['alamat']}');
      print('Email: ${akunItem['email']}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Akun', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          iconSize: 24,
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xff19143b),
      body: Column(
        children: [
//pencarian
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: updateSearchQuery,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.white),
                hintText: 'cari akun pelanggan',
                hintStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: const Color.fromARGB(218, 251, 138, 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),

//tabel akun
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: filteredAkun.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> akunItem = filteredAkun[index];
                return Card(
                  color: Colors.grey[500], // Warna background card
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ExpansionTile(
                    backgroundColor:
                        Colors.white70, // Warna background tile yang diexpand
                    leading: const Icon(Icons.person,
                        color: Colors.deepOrangeAccent), // Warna icon
                    title: Text(akunItem['nama']),
                    children: <Widget>[
                      ListTile(
                        title: Text('No HP: ${akunItem['No Hp']}'),
                      ),
                      ListTile(
                        title: Text('Alamat: ${akunItem['alamat']}'),
                      ),
                      ListTile(
                        title: Text('Email: ${akunItem['email']}'),
                      ),
                      ListTile(
                        title: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AkunDetail(akun: akunItem),
                              ),
                            );
                          },
                          child: const Text(
                            'Selengkapnya',
                            style: TextStyle(color: Colors.deepOrangeAccent),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
