import 'dart:io';

import 'package:flutter/material.dart'
    show
        AppBar,
        Brightness,
        BuildContext,
        Center,
        Color,
        Colors,
        EdgeInsets,
        GlobalKey,
        Icon,
        IconButton,
        Icons,
        InputDecoration,
        MaterialApp,
        Scaffold,
        ScaffoldState,
        StatelessWidget,
        Text,
        TextEditingController,
        TextField,
        TextInputType,
        ThemeData,
        Widget;
import 'package:helios/dnd/character/parser/parser.dart';
import 'package:helios/util/file.dart' as util;

class MainView extends StatelessWidget {
  final textController = TextEditingController();
  final globalKey = GlobalKey<ScaffoldState>();

  MainView({super.key});

  @override
  Widget build(BuildContext context) {
    Color? background;
    if (Platform.isWindows) {
      background = Colors.transparent;
    }

    return MaterialApp(
      title: 'Helios',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        backgroundColor: background,
        key: globalKey,
        appBar: AppBar(title: const Text('Helios'), actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.file_open),
            tooltip: 'Open file',
            onPressed: () async {
              String file = await util.openFilePicker();
              if (file.isNotEmpty && file.endsWith('.dnd5e')) {
                Parser par = Parser(file);
                par.parse();
                textController.text = par.character.toString();
              }
            },
          )
        ]),
        body: Center(
          child: TextField(
              readOnly: true,
              controller: textController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              expands: true,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(10),
              )),
        ),
      ),
    );
  }
}
