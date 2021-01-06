import 'package:auto_size_text/auto_size_text.dart';
import 'package:exchange_books/values/AppColors.dart';
import 'package:exchange_books/widgets/text/BoldText.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {

  static const smallButtonSize = 128.0;
  final String text;
  final VoidCallback onPressed;
  final bool enabled;
  final bool small;
  final double smallWidth;
  final EdgeInsets margin;


  AppButton({this.text, this.onPressed, this.margin = EdgeInsets.zero, this.enabled = true, this.small = false, this.smallWidth = smallButtonSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: small ? smallWidth : MediaQuery.of(context).size.width,
      height: 40,
      decoration: BoxDecoration(
        color: this.enabled ? AppColors.appBlue : Colors.grey,
        borderRadius: BorderRadius.circular(10)
      ),
      child: FlatButton(
        onPressed: this.enabled ? this.onPressed : null,
        color: Colors.transparent,
        textColor: Colors.black,
        padding: EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: BoldText(
                  text.toUpperCase(),
                  color: this.enabled ? Colors.black : AppColors.primaryText,
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
