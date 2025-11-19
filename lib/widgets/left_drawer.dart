import 'package:flutter/material.dart';
import 'package:chill_kicks/screens/product_form.dart';
import 'package:chill_kicks/screens/menu.dart';
import 'package:chill_kicks/screens/login.dart';
import 'package:chill_kicks/screens/product_list.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Header Profil
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepOrange.shade700,
                  Colors.deepOrange.shade400,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            accountName: const Text(
              'Ainur Fadhil',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: const Text('ainur@apple.com'),
          ),

          // Menu Drawer
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Halaman Utama'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.add_box_rounded),
                  title: const Text('Tambah Produk'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductFormPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.list),
                  title: const Text('Product List'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductListPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () async {
                    final response = await request.logout(
                      "http://127.0.0.1:8000/auth/logout/",
                    );
                    if (context.mounted) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                              response['message'] ?? "Logged out successfully",
                            ),
                          ),
                        );
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    }
                  },
                ),
              ],
            ),
          ),

          // Footer Drawer
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '👟 Chill Kicks v1.0.0',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
