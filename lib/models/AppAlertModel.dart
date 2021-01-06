import 'package:flutter/cupertino.dart';

enum AlertType {
  error,
  info,
}

class AppAlertModel {
  final String title;
  final String message;
  final AlertType type;
  final VoidCallback onClose;

  AppAlertModel({@required this.title,
    @required this.message,
    @required this.type,
    @required this.onClose});

}