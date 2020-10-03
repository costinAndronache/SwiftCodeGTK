@echo off
call ./projectFlags.bat
set LINE=%2
set COL=%3
set FILE=%1

sourcekitd-test -req=complete -pos %LINE%:%COL% %FILE% -- %ALL_FLAGS%