import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageHelper{

  static Widget getPng(String image,
      {double width,
        double height,
        BoxFit fit = BoxFit.contain,
        Alignment alignment = Alignment.center, Key key}){
    String assetPath = "assets/images/$image.png";

    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      key: key,
    );
  }

  static Widget getSvg(String image,
      {double width,
        double height,
        Color color,
        BoxFit fit = BoxFit.contain,
        Alignment alignment = Alignment.center, Key key}){

    String assetPath = "assets/svg/$image.svg";

    return SvgPicture.asset(
        assetPath,
        color: color,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        key: key,
    );

  }

  static Widget getNetworkImage(String url,
      {double width,
        double height,
        BoxFit fit = BoxFit.contain,
        Alignment alignment = Alignment.center}){

    return Image.network(url,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
    );
  }
}