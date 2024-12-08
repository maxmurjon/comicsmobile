import 'package:flutter/material.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Yuqoridan padding qo'shildi
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16), // Burchaklarni yumaloqlash
        child: SizedBox(
          height: 200,
          child: PageView(
            children: [
              Image.asset(
                "assets/banner.jpg",
                fit: BoxFit.cover,
              ),
              Image.asset(
                "assets/banner_2.jpg",
                fit: BoxFit.cover,
              ),
              Image.asset(
                "assets/banner_3.jpg",
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
