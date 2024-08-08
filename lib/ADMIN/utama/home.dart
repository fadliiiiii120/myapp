import 'package:flutter/material.dart';
import 'package:myapp/ADMIN/utama/sidemenu_list.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class HomeAdm extends StatefulWidget {
  const HomeAdm({super.key});

  @override
  State<HomeAdm> createState() => _HomeAdmState();
}

class _HomeAdmState extends State<HomeAdm> {
  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();
  final List<String> dates = ['01 Juli 2024', '02 Juli 2024', '03 Juli 2024', '04 Juli 2024'];
  String selectedDate = '01 Juli 2024';

  final List<Map<String, dynamic>> salesData = [
    {
      'title': 'Kategori & Barang',
      'details': [
        'Jml Kategori: 8',
        'Jml Barang: 21'
      ]
    },
    {
      'title': 'Transaksi',
      'details': [
        'Omset: Rp.621.000',
        'Jml Transaksi: 20'
      ]
    },
    {
      'title': 'User',
      'details': [
        'Jml user: 20'
      ]
    },
    {
      'title': 'Promo',
      'details': [
        'Jml Promo: 4'
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      key: sideMenuKey,
      background: Color(0xff19143b),
      menu: SidemenuList(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            iconSize: 32,
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              if (sideMenuKey.currentState!.isOpened) {
                sideMenuKey.currentState!.closeSideMenu();
              } else {
                sideMenuKey.currentState!.openSideMenu();
              }
            },
          ),
          title: const Text('Admin', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        backgroundColor: Color.fromARGB(255, 46, 38, 95),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Laporan penjualan tanggal',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  DropdownButton<String>(
                    value: selectedDate,
                    dropdownColor: Color.fromARGB(255, 64, 52, 125),
                    icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    underline: Container(
                      height: 2,
                      color: Colors.white,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDate = newValue!;
                      });
                    },
                    items: dates.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 3 / 3.7,
                        ),
                        itemCount: salesData.length,
                        itemBuilder: (context, index) {
                          final sale = salesData[index];
                          return Card(
                            color: Color.fromARGB(255, 64, 52, 125),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      sale['title'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 18),
                                    for (var detail in sale['details'])
                                      Text(
                                        detail,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
