
import 'package:flutter/material.dart';
import 'package:thebarber/screens/widgets/styling_detail.dart';

class StylingItem extends StatelessWidget {
  final String title;
  final String id;
  final String desc;
  final String price;
  final String imageUrl;

  StylingItem({
    required this.price,
    required this.desc,
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(StylingDetailPage.routeName,
            arguments: {
              'title': title,
              'imageUrl': imageUrl,
              'desc': desc,
              'price': price
            });
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
              imageUrl,
            ),
            radius: 40.0,
          ),
          const SizedBox(height: 8.0),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
