import 'package:flutter/material.dart' show runApp;
import 'package:helios/view/mainview.dart' show MainView;
import 'package:get_storage/get_storage.dart' show GetStorage;

void main() {
  GetStorage.init().then((bool hasStarted) {
    if (hasStarted) runApp(const MainView());
  });
}
