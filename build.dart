import 'dart:io';
import 'package:path/path.dart' as path;

void main() {
  var zip = '';

  if (isBinaryInPath('7z')) zip = ',zip';

  if (Platform.isWindows) {
    packager('windows', 'msix$zip', true, false);
  } else if (Platform.isMacOS) {
    packager('macos', 'dmg$zip', true, true);
  } else if (Platform.isLinux) {
    var appimage = '';
    if (isBinaryInPath('appimagetool')) appimage = ',appimage';
    packager('linux', "deb,rpm$appimage$zip", true, false);
  } else {
    stderr.writeln('Sorry your platform is not supported');
    exit(0);
  }
}

bool isBinaryInPath(String binary) {
  for (var path in Platform.environment['PATH']!.split(':')) {
    if (Directory(path).existsSync()) {
      for (var file in Directory(path).listSync()) {
        if (file.path
                .substring(file.path.lastIndexOf(Platform.pathSeparator) + 1) ==
            binary) {
          return true;
        }
      }
    }
  }
  return false;
}

void packager(String os, String platPackages, bool android, bool ios) {
  if (android) {
    stdout.write(
        'Should android packages (.apk and .appbundle) be built? (y/N) ');
    if ((stdin.readLineSync(retainNewlines: false) ?? 'n').toLowerCase() ==
        'y') {
      builder('android', 'apk,aab');
      mover();
    }
  }
  if (ios) {
    stdout.write('Should an ios package (.ipa) be built? (y/N) ');
    if ((stdin.readLineSync(retainNewlines: false) ?? 'n').toLowerCase() ==
        'y') {
      builder('ios', 'ipa');
      mover();
    }
  }
  builder(os, platPackages);
  mover();
}

void mover() {
  var dist = Directory('dist');
  var target = Directory('target');
  target.createSync();

  for (var file in dist.listSync(recursive: true)) {
    if (file is File) {
      file.renameSync(
          '${target.path}${Platform.pathSeparator}${path.basename(file.path)}');
    }
  }
}

var basename = 'flutter_distributor';
var home = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];

void builder(String os, String targets) {
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

  stdout.writeln('Packaging ${targets.split(',')} for $os');
  var res = Process.runSync(
      bin, <String>['package', '--platform', os, '--targets', targets]);
  if (res.exitCode == 0) {
    stdout.writeln('Successfully built $os package(s) in folder target');
  } else {
    stderr.writeln('Error: ${res.stderr} with exit code ${res.exitCode}');
  }
}
