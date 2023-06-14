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
flutter build windows --release
```

The binary then can be found in [build/windows/x64/release/bundle](build/windows/x64/release/bundle)
.

**MacOS**

```
flutter build macos --release
```

The binary then can be found in [build/macos/x64/release/bundle](build/macos/x64/release/bundle).

**Linux**

```
flutter build linux --release
```

The binary then can be found in [build/linux/x64/release/bundle](build/linux/x64/release/bundle).