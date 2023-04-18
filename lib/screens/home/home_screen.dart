
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thebarber/screens/home/shope_detail_page.dart';

import '../../model/shope.dart';
import '../../shopdetail.dart';

import '../membership.dart';
import '../widgets/shopItem.dart';
import '../widgets/styling_item.dart';
final User? user = FirebaseAuth.instance.currentUser;
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String? username = user?.displayName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text(
                  username??"",
                  style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(width: 70,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(

                    primary: Colors.red,
                    padding: EdgeInsets.all(16.0),
                  ),
                  child: Text(
                    'Subscription',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ]
              ),
              SizedBox(height: 10,),
              Text(
                "Get bookings online 24/7 with an all-in-one barbershop appointment app.",
                style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(height: 100,width: 400,child: const SearchBar()),
              const SizedBox(height: 16.0),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Shops:',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20,),

              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('shops')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        return  GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShopDetailPage(
                                  imageUrl: data['imageUrl'],
                                  shopName: data['shopName'],
                                  shopInfo: data['address'],
                                  shopDesc: data['description'],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 3,
                             child: Padding(
                               padding: const EdgeInsets.all(10),
                               child: Column(
                                 children: [
                                   Row(
                                     children: [
                                       SizedBox(
                                           height: 115,
                                           width: 100,
                                           child: Image.network(
                                               data['imageUrl'],
                                             fit: BoxFit.cover,

                                           )),
                               SizedBox(width: 10,),
                               Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Container(width: 100,child: Text(data['shopName'],style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.bold),)),
                                               SizedBox(height: 5,),
                                               Container(width: 150,child: Text(data['address'],style: GoogleFonts.roboto(fontSize: 15,),)),
                                               SizedBox(height: 5,),
                                               Container(width: 180,child: Text(data['description'],style: GoogleFonts.roboto(fontSize: 18,),)),
                                               SizedBox(height: 10,),
                                             ],
                                           ),
                                     ],
                                   ),
                                 ],
                               ),
                             ),
                          ),
                        );
                      }).toList(),
                    );
                  
                  },
                ),
              ),

              const SizedBox(height: 16.0),

            ],
          ),
        ),
      ),
    );
  }
}




class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];

  Future<void> _search(String searchText) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot snapshot = await firestore.collection('shops').get();
    final List<DocumentSnapshot> allResults = snapshot.docs;
    final List<DocumentSnapshot> results = [];

    for (final DocumentSnapshot document in allResults) {
      final String shopName = document['shopName'].toLowerCase();
      final String address = document['address'].toLowerCase();
      final String barber = document['barber'].toLowerCase();
      final String zip = document['zip'].toLowerCase();

      if (shopName.contains(searchText.toLowerCase()) ||
          address.contains(searchText.toLowerCase()) ||
          barber.contains(searchText.toLowerCase()) ||
          zip.contains(searchText.toLowerCase())) {
        results.add(document);
      }
    }

    setState(() {
      _searchResults = results;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search',
              hintText: 'Search for shops, barbers, addresses, or zip codes',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(),
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () => _search(_searchController.text),
              ),
            ),
          ),
        ),
        Expanded(
          child: _searchResults.isNotEmpty
              ? ListView.builder(
            itemCount: _searchResults.length,
            itemBuilder: (BuildContext context, int index) {
              final DocumentSnapshot document = _searchResults[index];
              final Map<String, dynamic> data =
              document.data() as Map<String, dynamic>;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShopDetailPage(
                        imageUrl: data['imageUrl'],
                        shopName: data['shopName'],
                        shopInfo: data['address'],
                        shopDesc: data['description'],
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 115,
                              width: 100,
                              child: Image.network(
                                data['imageUrl'],
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(
                                    data['shopName'],
                                    style: GoogleFonts.roboto(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
              : Container(),
        ),
      ],
    );
  }
}


