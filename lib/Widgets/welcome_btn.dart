import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton({super.key, this.buttonText, this.ontap, this.color, this.textcolor});
  final String? buttonText;
  final Widget? ontap;
  final Color? color;
  final Color? textcolor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (e)=>ontap!,
        ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: color!,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
          ),
        ),
        child: Text(
          buttonText!,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textcolor!,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            shadows: const [
              Shadow(
                offset: Offset(1.0, 1.0), // Soyaning yo'nalishi
                blurRadius: 40.0, // Soya tarqalish radiusi
                color: Colors.black, // Soyaning rangi
              ),
            ],
          ),),
      ),
    );
  }
}
