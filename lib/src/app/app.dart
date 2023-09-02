import 'package:flutter/cupertino.dart';
import 'package:snapwork_assignment/src/utils/routes.dart';
import 'package:snapwork_assignment/src/utils/themes.dart';

class AssignmentApp extends StatelessWidget {
  const AssignmentApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: AppTheme.theme,
      onGenerateRoute: Routes.onGenerateRoute,
      initialRoute: Routes.events,
    );
  }
}
