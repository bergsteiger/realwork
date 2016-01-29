call "%~d0%~p0_vars.bat"

if "%PROCESSOR_ARCHITECTURE%" equ "AMD64" (
	regsvr32 "%PATH_TO_CODE%QCFileComponents.x64.dll"
) else (
	regsvr32 "%PATH_TO_CODE%QCFileComponents.dll"
)

regsvr32 /n scrobj.dll /i:"%PATH_TO_CODE%VBArrayMaker.wsc"
