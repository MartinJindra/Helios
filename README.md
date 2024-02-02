# Helios

A simple project to create a DND character builder.

Your question may be "Why build a new character builder when Aurora is available?".

Because it is unmaintained, not opensource and not cross-platform.

So I want to build Helios. A sibling to Aurora.

## Building

This program is written with Flutter.

So to build this project follow the install instructions for Flutter
on [flutter.dev](https://docs.flutter.dev/get-started/install).

To build a package I use [flutter_distributor](https://distributor.leanflutter.org).

Install the package globally.

```
dart pub global activate flutter_distributor
```

And use the [package script](./package.dart).

But some dependencies for building a package for Linux are needed if they are not yet installed.

Refer to [Linux packaging](PACKAGING.md#Linux),

```
dart build.dart
```