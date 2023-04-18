import 'package:flutter/material.dart';

class Shope {
  final String id;
  final String name;
  final double rating;
  final String imageUrl;
  final String address;
  final String desc;

  Shope(
      {required this.desc,
      required this.id,
      required this.imageUrl,
      required this.name,
      required this.rating,
      required this.address});
}

final List shope = [
  Shope(
    id: DateTime.now().toString(),
    desc: "This is Barbar shope which is in NewYork",
    name: 'The Barber Shop',
    address: '123 Main St, Anytown USA',
    imageUrl: 'https://i.pravatar.cc/150?img=18',
    rating: 4.5,
  ),
  //  const SizedBox(height: 16.0),
  Shope(
    id: DateTime.now().toString(),
    name: 'Cuts and Shaves',
    address: '456 Elm St, Anytown USA',
    imageUrl: 'https://i.pravatar.cc/150?img=19',
    rating: 4.8,
    desc: "This is Barbar shope which is in NewYork",
  ),
  // const SizedBox(height: 16.0),
  Shope(
    id: DateTime.now().toString(),
    name: 'Hair Masters',
    address: '789 Oak St, Anytown USA',
    imageUrl: 'https://i.pravatar.cc/150?img=20',
    rating: 4.2,
    desc: "This is Barbar shope which is in NewYork",
  ),
];
