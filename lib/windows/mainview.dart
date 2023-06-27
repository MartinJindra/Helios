import 'package:file_picker/file_picker.dart'
    show FilePicker, FilePickerResult, FileType;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show AppBar, Brightness, BuildContext, Center, Colors, GlobalKey, Icon, IconButton, Icons, InputDecoration, MaterialApp, Scaffold, ScaffoldState, StatelessWidget, Text, TextEditingController, TextField, TextInputType, ThemeData, Widget;
import 'package:helios/dnd/character/parser/parser.dart';

class MainView extends StatelessWidget {
  final textController = TextEditingController();
  final globalKey = GlobalKey<ScaffoldState>();

  MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Helios',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        backgroundColor: Colors.transparent,
        key: globalKey,
        appBar: AppBar(
            title: const Text('Helios'),
            actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.file_open),
            tooltip: 'Open file',
            onPressed: () async {
              FilePickerResult? file = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['dnd5e'],
              );
              if (file != null) {
                Parser par = Parser(file.files.single.path!);
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
                contentPadding: EdgeInsets.all(5),
              )),
        ),
      ),
    );
  }
}