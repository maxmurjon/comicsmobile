import 'package:flutter/material.dart';

class CustonScaffold extends StatelessWidget {
  const CustonScaffold({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Rangli to'rtburchak fon
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF4d008c), // To'q binafsha
                  Color(0xFF7e57c2), // Yorug'roq binafsha
                ],
              ),
            ),
          ),
          // Kontentni joylashtirish
          SafeArea(
            child: child!,
          ),
        ],
      ),
    );
  }
}
