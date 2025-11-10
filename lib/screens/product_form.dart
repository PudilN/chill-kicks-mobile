import 'package:flutter/material.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  int _price = 0;
  String _description = "";
  String _category = "sneakers";
  String _thumbnail = "";
  bool _isFeatured = false;

  final List<String> _categories = [
    'sneakers',
    'running',
    'casual',
    'basket',
    'slip-on',
  ];

  bool _isValidUrl(String url) {
    final Uri? uri = Uri.tryParse(url);
    return uri != null && (uri.isScheme('http') || uri.isScheme('https'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add New Product')),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Product Name ===
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Product Name",
                  hintText: "Masukkan nama produk",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() => _name = value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama produk tidak boleh kosong!";
                  } else if (value.length < 3) {
                    return "Nama produk minimal 3 karakter!";
                  } else if (value.length > 50) {
                    return "Nama produk terlalu panjang (maks. 50 karakter)!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // === Price ===
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Price",
                  hintText: "Masukkan harga (angka positif)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _price = int.tryParse(value) ?? 0;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Harga tidak boleh kosong!";
                  }
                  final parsed = int.tryParse(value);
                  if (parsed == null) {
                    return "Harga harus berupa angka!";
                  } else if (parsed <= 0) {
                    return "Harga harus lebih dari 0!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // === Description ===
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Description",
                  hintText: "Masukkan deskripsi produk",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() => _description = value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Deskripsi tidak boleh kosong!";
                  } else if (value.length < 10) {
                    return "Deskripsi minimal 10 karakter!";
                  } else if (value.length > 300) {
                    return "Deskripsi terlalu panjang (maks. 300 karakter)!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // === Category Dropdown ===
              DropdownButtonFormField<String>(
                value: _category,
                decoration: InputDecoration(
                  labelText: "Category",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                items: _categories
                    .map(
                      (cat) => DropdownMenuItem(
                        value: cat,
                        child: Text(cat[0].toUpperCase() + cat.substring(1)),
                      ),
                    )
                    .toList(),
                onChanged: (newValue) {
                  setState(() => _category = newValue!);
                },
              ),
              const SizedBox(height: 16),

              // === Thumbnail URL ===
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Thumbnail URL (optional)",
                  hintText: "https://contoh.com/gambar.jpg",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() => _thumbnail = value);
                },
                validator: (value) {
                  if (value != null &&
                      value.isNotEmpty &&
                      !_isValidUrl(value)) {
                    return "URL thumbnail tidak valid! (harus diawali http/https)";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // === Featured Switch ===
              SwitchListTile(
                title: const Text("Tandai sebagai Produk Unggulan"),
                value: _isFeatured,
                onChanged: (value) {
                  setState(() => _isFeatured = value);
                },
              ),
              const SizedBox(height: 24),

              // === SAVE BUTTON ===
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Produk Berhasil Disimpan"),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                Text("Nama: $_name"),
                                Text("Harga: Rp $_price"),
                                Text("Deskripsi: $_description"),
                                Text("Kategori: $_category"),
                                Text(
                                  "Thumbnail: ${_thumbnail.isEmpty ? '-' : _thumbnail}",
                                ),
                                Text(
                                  "Unggulan: ${_isFeatured ? "Ya" : "Tidak"}",
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: const Text("OK"),
                              onPressed: () {
                                // Tutup pop-up
                                Navigator.pop(context);

                                // Kembalikan data ke halaman utama
                                Navigator.pop(context, {
                                  "name": _name,
                                  "price": _price,
                                  "description": _description,
                                  "category": _category,
                                  "thumbnail": _thumbnail,
                                  "isFeatured": _isFeatured,
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
