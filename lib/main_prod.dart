import 'dart:async';

import 'package:app_task/config.dart';
import 'package:app_task/src/core/app.dart';

Future<void> main() async {
  Config.appFlavor = Production();
  await initApp();
}
