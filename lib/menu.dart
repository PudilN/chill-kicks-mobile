import 'package:flutter/material.dart';
import 'package:chill_kicks/screens/product_form.dart';
import 'package:chill_kicks/widgets/left_drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String nama = "Ainur Fadhil";
  final String npm = "2406360312";
  final String kelas = "F";

  final List<ItemHomepage> items = [
    ItemHomepage("All Products", Icons.list, Colors.blue),
    ItemHomepage("My Products", Icons.person, Colors.green),
    ItemHomepage("Create Product", Icons.add, Colors.red),
  ];

  // List untuk menyimpan produk yang baru ditambahkan
  List<Map<String, dynamic>> _products = [];

  @override
  Widget build(BuildContext context) {
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
            // InfoCard
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),
            const SizedBox(height: 16.0),

            const Text(
              'Selamat datang di Chill Kicks!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),

            // Grid Menu
            GridView.count(
              primary: false,
              padding: const EdgeInsets.all(16.0),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: items.map((ItemHomepage item) {
                return ItemCard(
                  item,
                  onProductCreated: (product) {
                    setState(() {
                      _products.add(product);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Produk '${product["name"]}' berhasil ditambahkan!",
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            // Menampilkan produk yang sudah dibuat
            if (_products.isNotEmpty) ...[
              const Divider(),
              const SizedBox(height: 10),
              const Text(
                "Produk yang baru ditambahkan:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final p = _products[index];
                    return ListTile(
                      leading: const Icon(
                        Icons.shopping_bag,
                        color: Colors.deepOrange,
                      ),
                      title: Text(p["name"]),
                      subtitle: Text("Rp ${p["price"]} • ${p["category"]}"),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;
  final Function(Map<String, dynamic>)? onProductCreated;

  const ItemCard(this.item, {super.key, this.onProductCreated});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () async {
          if (item.name == "Create Product") {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductFormPage()),
            );

            if (result != null && onProductCreated != null) {
              onProductCreated!(result);
            }
          } else {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text("Kamu menekan ${item.name}!"),
                  backgroundColor: item.color,
                ),
              );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text(content),
          ],
        ),
      ),
    );
  }
}
