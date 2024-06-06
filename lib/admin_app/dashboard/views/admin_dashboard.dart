import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_flutter/core/collection_path.dart';
import 'package:flutter/material.dart';

import 'local_widgets/decoratedbox.dart';

class AdminDashboard extends StatelessWidget {
  final int totalOrders = 120;
  final int activeOrders = 30;
  final int deliveredOrders = 90;

  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection(CollectionPaths.admins).snapshots(),
              builder: (context, snapshot) {
                return DashboardBox(
                  title: 'Total Orders',
                  count: snapshot.data?.docs.length??0,
                  color: Colors.blue,
                  icon: Icons.shopping_cart,
                );
              }
            ),
            const SizedBox(height: 16),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection(CollectionPaths.admins).where('status', isEqualTo: 'active').snapshots(),
              builder: (context, snapshot) {
                return DashboardBox(
                  title: 'Active Orders',
                  count: snapshot.data?.docs.length??0,
                  color: Colors.orange,
                  icon: Icons.local_shipping,
                );
              }
            ),
            const SizedBox(height: 16),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection(CollectionPaths.admins).where('status', isEqualTo: 'delivered').snapshots(),
              builder: (context, snapshot) {
                return DashboardBox(
                  title: 'Delivered Orders',
                  count: snapshot.data?.docs.length??0,
                  color: Colors.green,
                  icon: Icons.check_circle,
                );
              }
            ),
            const SizedBox(height: 16),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection(CollectionPaths.productCollection).snapshots(),
              builder: (context, snapshot) {
                return DashboardBox(
                  title: 'Products',
                  count: snapshot.data?.docs.length??0,
                  color: Colors.cyan,
                  icon: Icons.check_circle,
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}