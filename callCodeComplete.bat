SET /A "LINE=%2+1"
SET /A "COL=%3+1"
call .\codeComplete.bat %1 %LINE% %COL% > codeComplete.result 2>&1
echo "FINISHED %1 %LINE% %COL%" >> codeComplete.result