import 'package:exchange_books/models/AppAlertModel.dart';
import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier{

  bool progress = false;
  AppAlertModel alert;

  showProgress(){
    progress = true;
    notifyListeners();
  }

  dismissProgress(){
    progress = false;
    notifyListeners();
  }

  showAlert(String title, String message, AlertType type) {
    alert = AppAlertModel(
        title: title,
        message: message,
        type: type,
        onClose: () {
          hideAlert();
        });
    notifyListeners();
  }

  hideAlert() {
    alert = null;
    notifyListeners();
  }

}