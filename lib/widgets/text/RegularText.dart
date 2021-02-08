import 'package:auto_size_text/auto_size_text.dart';
import 'package:exchange_books/values/AppColors.dart';
import 'package:flutter/material.dart';

class RegularText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final TextAlign align;
  final int maxLines;
  final TextOverflow overflow;
  final bool autoResize;

  RegularText(this.text,
      {this.fontSize = 17,
        this.color = AppColors.primaryText,
        this.align,
        this.maxLines,
        this.overflow,
        this.autoResize = false, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle style = TextStyle(
        fontFamily: "Economica",
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w400
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
