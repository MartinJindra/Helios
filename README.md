# Helios

A simple project to create a DND character builder.

Your question may be "Why build a new character builder when Aurora is available?".

Because it is unmaintained, not opensource and not cross-platform.

So I want to build Helios. A sibling to Aurora.

## Building

This program is written with Flutter.

So to build this project follow instructions
on [flutter.dev](https://docs.flutter.dev/get-started/install).

When installed the binary for the specific platform can be built with:

**Windows**

```
flutter build windows
```

The binary then can be found in [build\windows\runner\Release](build\windows\runner\Release)
.

**MacOS**

```
flutter build macos
```

The binary then can be found in [build/macos/Build/Products/Release/helios.app/Contents/MacOS](build/macos/Build/Products/Release/helios.app/Contents/MacOS).

**Linux**

```
flutter build linux
```

The binary then can be found in [build/linux/x64/release/bundle](build/linux/x64/release/bundle).

## Icons

```
dart run flutter_launcher_icons
```

## Distributing

To build a package for distribution [flutter_distributor](https://distributor.leanflutter.org) is used.

Install the packager globally

```
dart pub global activate flutter_distributor
```

On Windows it should be in [$HOME\AppData\Local\Pub\Cache\bin\flutter_distributor]($HOME\AppData\Local\Pub\Cache\bin\flutter_distributor).
On Linux in [~/.pub-cache/bin/flutter_distributor](~/.pub-cache/bin/flutter_distributor).

### Windows

**msix**

`flutter_distributor package --platform windows --targets msix`

Binary will be in [$PWD\dist\1.0.0+1\helios-1.0.0+1-windows.msix]($PWD\dist\1.0.0+1\helios-1.0.0+1-windows.msix).

### Linux

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
