import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final TextAlign align;
  final int maxLines;
  final TextOverflow overflow;
  final bool autoResize;

  BoldText(this.text,
      {this.fontSize = 17,
        this.color = Colors.black,
        this.align,
        this.maxLines,
        this.overflow,
        this.autoResize = false,});

  @override
  Widget build(BuildContext context) {
    final TextStyle style = TextStyle(
        fontFamily: "Economica",
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w700
    );

    if(autoResize) {
      return AutoSizeText(
        text,
        style: style,
        textAlign: align,
        maxLines: maxLines,
        overflow: overflow,
      );
    } else {
      return Text(
        text,
        style: style,
        textAlign: align,
        maxLines: maxLines,
        overflow: overflow,
      );
    }
  }
}
