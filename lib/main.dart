import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:helios/view/mainview.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    // only apply Aero theming on Windows.
    await Window.initialize();
    await Window.setEffect(
      effect: WindowEffect.aero,
      color: Colors.black.withOpacity(0.6),
    );
  }
  runApp(MainView());
  //ArgResults parsedArgs = Parser.parse(args);
  //if (parsedArgs.arguments.isNotEmpty) Runner.run(parsedArgs);
}
