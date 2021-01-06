import 'package:exchange_books/pages/splash/SplashScreen.dart';
import 'package:exchange_books/pages/splash/SplashViewModel.dart';
import 'package:exchange_books/routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

import 'AppConfig.dart';

class ExchangeBooksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Call AppConfig.of(context) anywhere to obtain the configuration
    var config = AppConfig.of(context);

    return MaterialApp(
      title: config.appName,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [RouteObserverProvider.of(context)],
      navigatorKey: Routes.sailor.navigatorKey,
      onGenerateRoute: Routes.sailor.generator(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<SplashViewModel>(
        create: (_) => SplashViewModel(), child: SplashScreen(),
      ),
    );
  }
}
