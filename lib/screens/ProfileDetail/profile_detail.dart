import 'package:flutter/material.dart';
import '../../data/models/user.dart';

class ProfileDetailsScreen extends StatefulWidget {
  final User user;

  const ProfileDetailsScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileDetailsScreenState createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _phoneNumberController = TextEditingController(text: widget.user.phoneNumber);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _submitData() {
    final updatedData = {
      "firstName": _firstNameController.text,
      "lastName": _lastNameController.text,
      "phoneNumber": _phoneNumberController.text,
    };

    print("Updated Data: $updatedData");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Ma'lumotlar muvaffaqiyatli saqlandi!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ma\'lumotlarni O\'zgartirish',
          style: TextStyle(color: Color(0xFFB0B0B0)), // Change text color here
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
                style: TextStyle(color: Color(0xFFB0B0B0)), // Change text color here
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
