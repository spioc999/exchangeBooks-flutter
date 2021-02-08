import 'package:exchange_books/helpers/ImageHelper.dart';
import 'package:exchange_books/routes/Routes.dart';
import 'package:exchange_books/values/AppColors.dart';
import 'package:exchange_books/values/ExchangeBooksValueKey.dart';
import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {

  final bool isHomePage;
  final Widget rightWidget;
  final VoidCallback onLeftIconPressed;


  AppHeader({this.isHomePage = false, this.rightWidget, this.onLeftIconPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      padding: const EdgeInsets.only(right: 15, left: 5),
      child: Padding(
        padding: isHomePage ? EdgeInsets.only(top: 10, left: 7) : EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: isHomePage ? 50 : 44,
              height: isHomePage ? 50 : 44,
              child: Center(
                child: InkWell(
                  child: Padding(
                    padding: isHomePage ? EdgeInsets.only(bottom: 3) : EdgeInsets.all(10),
                    child: _createLeftIcon()
                  ),
                  onTap: (){
                    if(onLeftIconPressed != null){
                      onLeftIconPressed();
                    }else{
                      Routes.sailor.pop();
                    }
                  },
                ),
              ),
            ),
            Expanded(child: Container()),
            _createRightWidget()
          ],
        ),
      ),
    );
    
  }

  Widget _createRightWidget() {
    if (this.rightWidget != null) {
      return this.rightWidget;
    } else {
      return Container(
        width: 44,
        height: 44,
      );
    }
  }

  Widget _createLeftIcon() {
    if(isHomePage){
      return ImageHelper.getPng("logo_blank_half", key: ValueKey(ExchangeBooksValueKey.infoButtonHome));
    }else{
      return Icon(Icons.arrow_back_ios_rounded, color: AppColors.appBlue, key: ValueKey(ExchangeBooksValueKey.back),);
    }
  }
}
