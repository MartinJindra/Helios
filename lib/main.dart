import 'package:flutter/material.dart' show runApp;
import 'package:helios/view/mainview.dart' show MainView;
import 'package:get_storage/get_storage.dart' show GetStorage;

void main() async {
  await GetStorage.init();
  runApp(const MainView());
}
