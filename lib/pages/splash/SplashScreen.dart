import 'package:exchange_books/base/BaseWidget.dart';
import 'package:exchange_books/helpers/ImageHelper.dart';
import 'package:exchange_books/pages/splash/SplashViewModel.dart';
import 'package:exchange_books/values/Strings.dart';
import 'package:exchange_books/widgets/text/BoldText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver{

  SplashViewModel viewModel;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {

    viewModel = Provider.of<SplashViewModel>(context);

    return BaseWidget(
      progress: viewModel.progress,
      alert: viewModel.alert,
      safeAreaTop: false,
      color: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
            )
          ),
          Center(
            child: ImageHelper.getPng("logo"),
          ),
          SafeArea(
            bottom: true,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: BoldText(
                      Strings.initialsSPC,
                      fontSize: 12,
                      color: Colors.black,
                    )
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
