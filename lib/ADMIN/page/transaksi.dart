// lib/daftartransaksi.dart
import 'package:flutter/material.dart';
import 'package:myapp/ADMIN/page/TransaksiDetail.dart';

class Transaksi extends StatefulWidget {
  @override
  _TransaksiState createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  final List<Map<String, dynamic>> _transaksiList = List.generate(20, (index) => {
    'id': index + 1,
    'tanggal': DateTime.now().subtract(Duration(days: index)),
    'jumlah': 'Rp.${index * 12000}', // Mengganti format dolar dengan rupiah
    'deskripsi': 'Deskripsi detail transaksi #$index',
    'akun': 'Akun ${index % 20 + 1}', // ID Akun, contoh Akun 1, Akun 2, Akun 3
  });

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredTransaksiList = _transaksiList
        .where((transaksi) => transaksi['id'].toString().contains(_searchQuery))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Transaksi', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          iconSize: 20,
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Color.fromARGB(255, 46, 38, 95),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.white),
                hintText: 'Cari Transaksi',
                hintStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Color.fromARGB(218, 251, 138, 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: filteredTransaksiList.length,
              itemBuilder: (context, index) {
                final transaksiItem = filteredTransaksiList[index];
                return Card(
                  color: Colors.grey[500],
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Icon(Icons.money_off, color: const Color.fromARGB(255, 194, 55, 13)),
                    title: Text('Transaksi #${transaksiItem['id']}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailTransaksi(transaksi: transaksiItem),
                        ),
                      );
                    },
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
