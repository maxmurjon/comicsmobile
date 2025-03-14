import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart'; // image_picker paketini import qilish
import '../../data/upload_userimage.dart';
import '../../data/profile.dart';
import '../../data/models/user.dart'; // User modelini import qilish

class ProfilePicWithInfo extends StatefulWidget {
  const ProfilePicWithInfo({Key? key}) : super(key: key);

  @override
  State<ProfilePicWithInfo> createState() => _ProfilePicWithInfoState();
}

class _ProfilePicWithInfoState extends State<ProfilePicWithInfo> {
  User? user;
  bool isLoading = true;
  bool hasError = false;
  File? _image; // Tanlangan rasmni saqlash
  final ImagePicker _picker = ImagePicker(); // ImagePicker instance

  final User defaultUser = User(
    firstName: 'Default',
    lastName: 'User',
    phoneNumber: '+998900000000',
    imageUrl: 'https://via.placeholder.com/150', // Placeholder rasm URLsi
  );

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
        user = defaultUser; // Xato yuz berganda default ma'lumotlarni qo'llash
      });
    }
  }

  // Rasmni tanlash
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery); // Galereyadan rasm tanlash

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Tanlangan rasmni saqlash
      });

      // Keyin rasmni serverga yuborish
      await _uploadImage();
    }
  }

  // Rasmni yuklash
  Future<void> _uploadImage() async {
    if (_image == null) return;

    setState(() {
      isLoading = true;
    });

    try {
      final profileService = ProfileImageService();
      final response = await profileService.uploadProfileImage(_image!); // Rasmni yuklash uchun servisga murojaat qilish

      if (response) {
        setState(() {
          isLoading = false;
          fetchUserProfile(); // Profilni yangilash
        });
      } else {
        setState(() {
          isLoading = false;
          hasError = true;
          user = defaultUser; // Xato yuz berganda default ma'lumotlarni qo'llash
        });
      }
    } catch (e) {
      print('Error uploading image: $e');
      setState(() {
        isLoading = false;
        hasError = true;
        user = defaultUser; // Xato yuz berganda default ma'lumotlarni qo'llash
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
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
                      onPressed: _pickImage, // Kamera ikonasini bosganda rasmni tanlash
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
