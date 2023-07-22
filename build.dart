import 'dart:io';

void main() {
  if (Platform.isWindows) {
    packager('windows', 'msix,zip', true, false);
  } else if (Platform.isMacOS) {
    packager('macos', 'dmg,zip', true, true);
  } else if (Platform.isLinux) {
    var targets = 'deb,rpm,zip';
    if (isBinaryInPath('appimagetool')) {
      targets += ',appimage';
    }
    packager('linux', targets, true, false);
  } else {
    stderr.writeln('Sorry your platform is not supported');
    exit(0);
  }
}

bool isBinaryInPath(String binary) {
  for (var path in Platform.environment['PATH']!.split(':')) {
    for (var file in Directory(path).listSync()) {
      if (file.path
              .substring(file.path.lastIndexOf(Platform.pathSeparator) + 1) ==
          binary) {
        return true;
      }
    }
  }
  return false;
}

void packager(String os, String platPackages, bool android, bool ios) {
  if (android) {
    stdout.write(
        'Should android packages (.apk and .appbundle) be built? (y/N) ');
    var yes = stdin.readLineSync(retainNewlines: false) ?? 'n';
    if (yes.toLowerCase() == 'y') platPackages += ',apk,aab';
  }
  if (ios) {
    stdout.write('Should an ios package (.ipa) be built? (y/N) ');
    var yes = stdin.readLineSync(retainNewlines: false) ?? 'n';
    if (yes.toLowerCase() == 'y') platPackages += ',ipa';
  }
  builder(os, platPackages);
}

var basename = 'flutter_distributor';
var home = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];

void builder(String os, String targets) {
  var dest = Directory('dist');
  if (dest.existsSync()) dest.deleteSync(recursive: true);

  var bin = '$home';
  if (os == 'linux' || os == 'macos') {
    bin += '/.pub-cache/bin/$basename';
  } else if (os == 'windows') {
    bin += '\\AppData\\Local\\Pub\\Cache\\bin\\$basename.bat';
  }

  if (!File(bin).existsSync()) {
    stderr.writeln(
        'Dart package $basename is not globally installed.\nInstall with `dart pub global activate flutter_distributor` and run `dart build.dart` again.');
    exit(1);
  }
  stdout.writeln('Packaging ${targets.split(',')} for $os');
  var res = Process.runSync(
      bin, <String>['package', '--platform', os, '--targets', targets]);
  if (res.exitCode == 0) {
    stdout.writeln('Successfully built package(s) in folder dist');
  } else {
    stderr.writeln('Error: ${res.stderr} with exit code ${res.exitCode}');
  }
}
