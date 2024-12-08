import 'package:flutter/material.dart';
import '../../../data/comics.dart'; // Comics ma'lumotlarini import qilish

class ComicsList extends StatelessWidget {
  const ComicsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220, // Boxning bo'yi
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: comics.length, // Komikslar soni
        itemBuilder: (context, index) {
          final comic = comics[index]; // Komiksni olish
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: 140, // Komiks kartochkasining kengligi
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(15), // Burchaklarni yumshatish
                gradient: LinearGradient(
                  colors: [
                    Colors.orange.shade400,
                    Colors.red.shade500
                  ], // Gradient fon
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // Rasmni joylashtirish
                    Positioned.fill(
                      child: Image.asset(
                        comic.posterUrl, // Komiksning rasmiga ulanish
                        fit: BoxFit.cover, // Rasmni to'liq qoplash
                      ),
                    ),
                    // Komiksning nomi va narxi
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        color: Colors.black.withOpacity(0.7), // Matn foni
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              comic.title, // Komiks nomi
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 1.1,
                              ),
                              textAlign: TextAlign.center,
                              overflow:
                                  TextOverflow.ellipsis, // Matnni qisqartirish
                            ),
                            Text(
                              "\$${comic.price.toStringAsFixed(2)}", // Komiks narxi
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.greenAccent,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
