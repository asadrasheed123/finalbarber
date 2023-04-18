import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteShopScreen extends StatefulWidget {
  @override
  _DeleteShopScreenState createState() => _DeleteShopScreenState();
}

class _DeleteShopScreenState extends State<DeleteShopScreen> {
  late final CollectionReference _shopsRef;

  @override
  void initState() {
    super.initState();
    _shopsRef = FirebaseFirestore.instance.collection('shops');
  }

  Future<void> _deleteShop(DocumentSnapshot shop) async {
    try {
      await shop.reference.delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Shop deleted')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting shop: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Delete Shop'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _shopsRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final shops = snapshot.data!.docs;
          return ListView.builder(
            itemCount: shops.length,
            itemBuilder: (context, index) {
              final shop = shops[index];
              return ListTile(
                title: Text(shop['shopName']),
                subtitle: Text(shop['description']),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteShop(shop),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
