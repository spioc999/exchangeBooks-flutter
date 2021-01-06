import 'package:exchange_books/AppConfig.dart';
import 'package:exchange_books/base/BaseViewModel.dart';
import 'package:exchange_books/data_managers/DataManager.dart';
import 'package:exchange_books/models/AppAlertModel.dart';
import 'package:exchange_books/routes/Routes.dart';
import 'package:exchange_books/values/AppValidators.dart';
import 'package:exchange_books/values/Strings.dart';
import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';


class LoginViewModel extends BaseViewModel{

  String email;
  String psw;

  bool rememberMe = true;
  bool obscurePassword = true;

  bool autovalidate = false;

  TextEditingController pswController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void init(BuildContext context) async{
    //Retrieve if present email and password from cache
    DataManager dm = DataManager();

    var email = await dm.managerUser.getSavedEmail();
    var psw = await dm.managerUser.getSavedPassword();

    if(email.response != null && psw.response != null){
      emailController.text = email.response;
      this.email = email.response;
      pswController.text = psw.response;
      this.psw = psw.response;
      notifyListeners();
    }

  }

  void onClickSignIn(BuildContext context, GlobalKey<FormState> key) async{

    if(key.currentState.validate()){
      DataManager dm = DataManager();

      this.showProgress();

      //Try to login to system
      var dmr = await dm.managerUser.login(
          AppConfig.of(context).apiHostUrl,
          AppConfig.of(context).clientId,
          AppConfig.of(context).clientSecret,
          email: this.email,
          psw: this.psw
      );

      if(dmr.hasError()){
        this.dismissProgress();
        showAlert(Strings.invalidCredentials, Strings.insertCorrectCredentials, AlertType.error);
        return;
      } else{

        if(dmr.response.result == null || dmr.response.result.bearerToken == null || dmr.response.result.user == null){
          this.dismissProgress();
          showAlert(Strings.error, Strings.genericErrorMessage, AlertType.error);
          return;
        }

        //Handle cache
        await dm.managerUser.saveEmail(rememberMe ? email : null);
        await dm.managerUser.savePassword(rememberMe ? psw : null);
        await dm.managerUser.saveBearerToken(dmr.response.result.bearerToken);
        await dm.managerUser.saveCurrentUser(dmr.response.result.user);

        this.dismissProgress();

        Routes.sailor.navigate(Routes.home,
          navigationType: NavigationType.pushReplace);
      }
    }else{
      autovalidate = true;
    }

    notifyListeners();
    
  }

  void onChangeEmail(String newValue, GlobalKey<FormState> key){
    this.email = newValue;
    notifyListeners();
  }

  void onChangePassword(String newValue){
    this.psw = newValue;
    notifyListeners();
  }

  void onChangeRememberMe(bool newValue){
    this.rememberMe = newValue;
    notifyListeners();
  }

  String validateEmail(String email){
    final bool isValid = AppValidators.emailValidator.hasMatch(email);

    if(isValid) return null;

    return Strings.insertValidEmail;
  }

  bool get enableLogin => this.email != null && this.email.length > 0 && this.psw != null && this.psw.length > 0;

  void toggleObscurePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void goToRegister(){
    Routes.sailor.navigate(Routes.registration);
  }

}