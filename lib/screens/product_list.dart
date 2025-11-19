import 'package:flutter/material.dart';
import 'package:chill_kicks/models/product.dart';
import 'package:chill_kicks/widgets/left_drawer.dart';
import 'package:chill_kicks/widgets/ProductCard.dart';
import 'package:chill_kicks/screens/product_details.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  Future<List<Product>> fetchProducts(CookieRequest request) async {
    final response = await request.get('http://127.0.0.1:8000/json/');

    List<Product> listProducts = [];
    for (var d in response) {
      if (d != null) {
        listProducts.add(Product.fromJson(d));
      }
    }
    return listProducts;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProducts(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'No products available.',
                style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index) => ProductCard(
              product: snapshot.data![index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailPage(product: snapshot.data![index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
