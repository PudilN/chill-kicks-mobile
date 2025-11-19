import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:chill_kicks/screens/menu.dart';

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
    final uri = Uri.tryParse(url);
    return uri != null && (uri.isScheme('http') || uri.isScheme('https'));
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Product Form')),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== PRODUCT NAME =====
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Product Name",
                    hintText: "Masukkan nama produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (v) => _name = v,
                  validator: (v) {
                    if (v == null || v.isEmpty)
                      return "Nama produk tidak boleh kosong!";
                    return null;
                  },
                ),
              ),

              // ===== PRICE =====
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Price",
                    hintText: "Masukkan harga produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (v) => _price = int.tryParse(v) ?? 0,
                  validator: (v) {
                    if (v == null || v.isEmpty)
                      return "Harga tidak boleh kosong!";
                    if (int.tryParse(v) == null)
                      return "Harga harus berupa angka!";
                    return null;
                  },
                ),
              ),

              // ===== DESCRIPTION =====
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "Description",
                    hintText: "Masukkan deskripsi produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (v) => _description = v,
                  validator: (v) {
                    if (v == null || v.isEmpty)
                      return "Deskripsi tidak boleh kosong!";
                    return null;
                  },
                ),
              ),

              // ===== CATEGORY =====
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  value: _category,
                  decoration: InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
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
                  onChanged: (v) => setState(() => _category = v!),
                ),
              ),

              // ===== THUMBNAIL URL =====
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Thumbnail URL (opsional)",
                    hintText: "https://contoh.com/gambar.jpg",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (v) => _thumbnail = v,
                  validator: (v) {
                    if (v != null && v.isNotEmpty && !_isValidUrl(v)) {
                      return "URL tidak valid!";
                    }
                    return null;
                  },
                ),
              ),

              // ===== IS FEATURED =====
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  title: const Text("Tandai sebagai Produk Unggulan"),
                  value: _isFeatured,
                  onChanged: (v) => setState(() => _isFeatured = v),
                ),
              ),

              // ===== SAVE BUTTON =====
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                    ),

                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // ------------------------------
                        //  POST DATA KE DJANGO BACKEND
                        // ------------------------------
                        final response = await request.postJson(
                          // TODO: ganti sesuai backend Django kamu
                          "http://127.0.0.1:8000/create-flutter/",
                          jsonEncode({
                            "name": _name,
                            "price": _price,
                            "description": _description,
                            "category": _category,
                            "thumbnail": _thumbnail,
                            "is_featured": _isFeatured,
                          }),
                        );

                        if (!context.mounted) return;

                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Product successfully saved!"),
                            ),
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (c) => MyHomePage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                response['message'] ?? "Something went wrong.",
                              ),
                            ),
                          );
                        }
                      }
                    },

                    child: const Text(
                      "Simpan",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
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
