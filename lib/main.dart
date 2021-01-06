import 'dart:ui';

import 'package:exchange_books/ExchangeBooksApp.dart';
import 'package:exchange_books/routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

import 'AppConfig.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await DotEnv.load(fileName: ".env");

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  while (window.locale == null) {
    await Future.delayed(const Duration(milliseconds: 1));
  }

  var configuredApp = getConfig(ExchangeBooksApp());
  Routes.createRoutes();

  runApp(
    MultiProvider(
        providers: [RouteObserverProvider()],
        child: configuredApp )
  );
}


AppConfig getConfig(Widget child){

  String apiHostUrl = env['API_HOST_URL'];
  String clientId = env['CLIENT_ID'];
  String clientSecret = env['CLIENT_SECRET'];
  String googleApiKey = env['GOOGLE_API_KEY'];

  return AppConfig(
      appName: "ExchangeBooks",
      apiHostUrl: apiHostUrl,
      clientId: clientId,
      clientSecret: clientSecret,
      googleApiKey: googleApiKey,
      child: child);
}