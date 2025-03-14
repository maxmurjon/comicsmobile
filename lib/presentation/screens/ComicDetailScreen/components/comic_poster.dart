import 'package:flutter/material.dart';

class ComicPoster extends StatelessWidget {
  final String posterUrl;

  const ComicPoster({Key? key, required this.posterUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12), // Yumaloq burchaklar
        image: DecorationImage(
          image: AssetImage(posterUrl),
          fit: BoxFit.contain, // Rasm shaklini buzmaydi
        ),
      ),
    );
  }
}
