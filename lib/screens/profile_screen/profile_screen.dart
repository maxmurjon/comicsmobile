import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../services/profile.dart'; // ProfileService import qilamiz
import 'components/profile_menu.dart';
import 'components/profile_pic.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _getProfileData(),  // Profile ma'lumotlarini olish
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Mening Hisobim"),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Mening Hisobim"),
            ),
            body: Center(child: Text("Xato yuz berdi: ${snapshot.error}")),
          );
        } else if (snapshot.hasData) {
          final profileData = snapshot.data;

          // Agar profil ma'lumotlari bo'lsa, ularni ko'rsatamiz
          return Scaffold(
            appBar: AppBar(
              title: const Text("Mening Hisobim"),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  ProfilePicWithInfo(
                    firstName: profileData?['first_name'] ?? "Ism Noma'lum",
                    lastName: profileData?['last_name'] ?? "Familiya Noma'lum",
                    email: profileData?['email'] ?? "Email Noma'lum",
                  ),
                  const SizedBox(height: 20),
                  ProfileMenu(
                    text: "Malumotlar",
                    icon: "assets/icons/User Icon.svg",
                    press: () {},
                  ),
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
                    press: () async {
                      await AuthService().removeToken(); // Tokenni o'chirish
                      await AuthService().removeUserId(); // User ID ni o'chirish
                      // Chiqishdan keyin foydalanuvchini boshqa ekranga yo'naltirish
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          // Agar ma'lumot topilmasa
          return Scaffold(
            appBar: AppBar(
              title: const Text("Mening Hisobim"),
            ),
            body: const Center(child: Text("Profil ma'lumotlari topilmadi")),
          );
        }
      },
    );
  }

  // Profil ma'lumotlarini olish
  Future<Map<String, dynamic>?> _getProfileData() async {
    final token = await AuthService().getToken();
    final userId = await AuthService().getUserId();

    if (token != null && userId != null) {
      return ProfileService().getProfile(token, userId);
    } else {
      return null;  // Agar token yoki user_id mavjud bo'lmasa
    }
  }
}