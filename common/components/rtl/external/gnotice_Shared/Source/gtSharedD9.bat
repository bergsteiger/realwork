REM CommandInterpreter: $(ComSpec)
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\Lib\D2005\gt*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\Lib\D2005\gt*.bpl %windir%\System > nul
:finish

MOVE /y Rtl\gtUtils3.obj ..\Lib\D2005
MOVE /y Rtl\gtUtils3.hpp ..\Lib\D2005
MOVE /y Rtl\gtConsts3.hpp ..\Lib\D2005
MOVE /y Rtl\gtConsts3.obj ..\Lib\D2005
MOVE /y Rtl\gtClasses3.hpp ..\Lib\D2005
MOVE /y Rtl\gtClasses3.obj ..\Lib\D2005
MOVE /y Rtl\gtRtlD9.hpp ..\Lib\D2005
MOVE /y Rtl\gtRtlD9.lsp ..\Lib\D2005
MOVE /y Rtl\gtRtlD9.bpi ..\Lib\D2005
MOVE /y Rtl\gtRtlD9.dcu ..\Lib\D2005
ren Rtl\gtRtlD9.dpk.lib gtrtlD9.lib 
MOVE /y Rtl\gtrtlD9.lib ..\Lib\D2005

MOVE /y Compression\gtDZLIB3.obj ..\Lib\D2005
MOVE /y Compression\gtDZLIB3.hpp ..\Lib\D2005
MOVE /y Compression\gtCompressionD9.hpp ..\Lib\D2005
MOVE /y Compression\gtCompressionD9.lsp ..\Lib\D2005
MOVE /y Compression\gtCompressionD9.bpi ..\Lib\D2005
MOVE /y Compression\gtCompressionD9.dcu ..\Lib\D2005
ren Compression\gtCompressionD9.dpk.lib gtCompressionD9.lib 
MOVE /y Compression\gtCompressionD9.lib ..\Lib\D2005

MOVE /y Filters\gtFilters3.obj ..\Lib\D2005
MOVE /y Filters\gtFilters3.hpp ..\Lib\D2005
MOVE /y Filters\gtFiltersD9.hpp ..\Lib\D2005
MOVE /y Filters\gtFiltersD9.lsp ..\Lib\D2005
MOVE /y Filters\gtFiltersD9.bpi ..\Lib\D2005
MOVE /y Filters\gtFiltersD9.dcu ..\Lib\D2005
ren Filters\gtFiltersD9.dpk.lib gtFiltersD9.lib 
MOVE /y Filters\gtFiltersD9.lib ..\Lib\D2005

MOVE /y PDFFontProcessor\gtDocUsp10.obj ..\Lib\D2005
MOVE /y PDFFontProcessor\gtDocUsp10.hpp ..\Lib\D2005
MOVE /y PDFFontProcessor\gtGlyphInfo.obj ..\Lib\D2005
MOVE /y PDFFontProcessor\gtGlyphInfo.hpp ..\Lib\D2005
MOVE /y PDFFontProcessor\gtPDFFont3.obj ..\Lib\D2005
MOVE /y PDFFontProcessor\gtPDFFont3.hpp ..\Lib\D2005
MOVE /y PDFFontProcessor\gtMLang.obj ..\Lib\D2005
MOVE /y PDFFontProcessor\gtMLang.hpp ..\Lib\D2005
MOVE /y PDFFontProcessor\gtFontD9.hpp ..\Lib\D2005
MOVE /y PDFFontProcessor\gtFontD9.lsp ..\Lib\D2005
MOVE /y PDFFontProcessor\gtFontD9.bpi ..\Lib\D2005
MOVE /y PDFFontProcessor\gtFontD9.dcu ..\Lib\D2005
ren PDFFontProcessor\gtFontD9.dpk.lib gtFontD9.lib 
MOVE /y PDFFontProcessor\gtFontD9.lib ..\Lib\D2005

MOVE /y PDFCrypt\gtPDFCrypt3.obj ..\Lib\D2005
MOVE /y PDFCrypt\gtPDFCrypt3.hpp ..\Lib\D2005
MOVE /y PDFCrypt\gtCryptD9.hpp ..\Lib\D2005
MOVE /y PDFCrypt\gtCryptD9.lsp ..\Lib\D2005
MOVE /y PDFCrypt\gtCryptD9.bpi ..\Lib\D2005
MOVE /y PDFCrypt\gtCryptD9.dcu ..\Lib\D2005
ren PDFCrypt\gtCryptD9.dpk.lib gtCryptD9.lib 
MOVE /y PDFCrypt\gtCryptD9.lib ..\Lib\D2005