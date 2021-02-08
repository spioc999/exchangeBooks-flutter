import 'package:exchange_books/base/BaseWidget.dart';
import 'package:exchange_books/helpers/ImageHelper.dart';
import 'package:exchange_books/pages/login/LoginViewModel.dart';
import 'package:exchange_books/values/AppColors.dart';
import 'package:exchange_books/values/AppStyles.dart';
import 'package:exchange_books/values/ExchangeBooksValueKey.dart';
import 'package:exchange_books/values/Strings.dart';
import 'package:exchange_books/widgets/SafeAreScrollView.dart';
import 'package:exchange_books/widgets/button/AppButton.dart';
import 'package:exchange_books/widgets/text/BoldText.dart';
import 'package:exchange_books/widgets/text/RegularText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver{

  LoginViewModel viewModel;

  final FocusScopeNode _node = FocusScopeNode();
  GlobalKey<FormState> _loginKey;

  @override
  void initState() {
    super.initState();
    _loginKey = GlobalKey<FormState>();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.init(context);
    });
  }


  @override
  void dispose() {
    _loginKey = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    viewModel = Provider.of<LoginViewModel>(context);

    return BaseWidget(
      progress: viewModel.progress,
      alert: viewModel.alert,
      safeAreaTop: true,
      safeAreaBottom: true,
      color: Colors.white,
      body: SafeAreaScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _loginKey,
            autovalidateMode: viewModel.autovalidate ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
            child: FocusScope(
              node: _node,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 0, width: double.infinity,),
                  ImageHelper.getPng("logo_without_subtitle", height: 170),
                  SizedBox(height: 8,),
                  BoldText(Strings.login, fontSize: 25,),
                  SizedBox(height: 15,),
                  TextFormField(
                    key: ValueKey(ExchangeBooksValueKey.emailTextFieldLogin),
                    autocorrect: false,
                    controller: viewModel.emailController,
                    style: AppStyles.blackTextStyle,
                    validator: (String email){
                      return viewModel.validateEmail(email);
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    onEditingComplete: () => _node.nextFocus(),
                    decoration: InputDecoration(
                      errorStyle: AppStyles.errorTextStyle,
                      focusColor: AppColors.appBlue,
                      hintText: Strings.email,
                      hintStyle: AppStyles.greyTextStyle,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0),)
                    ),
                    onChanged: (newValue) {
                      viewModel.onChangeEmail(newValue, _loginKey);
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    key: ValueKey(ExchangeBooksValueKey.passwordTextFieldLogin),
                    controller: viewModel.pswController,
                    obscureText: viewModel.obscurePassword,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () => _node.unfocus(),
                    autocorrect: false,
                    style: AppStyles.blackTextStyle,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      focusColor: AppColors.appBlue,
                      suffixIcon: InkWell(
                        child: Icon(viewModel.obscurePassword ? Icons.visibility : Icons.visibility_off, key: ValueKey(ExchangeBooksValueKey.showPasswordButtonLogin),),
                        onTap: () {viewModel.toggleObscurePassword();},
                      ),
                      hintText: Strings.password,
                      hintStyle: AppStyles.greyTextStyle,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0),)
                    ),
                    onChanged: (newValue) {
                      viewModel.onChangePassword(newValue);
                    },
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RegularText(Strings.rememberMe),
                      Flexible(
                        child: Checkbox(
                          value: viewModel.rememberMe,
                          onChanged: (newValue) { viewModel.onChangeRememberMe(newValue);},
                          activeColor: AppColors.appBlue,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  AppButton(
                    key: ValueKey(ExchangeBooksValueKey.loginButton),
                    text: Strings.singIn,
                    enabled: viewModel.enableLogin,
                    onPressed: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      viewModel.onClickSignIn(context, _loginKey);
                    },
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    key: ValueKey(ExchangeBooksValueKey.registerButton),
                    child: Padding(
                      padding: EdgeInsets.all(7),
                      child: BoldText(
                        Strings.register,
                        color: AppColors.appBlue,
                        fontSize: 15,
                      ),
                    ),
                    onTap: (){
                      FocusScope.of(context).requestFocus(new FocusNode());
                      viewModel.goToRegister();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
