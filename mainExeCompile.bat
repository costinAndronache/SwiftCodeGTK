call ./projectFlags.bat
echo "source files are:"
echo %SOURCEFILES%
swiftc -v -o main.exe %ALL_FLAGS%

