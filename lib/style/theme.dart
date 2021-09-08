import 'package:flutter/cupertino.dart';

class MyColors {
  const MyColors();
  static const Color mainColor = const Color(0XFFCE0000);
  static const Color grey = const Color(0xffe5e5e5);
  static const primaryGradient = const LinearGradient(
    colors: const [Color(0xFFec2727), Color(0xFFf05555)],
    stops: const [0.0, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
