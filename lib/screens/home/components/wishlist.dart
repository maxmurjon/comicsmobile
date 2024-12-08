import 'package:flutter/material.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 10, // Wishlistdagi mahsulotlar soni
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: const Icon(Icons.favorite, color: Colors.red),
                title: Text('Product #$index'),
                subtitle: const Text('Description of the product'),
                trailing: const Icon(Icons.remove_circle_outline),
                onTap: () {
                  print('Product #$index removed');
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
