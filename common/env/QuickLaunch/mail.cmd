if "%ProgramFiles(x86)%"=="" (
start "" "C:\Program Files\Mozilla Thunderbird\thunderbird.exe"
) else (
start "" "%ProgramFiles(x86)%\Mozilla Thunderbird\thunderbird.exe"
)
rem start "" "C:\Program Files\Outlook Express\msimn.exe"