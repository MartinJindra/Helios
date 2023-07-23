import 'dart:io';
import 'package:file_picker/file_picker.dart'
    show FilePicker, FilePickerResult, FileType;
import 'package:flutter/material.dart'
    show
        AppBar,
        Brightness,
        BuildContext,
        Builder,
        Center,
        Colors,
        GlobalKey,
        Icon,
        IconButton,
        Icons,
        MaterialApp,
        Scaffold,
        ScaffoldState,
        State,
        StatefulWidget,
        Text,
        ThemeData,
        Widget;
import 'package:flutter_markdown/flutter_markdown.dart' show Markdown;
import 'package:helios/dnd/character/parser/parser.dart' show Parser;
import 'package:xml/xml.dart' show XmlTagException;
import 'package:helios/util/snacks.dart' as snacks;
import 'package:helios/util/strings.dart' as strings;

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<StatefulWidget> createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  final globalKey = GlobalKey<ScaffoldState>();

  String character = 'Helios', data = '';

  void processFile() {
    void parseFile(String file) {
      if (file.isNotEmpty && file.endsWith('.dnd5e')) {
        try {
          Parser par = Parser(file);
          par.parse();
          setState(() {
            character = strings.basename(file);
            data = par.character.toString();
          });
        } on XmlTagException catch (xe) {
          snacks.showSnackBar(context, xe.message);
        }
      } else if (file.isEmpty) {
        snacks.showSnackBar(context, 'No file selected.');
      } else {
        snacks.showSnackBar(context, '\'$file\' is invalid.');
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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: Builder(builder: (BuildContext context) {
          return Scaffold(
            key: globalKey,
            appBar: AppBar(
                title: Text(character),
                backgroundColor: Colors.deepOrange,
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.file_open),
                    tooltip: 'Open file',
                    onPressed: () {
                      processFile();
                    },
                  )
                ]),
            body: Center(
              child: Markdown(data: data),
            ),
          );
        }));
  }
}
