call ./setupVars.bat
set PROJECTSWIFTFLAGS=-I %CD%/Lib -I "C:\msys64\mingw64\include" -L %CD%/Lib/CCoreDLL -lCCoreDLL
swiftc -frontend -dump-type-refinement-contexts main.swift someType.swift %SWIFTFLAGS% 