import 'package:exchange_books/values/AppColors.dart';
import 'package:exchange_books/widgets/text/BoldText.dart';
import 'package:flutter/material.dart';

class OutlineAppHeaderIconButton extends StatelessWidget {

  static const smallButtonSize = 100.0;
  final VoidCallback onPressed;
  final String text;
  final bool small;
  final double smallWidth;
  final EdgeInsets margin;
  final IconData iconData;

  OutlineAppHeaderIconButton({this.onPressed, this.text,this.small = false, this.smallWidth = smallButtonSize, this.margin = EdgeInsets.zero, this.iconData = Icons.account_circle_outlined, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: small ? smallWidth : MediaQuery.of(context).size.width,
      height: 35,
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
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Icon(
                  iconData,
                  color: AppColors.appBlue,
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: BoldText(
                  text.toUpperCase(),
                  fontSize: 13,
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
