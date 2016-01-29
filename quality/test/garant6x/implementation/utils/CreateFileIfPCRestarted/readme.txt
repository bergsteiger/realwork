IfFileCreateDate.exe <filename> <timeout_sec>

Create <filename> if work time after reboot lower then <timeout_sec>
Return 1 exit code if file created else 0
Example: CreateFileIfPCRestarted.exe <filename> [<timeout_sec>]
