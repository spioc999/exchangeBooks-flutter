import 'package:exchange_books/values/AppColors.dart';
import 'package:flutter/material.dart';

class AppStyles {
  static const greyTextStyle = TextStyle(
      fontFamily: "Economica",
      fontSize: 17,
      color: AppColors.primaryText,
      fontWeight: FontWeight.w400
  );

  static const blackTextStyle = TextStyle(
      fontFamily: "Economica",
      fontSize: 17,
      color: Colors.black,
      fontWeight: FontWeight.w400
  );

  static const errorTextStyle = TextStyle(
      fontFamily: "Economica",
      fontSize: 13,
      color: Colors.red,
      fontWeight: FontWeight.w400
  );
}