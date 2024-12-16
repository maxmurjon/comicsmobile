import 'package:comics/data/models/user.dart';
import 'package:flutter/material.dart';
import '../ProfileDetail/profile_detail.dart';
import 'components/profile_menu.dart';
import 'components/profile_pic.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePicWithInfo(),
            const SizedBox(height: 20),
            ProfileMenu(
                text: "Malumotlar",
                icon: "assets/icons/User Icon.svg",
                press: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileDetailsScreen(
                            user: User(
                              firstName: "Maxmurjon",
                              lastName: "Keldiyorov",
                              phoneNumber: "+998971153311",
                              imageUrl: "",
                            ),
                          ),
                        ),
                      ),
                    }),
            ProfileMenu(
              text: "Xaridlarim",
              icon: "assets/icons/Shop Icon.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Sozlamalar",
              icon: "assets/icons/Settings.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Yordam xizmati",
              icon: "assets/icons/Question mark.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Chiqish",
              icon: "assets/icons/Log out.svg",
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
