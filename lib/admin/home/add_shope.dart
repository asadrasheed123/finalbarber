
import 'dart:io';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddShopScreen extends StatefulWidget {
  @override
  _AddShopScreenState createState() => _AddShopScreenState();
}

class _AddShopScreenState extends State<AddShopScreen> {

  final _formKey = GlobalKey<FormState>();
  String _shopName = '';
  String _description = '';
  String _address = '';
  String _city = '';
  String _state = '';
  String _zip = '';
  String _barber = '';
  File? _image;

  Future<void> _addShop() async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('shops/${DateTime.now().millisecondsSinceEpoch}');
      final task = ref.putFile(_image!);
      final snapshot = await task.whenComplete(() => null);

      // Get image URL and add shop details to Firestore
      final imageUrl = await snapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('shops').add({
        'shopName': _shopName,
        'description': _description,
        'address': _address,
        'city': _city, // new field
        'state': _state, // new field
        'zip': _zip,
        'zip': _barber,
        'imageUrl': imageUrl,

      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Shop added')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding shop: $e')),
      );
    }
  }
  Future<void> _getImage() async {
    final pickedFile =
    await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Add Shop'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: 'Shop Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter shop name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _shopName = value ?? '';
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter city name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _city = value ?? '';
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: 'State',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter state name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _state = value ?? '';
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: 'Zip',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Zip code';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _zip = value ?? '';
                  },
                ),
                const SizedBox(height: 16.0),
                 TextFormField(
                   decoration: const InputDecoration(
                     labelText: 'Description',
                     border: OutlineInputBorder(),
                   ),
                   onSaved: (value) {
                     _description = value ?? '';
                   },
                 ),
                const SizedBox(height: 16.0),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: 'Barber Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Barber Name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _barber = value ?? '';
                  },
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Images',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _getImage(),
                        child: Container(
                          height: 100.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromRGBO(189, 189, 189, 1),
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: _image == null
                              ? const Center(
                            child: Text('Add Image'),
                          )
                              : Image.file(_image!, fit: BoxFit.cover),
                        ),


                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) {
                    _address = value ?? '';
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: const Text('Add Shop'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _addShop();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
