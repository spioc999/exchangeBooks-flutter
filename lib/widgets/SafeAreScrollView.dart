import 'package:flutter/material.dart';

class SafeAreaScrollView extends StatelessWidget {
  final Widget child;
  final bool shouldSroll;

  SafeAreaScrollView({@required this.child, this.shouldSroll = true});

  @override
  Widget build(BuildContext context) {

    if(shouldSroll){
      return SingleChildScrollView(
        child: SafeArea(
            bottom: true,
            child: child),
      );
    }

    return SafeArea(
        bottom: true,
        child: child);

  }
}