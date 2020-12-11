import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor, String alpha) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = '$alpha$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor, {String alpha})
      : super(_getColorFromHex(hexColor, alpha == null ? 'FF' : alpha));
}
