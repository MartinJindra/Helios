#!/usr/bin/env pwsh
function DoPackage {
    param (
        [Parameter(Mandatory)]
        [string] $os,
        [string] $target
    )
    if (Get-Command flutter_distributor) {
        if (Test-Path 'dist') {
            Remove-Item -Recurse -Path dist
        }
        flutter_distributor package --platform $os --targets $target
    }
}

if ($IsWindows) { DoPackage -os windows -target msix }
elseif ($IsMacOS) { DoPackage -os macos -target dmg }
elseif ($IsLinux) { DoPackage -os linux -target 'appimage,rpm' }
