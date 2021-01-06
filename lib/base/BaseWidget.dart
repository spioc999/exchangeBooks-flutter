import 'package:exchange_books/values/Strings.dart';
import 'package:exchange_books/models/AppAlertModel.dart';
import 'package:exchange_books/widgets/button/AppButton.dart';
import 'package:exchange_books/widgets/text/BoldText.dart';
import 'package:exchange_books/widgets/text/RegularText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseWidget extends StatefulWidget {
  final Widget body;
  final Widget header;
  final double headerHeight;
  final bool progress;
  final AppAlertModel alert;
  final SystemUiOverlayStyle statusBarColor;
  final Color color;
  final bool safeAreaTop;
  final bool safeAreaBottom;
  final Widget floatingActionButton;

  BaseWidget(
      {this.header,
        this.body,
        this.headerHeight = 50,
        this.progress = false,
        this.alert,
        this.statusBarColor = SystemUiOverlayStyle.dark,
        this.color = Colors.white,
        this.safeAreaBottom = false,
        this.safeAreaTop = true,
        this.floatingActionButton
      });


  @override
  _BaseWidgetState createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> with WidgetsBindingObserver{

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: widget.statusBarColor,
        child: Scaffold(
          floatingActionButton: widget.floatingActionButton ?? IgnorePointer(),
          backgroundColor: widget.color,
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: <Widget>[
              SafeArea(
                top: widget.safeAreaTop,
                bottom: widget.safeAreaBottom,
                child: Stack(
                  children: [
                    widget.header ?? IgnorePointer(),
                    Padding(
                      padding: EdgeInsets.only(top: widget.headerHeight,bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: widget.body,
                    ),
                  ],
                ),
              ),
              _buildLoader(),
              _buildAlert(context),
            ],
          ),
        ),
    );
  }

  Widget _buildAlert(BuildContext context) {
    if (widget.alert != null) {
      return Stack(
        children: [
          Container(
          color: Colors.black26,
          height: double.infinity,
          width: double.infinity,),
          AlertDialog(
              title: BoldText(widget.alert.title),
              content:Container(
                height: 120,
                child: Column(
                  children: <Widget>[
                    RegularText(widget.alert.message, maxLines: 4,),
                    Container(height: 40,),
                    AppButton(
                      text: Strings.ok,
                      onPressed: widget.alert.onClose,
                    )
                  ],
                ),
              )),
        ],
      );
    } else {
      return IgnorePointer();
    }
  }

  Widget _buildLoader() {
    if (widget.progress) {
      return Container(
          color: Colors.black26,
          height: double.infinity,
          width: double.infinity,
          child: Center(child: CircularProgressIndicator()));
    } else {
      return IgnorePointer();
    }
  }

}
