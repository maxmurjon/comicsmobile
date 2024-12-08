import 'package:comics/Widgets/welcome_btn.dart';
import 'package:comics/screens/Auth/sighUp.dart';
import 'package:comics/screens/Auth/signIn.dart';
import 'package:flutter/material.dart';
import '../../Widgets/custon_scaffold.dart'; // Fixed typo in import

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustonScaffold(
      child: Column(
        children: [
          Flexible(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logoning tepasida joy qoldirish uchun SizedBox qo'shildi
                  const SizedBox(height: 100), // Tepa bo'shliq
                  Image.asset(
                    "assets/logo.png",
                    height: 130,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Xush Kelibsiz\n',
                          style: TextStyle(
                            color: Colors.yellow[600],
                            fontSize: 45.0,
                            fontWeight: FontWeight.w600,
                            shadows: const [
                              Shadow(
                                offset: Offset(1.0, 1.0), // Soyaning yo'nalishi
                                blurRadius: 20.0, // Soya tarqalish radiusi
                                color: Colors.black, // Soyaning rangi
                              ),
                            ],
                          ),
                        ),
                        TextSpan(
                          text: "Tizimga kiring yoki Ro'yxatdan o'ting\n",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.yellow[400],
                            shadows: const [
                              Shadow(
                                offset: Offset(1.0, 1.0), // Soyaning yo'nalishi
                                blurRadius: 20.0, // Soya tarqalish radiusi
                                color: Colors.black, // Soyaning rangi
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    const Expanded(
                      child: WelcomeButton(
                        buttonText: "Ro'yhatdan\no'tish",
                        ontap: SignUpScreen(),
                        color: Colors.transparent,
                        textcolor: Color(0xFFffffff),
                      ),
                    ),
                    Expanded(
                      child: WelcomeButton(
                        buttonText: "    Tizimga\n    kirish",
                        ontap: SignInScreen(),
                        color: Colors.yellow[600],
                        textcolor: const Color(0xFF4d008c),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
