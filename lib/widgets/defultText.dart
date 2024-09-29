import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final TextOverflow? overflow;
  final Color color;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextDecoration? textDecoration;

  const CustomText(
      {super.key,
        required this.text,
        this.maxLines,
         this.color = Colors.black,
        this.textAlign,
        this.fontWeight = FontWeight.normal,
        this.overflow = TextOverflow.ellipsis,
        this.textDecoration,
        this.fontSize, });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textDirection: TextDirection.ltr,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        decoration: textDecoration,
      ),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}