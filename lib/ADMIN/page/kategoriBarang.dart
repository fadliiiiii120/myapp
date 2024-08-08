import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Kategoribarang extends StatefulWidget {
  @override
  _KategoribarangState createState() => _KategoribarangState();
}

class _KategoribarangState extends State<Kategoribarang> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedKategori;
  File? _image;
  final _judulBarangController = TextEditingController();
  final _deskripsiController = TextEditingController();

  final List<String> _kategoriList = [
    'Beras',
    'Minyak',
    'Susu',
    'Tepung',
    'Kopi',
    'Mie'
  ];

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Barang & Kategori',
            style: TextStyle(color: Colors.white)),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedKategori,
                      hint: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('Pilih Kategori',
                            style: TextStyle(color: Colors.white)),
                      ),
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedKategori = newValue;
                        });
                      },
                      items: _kategoriList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(value,
                                style: TextStyle(color: Colors.white)),
                          ),
                        );
                      }).toList(),
                      dropdownColor: Colors.grey[
                          500], // Menetapkan warna latar belakang dropdown
                    ),
                  ),
                ),

                SizedBox(height: 16.0),
                TextFormField(
                  controller: _judulBarangController,
                  decoration: InputDecoration(
                    labelText: 'Judul Barang',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Judul barang tidak boleh kosong'
                      : null,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _deskripsiController,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  maxLines: 4,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Deskripsi tidak boleh kosong'
                      : null,
                ),
                SizedBox(height: 16.0),
                // Menggunakan Row untuk menempatkan tombol di samping
                SizedBox(height: 16.0),
                _image == null
                    ? Text('Tidak ada gambar yang dipilih.',
                        style: TextStyle(color: Colors.white))
                    : Image.file(_image!),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(218, 251, 138, 0),
                      ),
                      onPressed: _pickImage,
                      child: Text('Upload Gambar',
                          style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 16.0), // Jarak antara tombol
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Proses pengiriman data
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Data berhasil disimpan!')),
                          );
                        }
                      },
                      child: Text('Kirim'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
