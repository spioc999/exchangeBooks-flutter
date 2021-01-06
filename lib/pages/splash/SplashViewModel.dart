import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:exchange_books/AppConfig.dart';
import 'package:exchange_books/base/BaseViewModel.dart';
import 'package:exchange_books/data_managers/DataManager.dart';
import 'package:exchange_books/models/AppAlertModel.dart';
import 'package:exchange_books/routes/Routes.dart';
import 'package:exchange_books/values/Strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:sailor/sailor.dart';

class SplashViewModel extends BaseViewModel{

  void init(BuildContext context) async{

    await Future.delayed(Duration(milliseconds: 1500));

    var connectivityResult = await Connectivity().checkConnectivity();

    if(connectivityResult == ConnectivityResult.none){

      showAlert(Strings.noConnectivityTitle, Strings.noConnectivityMessage, AlertType.error);

    }else{

      DataManager dm = DataManager();

      //if there is a token, user not logged out. Otherwise go to login
      var token = await dm.managerUser.getBearerToken();

      if(token.response != null){

        //Get user's credentials in cache and try to login automatically
        var email = await dm.managerUser.getSavedEmail();
        var psw = await dm.managerUser.getSavedPassword();

        if(email.response != null && psw.response != null){

          this.showProgress();

          var dmr = await dm.managerUser.login(
              AppConfig.of(context).apiHostUrl,
              AppConfig.of(context).clientId,
              AppConfig.of(context).clientSecret,
              email: email.response,
              psw: psw.response);

          this.dismissProgress();

          if(dmr.hasError()){

            Routes.sailor.navigate(Routes.login,
                navigationType: NavigationType.pushReplace);

          }else{

            if(dmr.response.result.user != null && dmr.response.result.bearerToken != null){

              //Save the result in cache
              var dmrUser = await dm.managerUser.saveCurrentUser(dmr.response.result.user);
              var dmrToken = await dm.managerUser.saveBearerToken(dmr.response.result.bearerToken);

              if(dmrUser.hasError() || dmrToken.hasError()){

                Routes.sailor.navigate(Routes.login,
                    navigationType: NavigationType.pushReplace);

              }else{

                Routes.sailor.navigate(Routes.home,
                  navigationType: NavigationType.pushReplace);

              }

            }else{

              Routes.sailor.navigate(Routes.login,
                  navigationType: NavigationType.pushReplace);

            }

          }

        }else{
          Routes.sailor.navigate(Routes.login,
              navigationType: NavigationType.pushReplace);
        }

      }else {
        //user has logged out so login

        Routes.sailor.navigate(Routes.login,
            navigationType: NavigationType.pushReplace);
        
      }

    }
  }
}