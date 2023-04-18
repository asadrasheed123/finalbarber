class Styling {
  final double price;
  final String title;
  final String imageUrl;
  final String desc;
  final String id;
  Styling(
      {required this.price,
      required this.id,
      required this.title,
      required this.imageUrl,
      required this.desc});
}

final services = [
  Styling(
    price: 10,
    id: DateTime.now().toString(),
    desc:
        "Hair dye is a cosmetic product that changes the color of hair using chemicals. It comes in permanent, semi-permanent, and temporary forms and can be found in various colors. It's important to follow the instructions and do a patch test before using it.",
    title: 'Hair Dye',
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/487/487522.png',
  ),
  Styling(
    price: 15,
    id: DateTime.now().toString(),
    desc: "This is the barbar Shope",
    title: 'Hair Cut',
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/32/32069.png',
  ),
  Styling(
    price: 20,
    id: DateTime.now().toString(),
    desc: "This is the barbar Shope",
    title: 'Beard Trim',
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/10045/10045153.png',
  ),
  Styling(
      price: 10,
      id: DateTime.now().toString(),
      title: 'Styling',
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/10183/10183446.png',
      desc: "This is the barber shope which is in NewYork"),
  Styling(
      price: 10,
      id: DateTime.now().toString(),
      title: 'Grooming',
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/1005/1005684.png',
      desc: "This is the barber shope which is in NewYork"),
  Styling(
      price: 10,
      id: DateTime.now().toString(),
      title: 'Line Up',
      imageUrl:
          'https://as1.ftcdn.net/v2/jpg/03/54/54/46/1000_F_354544690_fm52JlC05S2ixh9N8V1MXIl2rhRFeps9.jpg',
      desc: "This is the barber shope which is in NewYork"),
  Styling(
      price: 10,
      id: DateTime.now().toString(),
      title: 'Tattoos',
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/2635/2635834.png',
      desc: "This is the barber shope which is in NewYork"),
];
