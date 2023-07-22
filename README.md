# Helios

A simple project to create a DND character builder.

Your question may be "Why build a new character builder when Aurora is available?".

Because it is unmaintained, not opensource and not cross-platform.

So I want to build Helios. A sibling to Aurora.

## Building

This program is written with Flutter.

So to build this project follow instructions
on [flutter.dev](https://docs.flutter.dev/get-started/install).

To build a package for distribution [flutter_distributor](https://distributor.leanflutter.org) is used.

Install the packager globally

```
dart pub global activate flutter_distributor
```

A simple build [script](./build.dart) can be used.

```
dart build.dart
```

Or build it manually.

### Windows

`flutter_distributor.bat` is in [$HOME\AppData\Local\Pub\Cache\bin\]($HOME\AppData\Local\Pub\Cache\bin\).

**msix**

`flutter_distributor package --platform windows --targets msix`

Binary will be in [$PWD\dist\1.0.0+1\helios-1.0.0+1-windows.msix]($PWD\dist\1.0.0+1\helios-1.0.0+1-windows.msix).

### Mac

`flutter_distributor` is in [~/.pub-cache/bin/](~/.pub-cache/bin/).

**dmg**

`flutter_distributor package --platform macos --targets dmg`

Binary will be in [$PWD/dist/1.0.0+1/helios-1.0.0+1-macos.dmg]($PWD/dist/1.0.0+1/helios-1.0.0+1-macos.dmg).

### Linux

`flutter_distributor` is in [~/.pub-cache/bin/](~/.pub-cache/bin/).

**rpm**

Install dependencies:

- Debian/Ubuntu: apt install rpm patchelf
- Fedora: dnf install gcc rpm-build rpm-devel rpmlint make python bash coreutils diffutils patch rpmdevtools patchelf
- Arch: yay -S rpmdevtools patchelf or pamac install rpmdevtools patchelf

`flutter_distributor package --platform linux --targets rpm`

Binary will be in [$PWD/dist/1.0.0+1/helios-1.0.0+1-linux.rpm]($PWD/dist/1.0.0+1/helios-1.0.0+1-linux.rpm).

**appimage**

Install dependencies:

wget -O appimagetool "https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage"
chmod +x appimagetool
sudo mv appimagetool /usr/local/bin/

`flutter_distributor package --platform windows --targets appimage`

Binary will be in [$PWD/dist/1.0.0+1/helios-1.0.0+1-linux.appimage]($PWD/dist/1.0.0+1/helios-1.0.0+1-linux.appimage).
