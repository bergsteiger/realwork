if exist "C:\Users\lulin\AppData\Local\Google\Chrome\Application\chrome.exe" (
 start "" "C:\Users\lulin\AppData\Local\Google\Chrome\Application\chrome.exe"
) else (
if exist  "C:\Users\test\AppData\Local\Google\Chrome\Application\chrome.exe" (
  start "" "C:\Users\test\AppData\Local\Google\Chrome\Application\chrome.exe " %1
) else (  
if "%ProgramFiles(x86)%"=="" (
 start "" "C:\Users\lulin\AppData\Local\Google\Chrome\Application\chrome.exe " %1
) else (
 start "" "C:\Users\lulin.lulin-nest\AppData\Local\Google\Chrome\Application\chrome.exe " %1
) ) )
rem start "" "C:\Program Files\Internet Explorer\iexplore.exe" %1