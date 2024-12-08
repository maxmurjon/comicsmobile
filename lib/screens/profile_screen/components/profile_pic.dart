import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePicWithInfo extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;

  const ProfilePicWithInfo({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0), // Chap va o'ng tomonga padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ikkala chetga joylashish
        crossAxisAlignment: CrossAxisAlignment.center, // Vertikal markazlash
        children: [
          // Avatar
          SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/Profile Image.png"),
                ),
                Positioned(
                  right: -16,
                  bottom: 0,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: const BorderSide(color: Colors.white),
                        ),
                        backgroundColor: const Color(0xFFF5F6F9),
                      ),
                      onPressed: () {},
                      child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Ma'lumotlar
          Expanded(
            child: Align(
              alignment: Alignment.centerRight, // Ma'lumotlarni o'ng chetga joylashtirish
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end, // Matnni o'ngga tekislash
                children: [
                  Text(
                    "$firstName $lastName",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
