import 'package:flutter/material.dart';

final Color primaryGrey = HexColor.fromHex('#515961');
final secondaryGrey = HexColor.fromHex('#DBDBDB');
final Color primaryOrange = HexColor.fromHex('#E9AB33');
final Color primary = HexColor.fromHex('#07C8B9');
final Color grey = HexColor.fromHex('#5e6d77');
final Color titleBlack = HexColor.fromHex('#1a2b50');
final Color footerBg = HexColor.fromHex('#f5f5f5');
final Color likedRed = HexColor.fromHex('#EB8F90');
final Color titleBlue = HexColor.fromHex('#1a2b48');
final Color facebookColor = HexColor.fromHex("#395899");
final Color googleColor = HexColor.fromHex("#f34a38");
final Color signinkid = HexColor.fromHex("#00a3b9");
final Color signup = HexColor.fromHex("#0caaa2");
final Color links = HexColor.fromHex("#ec892b");
final Color button = HexColor.fromHex("#0eaea3");

const MaterialColor materialPrimary = MaterialColor(
  0xFF050301,
  <int, Color>{
    50: Color(0xFF050301),
    100: Color(0xFFFAFAFA),
    200: Color(0xFFF5F5F5),
    300: Color(0xFFEEEEEE),
    400: Color(0xFFE0E0E0),
    500: Color(0xFFBDBDBD),
    600: Color(0xFF9E9E9E),
    700: Color(0xFF757575),
    800: Color(0xFF616161),
    900: Color(0xFF212121),
  },
);

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
