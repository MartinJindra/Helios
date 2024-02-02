#!/usr/bin/env dart

import 'dart:io';

enum OS { android, ios, windows, macos, linux }

void main() {
  var zip = '';

  if (isBinaryInPath('7z') || isBinaryInPath('7z.exe')) zip = ',zip';

  if (Platform.isWindows) {
    packager(OS.windows, 'msix$zip');
  } else if (Platform.isMacOS) {
    packager(OS.macos, 'dmg$zip', ios: true);
  } else if (Platform.isLinux) {
    var appimage = '';
    if (isBinaryInPath('appimagetool')) appimage = ',appimage';
    packager(OS.linux, "deb,rpm$appimage$zip");
  } else {
    stderr.writeln('Sorry your platform is not supported');
    exit(0);
  }
}

String fileName(String path) {
  return path.substring(path.lastIndexOf(Platform.pathSeparator) + 1);
}

bool isBinaryInPath(String binary) {
  for (var path in Platform.environment['PATH']!.split(':')) {
    if (Directory(path).existsSync()) {
      for (var file in Directory(path).listSync()) {
        if (fileName(file.path) == binary) {
          return true;
        }
      }
    }
  }
  return false;
}

void packager(OS os, String platfPackages, {bool ios = false}) {
  stdout
      .write('Should android packages (.apk and .appbundle) be built? (y/N) ');
  if ((stdin.readLineSync(retainNewlines: false) ?? 'n').toLowerCase() == 'y') {
    builder(OS.android, 'apk,aab');
    mover();
  }

  if (ios) {
    stdout.write('Should an ios package (.ipa) be built? (y/N) ');
    if ((stdin.readLineSync(retainNewlines: false) ?? 'n').toLowerCase() ==
        'y') {
      builder(OS.ios, 'ipa');
      mover();
    }
  }
  builder(os, platfPackages);
  mover();
}

void mover() {
  var dist = Directory('dist');
  var target = Directory('target');
  target.createSync();

  for (var file in dist.listSync(recursive: true)) {
    if (file is File) {
      file.renameSync(
          '${target.path}${Platform.pathSeparator}${fileName(file.path)}');
    }
  }
  // clean up
  dist.deleteSync(recursive: true);
}

const basename = 'flutter_distributor';
var home = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];

void builder(OS os, String targets) {
  var addArgs = [];
  var bin = '$home';
  if (Platform.isLinux || Platform.isMacOS) {
    bin += '/.pub-cache/bin/$basename';
  } else if (Platform.isWindows) {
    bin += '\\AppData\\Local\\Pub\\Cache\\bin\\$basename.bat';
  }

  if (!File(bin).existsSync()) {
    stderr.writeln(
        'Dart package $basename is not globally installed.\nInstall with `dart pub global activate flutter_distributor` and run `dart build.dart` again.');
    exit(1);
  }

  var dest = Directory('dist');
  if (dest.existsSync()) dest.deleteSync(recursive: true);

  switch (os) {
    case OS.ios:
      addArgs.add('--build-export-options-plist=ios/exportOptions.plist');
      break;
    default:
  }

  stdout.writeln('Packaging ${targets.split(',')} for ${os.name}');

  var res = Process.runSync(bin, <String>[
    '--no-version-check',
    'package',
    '--platform',
    os.name,
    '--targets',
    targets,
    addArgs.join(' '),
  ]);
  if (res.exitCode == 0) {
    stdout.writeln('Successfully built ${os.name} package(s) in folder target');
  } else {
    stderr.writeln('Error: ${res.stderr} with exit code ${res.exitCode}');
  }
}
