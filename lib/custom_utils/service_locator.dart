import 'package:flutter_inline_dialogs_app/dialogs/service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();

void dialogSetupLocator() {
  locator.registerSingleton(DialogService());
}
