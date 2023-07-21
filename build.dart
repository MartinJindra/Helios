import 'dart:io';

void main(List<String> args) {
  if (Platform.isWindows) {
    package('windows', 'msix');
  } else if (Platform.isMacOS) {
    package('macos', 'dmg');
  } else if (Platform.isLinux) {
    package('linux', 'rpm,appimage');
  }
}

var basename = 'flutter_distributor';
var home = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];

void package(String os, String targets) {
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
        'Dart package $basename is not globally installed.\nInstall with `dart pub global activate flutter_distributor`');
    exit(1);
  }
  var res = Process.runSync(
      bin, <String>['package', '--platform', os, '--targets', targets]);
  if (res.exitCode == 0) {
    stdout.writeln('Successfully built package in folder dist');
  }
}
