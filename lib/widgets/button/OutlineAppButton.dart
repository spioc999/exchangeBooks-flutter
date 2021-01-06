import 'package:auto_size_text/auto_size_text.dart';
import 'package:exchange_books/values/AppColors.dart';
import 'package:exchange_books/widgets/text/BoldText.dart';
import 'package:flutter/material.dart';

class OutlineAppButton extends StatelessWidget {

  static const smallButtonSize = 128.0;
  final VoidCallback onPressed;
  final String text;
  final bool small;
  final double smallWidth;
  final EdgeInsets margin;

  OutlineAppButton({this.onPressed, this.text,this.small = false, this.smallWidth = smallButtonSize, this.margin = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: small ? smallWidth : MediaQuery.of(context).size.width,
      height: 40,
      child: FlatButton(
        onPressed: this.onPressed,
        color: Colors.transparent,
        textColor: Colors.black,
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1,
              style: BorderStyle.solid,
              color: AppColors.appBlue
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: BoldText(
                  text.toUpperCase(),
                  fontSize: 14,
                  align: TextAlign.center,
                  maxLines: 1,
                  autoResize: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
