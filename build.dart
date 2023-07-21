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
var home = Platform.environment['HOME'];

bool checkDistributor(var path) {
  return File('$path${Platform.pathSeparator}$basename').existsSync();
}

void package(String os, String targets) {
  var dest = Directory('dist');
  if (dest.existsSync()) dest.deleteSync(recursive: true);

  var pubcache = '$home';
  if (os == 'linux' || os == 'macos') {
    pubcache += '/.pub-cache/bin';
  } else if (os == 'windows') {
    pubcache += '\\AppData\\Local\\Pub\\Cache\\bin\\';
  }

  if (!checkDistributor(pubcache)) {
    stderr.writeln(
        'Dart package $basename is not globally installed.\nInstall with `dart pub global activate flutter_distributor`');
    exit(1);
  }
  var res = Process.runSync('$pubcache${Platform.pathSeparator}$basename',
      <String>['package', '--platform', os, '--targets', targets]);
  if (res.exitCode == 0) {
    stdout.writeln('Successfully built package in folder dist');
  }
}
