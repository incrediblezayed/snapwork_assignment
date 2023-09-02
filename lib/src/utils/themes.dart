import 'package:flutter/cupertino.dart';

class AppTheme {
  static const _primaryColor = Color(0xFF215187);

  static CupertinoThemeData get theme => const CupertinoThemeData(
        primaryColor: _primaryColor,
        barBackgroundColor: _primaryColor,
        textTheme: CupertinoTextThemeData(
          navTitleTextStyle: TextStyle(color: CupertinoColors.white),
          actionTextStyle: TextStyle(color: CupertinoColors.white),
          navActionTextStyle: TextStyle(color: CupertinoColors.white),
        ),
      );
  static const dividerColor = Color.fromARGB(255, 221, 221, 223);
  static const verticleDividerColor = Color.fromARGB(255, 187, 187, 187);
}
