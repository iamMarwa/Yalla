import 'package:flutter/material.dart';

class AdvancedSearchItem extends StatelessWidget {
  final Color colorTop, colorBottom, textColor;
  final String title;
  final double width;

  AdvancedSearchItem(
      {this.colorTop,
      this.colorBottom,
      this.title,
      this.textColor,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 130.0,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.black12)],
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        gradient: LinearGradient(
            colors: [colorTop, colorBottom],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: textColor ?? Colors.white,
              fontFamily: "Sofia",
              fontSize: 18.0),
        ),
      ),
    );
  }
}

class HexColor extends Color {
  static int getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(getColorFromHex(hexColor));
}

