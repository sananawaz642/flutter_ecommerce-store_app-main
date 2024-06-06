import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_flutter/core/collection_path.dart';
import 'package:e_commerce_flutter/src/model/product.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection(CollectionPaths.productCollection).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator(),);
            }
            var products = snapshot.data!.docs.map((e) => Product.fromMap(e.data())).toList();
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return  ListTile(
                  title: Text(products[index].name),
                  subtitle: Text(products[index].about),
                  trailing: Text(products[index].price.toString()),
                );
              },
            );
          }
        ),
      ),
    );
  }
}