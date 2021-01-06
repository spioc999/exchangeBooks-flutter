import 'package:dio/dio.dart';
import 'package:exchange_books/AppConfig.dart';
import 'package:exchange_books/base/BaseWidget.dart';
import 'package:exchange_books/pages/registration/RegistrationViewModel.dart';
import 'package:exchange_books/values/AppColors.dart';
import 'package:exchange_books/values/AppStyles.dart';
import 'package:exchange_books/values/Strings.dart';
import 'package:exchange_books/widgets/AppHeader.dart';
import 'package:exchange_books/widgets/SafeAreScrollView.dart';
import 'package:exchange_books/widgets/button/AppButton.dart';
import 'package:exchange_books/widgets/text/BoldText.dart';
import 'package:exchange_books/widgets/text/RegularText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> with WidgetsBindingObserver{

  RegistrationViewModel viewModel;

  final FocusScopeNode _node = FocusScopeNode();
  GlobalKey<FormState> _registrationKey;

  @override
  void initState() {
    super.initState();
    _registrationKey = GlobalKey<FormState>();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.init(context);
    });
  }


  @override
  void dispose() {
    _registrationKey = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: AppConfig.of(context).googleApiKey);

    viewModel = Provider.of<RegistrationViewModel>(context);

    return BaseWidget(
      progress: viewModel.progress,
      alert: viewModel.alert,
      safeAreaTop: true,
      safeAreaBottom: true,
      color: Colors.white,
      header: AppHeader(),
      body: SafeAreaScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _registrationKey,
            autovalidateMode: viewModel.autovalidate ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
            child: FocusScope(
              node: _node,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10, width: double.infinity,),
                  BoldText(Strings.registrationTitle, fontSize: 25,),
                  SizedBox(height: 25,),
                  TextFormField(
                    autocorrect: false,
                    controller: viewModel.firstNameController,
                    style: AppStyles.blackTextStyle,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    onEditingComplete: () => _node.nextFocus(),
                    decoration: InputDecoration(
                        focusColor: AppColors.appBlue,
                        hintText: Strings.firstName,
                        hintStyle: AppStyles.greyTextStyle,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0),)
                    ),
                    onChanged: (newValue) {
                      viewModel.onChangeFirstName(newValue);
                    },
                  ),
                  SizedBox(height: 13,),
                  TextFormField(
                    autocorrect: false,
                    controller: viewModel.lastNameController,
                    style: AppStyles.blackTextStyle,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    onEditingComplete: () => _node.nextFocus(),
                    decoration: InputDecoration(
                        focusColor: AppColors.appBlue,
                        hintText: Strings.lastName,
                        hintStyle: AppStyles.greyTextStyle,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0),)
                    ),
                    onChanged: (newValue) {
                      viewModel.onChangeLastName(newValue);
                    },
                  ),
                  SizedBox(height: 13,),
                  TextFormField(
                    autocorrect: false,
                    controller: viewModel.usernameController,
                    style: AppStyles.blackTextStyle,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    validator: (String username) => viewModel.validateUsername(),
                    onEditingComplete: () => _node.nextFocus(),
                    decoration: InputDecoration(
                        errorStyle: AppStyles.errorTextStyle,
                        focusColor: AppColors.appBlue,
                        hintText: Strings.username,
                        hintStyle: AppStyles.greyTextStyle,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0),)
                    ),
                    onChanged: (newValue) {
                      viewModel.onChangeUsername(newValue);
                    },
                  ),
                  SizedBox(height: 13,),
                  TextFormField(
                    autocorrect: false,
                    controller: viewModel.emailController,
                    style: AppStyles.blackTextStyle,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String email) => viewModel.validateEmail(email),
                    onEditingComplete: () => _node.nextFocus(),
                    decoration: InputDecoration(
                        errorStyle: AppStyles.errorTextStyle,
                        focusColor: AppColors.appBlue,
                        hintText: Strings.email,
                        hintStyle: AppStyles.greyTextStyle,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0),)
                    ),
                    onChanged: (newValue) {
                      viewModel.onChangeEmail(newValue);
                    },
                  ),
                  SizedBox(height: 13,),
                  TextFormField(
                    controller: viewModel.pswController,
                    obscureText: viewModel.obscurePassword,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => _node.nextFocus(),
                    validator: (String psw) => viewModel.validatePsw(psw),
                    autocorrect: false,
                    style: AppStyles.blackTextStyle,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        errorStyle: AppStyles.errorTextStyle,
                        focusColor: AppColors.appBlue,
                        suffixIcon: InkWell(
                          child: Icon(viewModel.obscurePassword ? Icons.visibility : Icons.visibility_off),
                          onTap: () {viewModel.toggleObscurePassword();},
                        ),
                        hintText: Strings.password,
                        hintStyle: AppStyles.greyTextStyle,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0),)
                    ),
                    onChanged: (newValue) {
                      viewModel.onChangePsw(newValue);
                    },
                  ),
                  SizedBox(height: 13,),
                  TextFormField(
                    controller: viewModel.repeatPswController,
                    obscureText: viewModel.obscureRepeatPassword,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => _node.nextFocus(),
                    validator: (String psw) => viewModel.validateRepeatPsw(),
                    autocorrect: false,
                    style: AppStyles.blackTextStyle,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        errorStyle: AppStyles.errorTextStyle,
                        focusColor: AppColors.appBlue,
                        suffixIcon: InkWell(
                          child: Icon(viewModel.obscureRepeatPassword ? Icons.visibility : Icons.visibility_off),
                          onTap: () {viewModel.toggleObscureRepeatPassword();},
                        ),
                        hintText: Strings.repeatPassword,
                        hintStyle: AppStyles.greyTextStyle,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0),)
                    ),
                    onChanged: (newValue) {
                      viewModel.onChangeRepeatPsw(newValue);
                    },
                  ),
                  SizedBox(height: 4,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: RegularText(Strings.suggestionPassword, fontSize: 14,),
                  ),
                  SizedBox(height: 13,),
                  GestureDetector(
                    onTap: () => viewModel.showPlaces(context),
                    child: TextFormField(
                      autocorrect: false,
                      enabled: false,
                      controller: viewModel.cityController,
                      style: AppStyles.blackTextStyle,
                      decoration: InputDecoration(
                          focusColor: AppColors.appBlue,
                          hintText: Strings.city,
                          hintStyle: AppStyles.greyTextStyle,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0),)
                      )
                    ),
                  ),
                  SizedBox(height: 13,),
                  TextFormField(
                      autocorrect: false,
                      enabled: false,
                      controller: viewModel.provinceController,
                      style: AppStyles.blackTextStyle,
                      decoration: InputDecoration(
                          focusColor: AppColors.appBlue,
                          hintText: Strings.province,
                          hintStyle: AppStyles.greyTextStyle,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0),)
                      )
                  ),
                  SizedBox(height: 25,),
                  AppButton(
                    text: Strings.register,
                    enabled: viewModel.enableRegisterButton,
                    onPressed: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      viewModel.onClickRegister(context, _registrationKey);
                    },
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
