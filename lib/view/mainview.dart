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
        IconData,
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
import 'package:get_storage/get_storage.dart' show GetStorage;
import 'package:helios/dnd/character/parser.dart' show Parser;
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
  final box = GetStorage();

  String character = 'Helios', data = '';

  Brightness theme = Brightness.light;
  IconData themeIcon = Icons.light_mode_sharp;

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

  void switchTheme() {
    switch (theme) {
      case Brightness.light:
        box.write('theme', 'dark');
        setState(() {
          theme = Brightness.dark;
          themeIcon = Icons.dark_mode_sharp;
        });
        break;
      case Brightness.dark:
        box.write('theme', 'light');
        setState(() {
          theme = Brightness.light;
          themeIcon = Icons.light_mode_sharp;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if ((box.read('theme') ?? 'light') == 'light') {
      setState(() {
        theme = Brightness.light;
        themeIcon = Icons.light_mode_sharp;
      });
    } else {
      setState(() {
        theme = Brightness.dark;
        themeIcon = Icons.dark_mode_sharp;
      });
    }

    return MaterialApp(
        theme: ThemeData(
          brightness: theme,
        ),
        home: Builder(builder: (BuildContext context) {
          return Scaffold(
            key: globalKey,
            appBar: AppBar(
                title: Text(character),
                backgroundColor: Colors.deepOrange,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(themeIcon),
                    onPressed: () => switchTheme(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.file_open_sharp),
                    tooltip: 'Open file',
                    onPressed: () => processFile(),
                  )
                ]),
            body: Center(
              child: Markdown(data: data),
            ),
          );
        }));
  }
}
