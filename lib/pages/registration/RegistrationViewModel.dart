import 'package:exchange_books/AppConfig.dart';
import 'package:exchange_books/base/BaseViewModel.dart';
import 'package:exchange_books/data_managers/DataManager.dart';
import 'package:exchange_books/models/AppAlertModel.dart';
import 'package:exchange_books/routes/Routes.dart';
import 'package:exchange_books/values/AppValidators.dart';
import 'package:exchange_books/values/ExchangeBooksValueKey.dart';
import 'package:exchange_books/values/Strings.dart';
import 'package:exchange_books/widgets/text/BoldText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:sailor/sailor.dart';


class RegistrationViewModel extends BaseViewModel{

  String username;
  String email;
  String psw;
  String repeatPsw;
  String lastName;
  String firstName;
  String city;
  String province;
  bool obscurePassword = true;
  bool obscureRepeatPassword = true;

  bool autovalidate = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pswController = TextEditingController();
  TextEditingController repeatPswController = TextEditingController();
  TextEditingController capController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController provinceController = TextEditingController();


  void init(BuildContext context) async{}

  void onChangeFirstName(String newValue) {
    this.firstName = newValue;
    notifyListeners();
  }

  void onChangeLastName(String newValue) {
    this.lastName = newValue;
    notifyListeners();
  }

  void onChangeUsername(String newValue) {
    this.username = newValue;
    notifyListeners();
  }

  void onChangeEmail(String newValue) {
    this.email = newValue;
    notifyListeners();
  }

  void onChangePsw(String newValue) {
    this.psw = newValue;
    notifyListeners();
  }

  void onChangeRepeatPsw(String newValue) {
    this.repeatPsw = newValue;
    notifyListeners();
  }

  void toggleObscurePassword() {
    this.obscurePassword = !this.obscurePassword;
    notifyListeners();
  }

  void toggleObscureRepeatPassword() {
    this.obscureRepeatPassword = !this.obscureRepeatPassword;
    notifyListeners();
  }

  void onChangeCity(String newValue) {
    this.city = newValue;
    notifyListeners();
  }

  void onChangeProvince(String newValue) {
    this.province = newValue.toUpperCase();
    notifyListeners();
  }


  String validateEmail(String email) {
    bool isValid = AppValidators.emailValidator.hasMatch(email);

    if(isValid) return null;

    return Strings.insertValidEmail;
  }

  String validatePsw(String psw) {
    bool isValid = AppValidators.pswValidator.hasMatch(psw);

    if(isValid) return null;

    return Strings.insertValidPassword;
  }

  String validateRepeatPsw() {

    if(this.psw == this.repeatPsw) return null;

    return Strings.errorRepeatPassword;
  }

  String validateUsername() {

    if(!this.username.contains(" ")) return null;

    return Strings.usernameError;
  }



  bool get enableRegisterButton => this.firstName != null && this.firstName.trim().isNotEmpty &&
                                    this.lastName != null && this.lastName.trim().isNotEmpty &&
                                    this.username != null && this.username.trim().isNotEmpty &&
                                    this.email != null && this.email.trim().isNotEmpty &&
                                    this.psw != null && this.psw.trim().isNotEmpty &&
                                    this.repeatPsw != null && this.repeatPsw.trim().isNotEmpty &&
                                    this.city != null && this.city.trim().isNotEmpty &&
                                    this.province != null && this.province.trim().isNotEmpty;
  
  void onClickRegister(BuildContext context, GlobalKey<FormState> key) async{

    if(key.currentState.validate()){

      DataManager dm = DataManager();

      this.showProgress();

      var dmr = await dm.managerUser.registerNewUser(
          AppConfig.of(context).apiHostUrl,
          AppConfig.of(context).clientId,
          AppConfig.of(context).clientSecret,
          username: this.username,
          psw: this.psw,
          email: this.email,
          lastName: this.lastName,
          firstName: this.firstName,
          city: this.city,
          province: this.province
      );
      
      this.dismissProgress();
      
      if(dmr.hasError()){
        showAlert(Strings.genericHttpErrorTitle, Strings.genericHttpErrorMessage, AlertType.error);
        return;
      }

      showModalBottomSheet(
          context: context,
          builder: (context){
            return WillPopScope(
              onWillPop: () async => false,
              child: ListTile(
                key: ValueKey(ExchangeBooksValueKey.registerCompleted),
                contentPadding: EdgeInsets.only(bottom: 16, right: 16, left: 16),
                leading: Icon(Icons.check_circle, color: Colors.green,),
                title: BoldText(Strings.registrationCompleted),
                onTap: (){
                  Routes.sailor.navigate(
                    Routes.login,
                    navigationType: NavigationType.pushAndRemoveUntil,
                    removeUntilPredicate: (_) => false
                  );
                },
              ),
            );
          },
          isDismissible: false,
          enableDrag: false
      );
      
    }else{
      autovalidate = true;
    }

    notifyListeners();
  }

  showPlaces(BuildContext context) async{

    //TODO: fix this

    Prediction prediction = await PlacesAutocomplete.show(
        context: context,
        apiKey: AppConfig.of(context).googleApiKey,
        types: ["(cities)"],
        hint: Strings.searchYourCity,
        mode: Mode.overlay, // Mode.overlay
        language: "it",
        components: [Component(Component.country, "it")]);

    if(prediction != null){

      List<String> description = prediction.description.split(", ");

      if(description.length == 3){
        city = prediction.description.split(", ")[0];
        province = prediction.description.split(", ")[1];
      }else if(description.length == 4){
        city = prediction.description.split(", ")[1];
        province = prediction.description.split(", ")[2];
      }

      cityController.text = city;
      provinceController.text = province;
    }

    notifyListeners();

  }


}