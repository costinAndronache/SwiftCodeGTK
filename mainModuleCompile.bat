@echo off
set SDKROOT=C:\Library\Developer\Platforms\Windows.platform\Developer\SDKs\Windows.sdk
set SWIFTFLAGS=-sdk %SDKROOT% -I %SDKROOT%/usr/lib/swift -L %SDKROOT%/usr/lib/swift/windows

swiftc -v -emit-module -emit-library -module-name ZeMain main.swift %SWIFTFLAGS%