import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/home/Appointment.dart';


class ShopSearchPage extends StatefulWidget {
  @override
  _ShopSearchPageState createState() => _ShopSearchPageState();
}

class _ShopSearchPageState extends State<ShopSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  late Stream<QuerySnapshot> _stream = Stream.empty();

  void _onSearchTextChanged(String searchText) {
    setState(() {
      _searchText = searchText.trim();
    });
  }

  void _runSearchQuery() {
    if (_searchText != null && _searchText.isNotEmpty) {
      setState(() {
        _stream = FirebaseFirestore.instance
            .collection('shops')
            .where('city', isGreaterThanOrEqualTo: _searchText)
            .where('city', isLessThan: _searchText + 'z')
            .snapshots();
      });
    } else {
      setState(() {
        _stream = Stream.empty();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search by City',hintStyle: TextStyle(color: Colors.white),
          ),
          onChanged: _onSearchTextChanged,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _runSearchQuery,
          ),
        ],
      ),
      body: _stream == null || _stream == Stream.empty()
          ? Center(child: Text('Enter a search term above.'))
          : StreamBuilder(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              List<QueryDocumentSnapshot> documents = snapshot.data?.docs ?? [];
              if (documents.isEmpty) {
                return Center(child: Text('No shops found.'));
              } else {
                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to the payment page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Appoitment()),
                        );
                      },
                      child: ListTile(
                        title: Text((documents[index].data() as Map<String, dynamic>)['shopName']),
                        subtitle: Text((documents[index].data() as Map<String, dynamic>)['address']),
                        trailing: Text((documents[index].data() as Map<String, dynamic>)['zip']),
                      ),
                    );
                  },
                );

              }
          }
        },
      ),
    );
  }
}
