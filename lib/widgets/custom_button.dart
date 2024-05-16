import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color btnColor;

  const CustomButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.btnColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 1),
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
