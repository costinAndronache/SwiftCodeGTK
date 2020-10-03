call ./setupVars.bat
call ./listSourceFiles.bat
set PROJECTSWIFTFLAGS=-I %CD%/Lib -L %CD%/Lib/
set GTKIncludes=-I./Lib/gtk-3.0/include/gtk-3.0 -I./Lib/gtk-3.0/include/cairo -I./Lib/gtk-3.0/include -I./Lib/gtk-3.0/include/pango-1.0 -I./Lib/gtk-3.0/include/fribidi -I./Lib/gtk-3.0/include -I./Lib/gtk-3.0/include/freetype2 -I./Lib/gtk-3.0/include/harfbuzz -I./Lib/gtk-3.0/include/atk-1.0 -I./Lib/gtk-3.0/include/cairo -I./Lib/gtk-3.0/include/gdk-pixbuf-2.0 -I./Lib/gtk-3.0/include -I./Lib/gtk-3.0/include/glib-2.0 -I./Lib/gtk-3.0/lib/glib-2.0/include
set GTKLibs=-L ./Lib/gtk-3.0/lib
set ALL_FLAGS=%SOURCEFILES% %SWIFTFLAGS% %PROJECTSWIFTFLAGS% %GTKIncludes%  %GTKLibs%