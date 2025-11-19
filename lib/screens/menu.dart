import 'package:flutter/material.dart';
import 'package:chill_kicks/screens/product_list.dart';
import 'package:chill_kicks/screens/product_form.dart';
import 'package:chill_kicks/widgets/left_drawer.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final List<ItemHomepage> items = [
    ItemHomepage("All Products", Icons.list, Colors.blue),
    ItemHomepage("My Products", Icons.person, Colors.green),
    ItemHomepage("Create Product", Icons.add, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    final String username = request.jsonData["username"] ?? "Unknown";
    final int userId = request.jsonData["user_id"] ?? 0;
    final bool isStaff = request.jsonData["is_staff"] ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chill Kicks',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // INFO CARDS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'User ID', content: userId.toString()),
                InfoCard(title: 'Username', content: username),
                InfoCard(
                  title: 'Role',
                  content: isStaff ? "Admin" : "Pengguna",
                ),
              ],
            ),

            const SizedBox(height: 16.0),

            const Text(
              'Selamat datang di Chill Kicks!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),

            // GRID MENU
            GridView.count(
              padding: const EdgeInsets.all(16),
              primary: false,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              children: items.map((item) {
                return ItemCard(item);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () async {
          if (item.name == "All Products") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductListPage()),
            );
          } else if (item.name == "Create Product") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductFormPage()),
            );
          } else if (item.name == "My Products") {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Fitur 'My Products' masih dalam pengembangan."),
                backgroundColor: item.color,
              ),
            );
          }
        },

        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, color: Colors.white, size: 30),
              const SizedBox(height: 6),
              Text(
                item.name,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(content),
          ],
        ),
      ),
    );
  }
}
