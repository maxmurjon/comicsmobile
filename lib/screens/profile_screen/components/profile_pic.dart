import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../services/profile.dart'; // ProfileService import qilish
import '../../../data/models/user.dart'; // User modelini import qilish

class ProfilePicWithInfo extends StatefulWidget {
  const ProfilePicWithInfo({Key? key}) : super(key: key);

  @override
  State<ProfilePicWithInfo> createState() => _ProfilePicWithInfoState();
}

class _ProfilePicWithInfoState extends State<ProfilePicWithInfo> {
  User? user;
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      final profileService = ProfileService();
      final fetchedUser = await profileService.getUserProfile();

      setState(() {
        user = fetchedUser;
        isLoading = false;
      });
    } catch (e) {
      print('Error in fetchUserProfile: $e');
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (hasError || user == null) {
      return const Center(
        child: Text('Ma\'lumotlarni yuklashda xatolik yuz berdi.'),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user!.imageUrl),
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

          // User information
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${user!.firstName} ${user!.lastName}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user!.phoneNumber,
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
