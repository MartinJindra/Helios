import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:helios/dnd/character/parser/parser.dart';
import 'package:xml/xml.dart';
import 'package:helios/util/snacks.dart' as util;

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
        home: Builder(builder: (BuildContext context) {
          return Scaffold(
            key: globalKey,
            appBar: AppBar(
                title: const Text('Helios'),
                backgroundColor: Colors.deepOrange,
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.file_open),
                    tooltip: 'Open file',
                    onPressed: () {
                      void parseFile(String file) {
                        if (file.isNotEmpty && file.endsWith('.dnd5e')) {
                          try {
                            Parser par = Parser(file);
                            par.parse();
                            textController.text = par.character.toString();
                          } on XmlTagException catch (xe) {
                            util.showSnackBar(context, xe.message);
                          }
                        } else if (file.isEmpty) {
                          util.showSnackBar(context, 'No file selected.');
                        } else {
                          util.showSnackBar(context, '\'$file\' is invalid.');
                        }
                      }

                      FileType fileType;
                      List<String> extensions;
                      if (Platform.isAndroid || Platform.isIOS) {
                        fileType = FileType.any;
                        extensions = [];
                      } else {
                        fileType = FileType.custom;
                        extensions = ['dnd5e'];
                      }
                      FilePicker.platform
                          .pickFiles(
                        type: fileType,
                        allowedExtensions: extensions,
                      )
                          .then((FilePickerResult? file) {
                        parseFile(file?.files.single.path ?? '');
                      });
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
          );
        }));
  }
}
