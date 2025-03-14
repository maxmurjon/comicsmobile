import 'dart:convert'; // JSON uchun
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../presentation/screens/ProfileScreen/data/models/user.dart';

class ProfileDetailsScreen extends StatefulWidget {
  final User user;

  const ProfileDetailsScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileDetailsScreenState createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _submitData() async {
    final updatedData = {
      "first_name": _firstNameController.text,  // first_name
      "last_name": _lastNameController.text,    // last_name
    };

    try {
      // SharedPreferencesdan id va tokenni olish
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? id = prefs.getString('user_id'); // id olish
      final String? token = prefs.getString('token'); // token olish

      if (id == null || token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Foydalanuvchi ID yoki token mavjud emas.")),
        );
        return;
      }

      // Yuborilayotgan so'rovni konsolda ko'rish
      print('Sending PUT request to update user data');
      print('URL: http://3.123.128.20:8000/updateuser');
      print('Headers: {');
      print('  Content-Type: application/json');
      print('  Authorization: Bearer $token');
      print('}');
      print('Body:');
      print(json.encode({
        "id": id, // id ni yuborish
        ...updatedData,   // Yangi ma'lumotlar
      }));

      // Backend-ga so'rov yuborish
      final response = await http.put(
        Uri.parse('http://3.123.128.20:8000/updateuser'), // Backend URL
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Tokenni Authorization headerga qo'shish
        },
        body: json.encode({
          "id": id, // id ni yuborish
          ...updatedData,   // Yangi ma'lumotlar
        }),
      );

      // Response body'ni konsolga chiqarish
      print('Response body: ${response.body}');  // Bu yerda javobni konsolga chiqarish

      if (response.statusCode == 200) {
        // Muvaffaqiyatli javob
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Ma'lumotlar muvaffaqiyatli saqlandi!")),
        );
      } else {
        // Xatolik yuz berdi
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Ma'lumotlarni saqlashda xatolik yuz berdi!")),
        );
      }
    } catch (e) {
      // Xatolik yuz berdi
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Xatolik yuz berdi, iltimos qaytadan urinib ko'ring.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ma\'lumotlarni O\'zgartirish',
          style: TextStyle(color: Color(0xFFB0B0B0)), // Text color
        ),
        backgroundColor: const Color(0xFF4d008c),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'Ism',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Familiya',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text(
                'Submit',
                style: TextStyle(color: Color(0xFFB0B0B0)), // Text color
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4d008c),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
