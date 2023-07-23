# Linux

**rpm**

Install dependencies:

- Debian/Ubuntu: `apt install rpm patchelf`
- Fedora: `dnf install gcc rpm-build rpm-devel rpmlint make python bash coreutils diffutils patch rpmdevtools patchelf`
- Arch: `yay -S rpmdevtools patchelf or pamac install rpmdevtools patchelf`

**appimage**

Install dependencies:

```
wget -O appimagetool "https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage"
chmod +x appimagetool
sudo mv appimagetool /usr/local/bin/
```