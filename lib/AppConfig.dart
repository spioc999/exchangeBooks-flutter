import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget{

  ///Construttore
  AppConfig({
    @required this.appName,
    @required this.apiHostUrl,
    @required this.clientId,
    @required this.clientSecret,
    @required this.googleApiKey,
    @required Widget child
  }) : super(child: child);


  final String appName;
  final String apiHostUrl;
  final String clientId;
  final String clientSecret;
  final String googleApiKey;

  /// Questo restituisce solo false, perchè il nostro AppConfig non cambierà
  /// mai dopo averlo creato.
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  /// Accesso ad AppConfiguration
  static AppConfig of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<AppConfig>();


}