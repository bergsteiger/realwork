REM CommandInterpreter: $(ComSpec)
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\Lib\D5\gt*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\Lib\D5\gt*.bpl %windir%\System > nul
:finish

MOVE /y Rtl\gtUtils3.obj ..\Lib\D5
MOVE /y Rtl\gtUtils3.hpp ..\Lib\D5
MOVE /y Rtl\gtConsts3.hpp ..\Lib\D5
MOVE /y Rtl\gtConsts3.obj ..\Lib\D5
MOVE /y Rtl\gtClasses3.hpp ..\Lib\D5
MOVE /y Rtl\gtClasses3.obj ..\Lib\D5
MOVE /y Rtl\gtRtlD5.hpp ..\Lib\D5
MOVE /y Rtl\gtRtlD5.lsp ..\Lib\D5
MOVE /y Rtl\gtRtlD5.bpi ..\Lib\D5
MOVE /y Rtl\gtRtlD5.dcu ..\Lib\D5
ren Rtl\gtRtlD5.dpk.lib gtrtlD5.lib 
MOVE /y Rtl\gtrtlD5.lib ..\Lib\D5

MOVE /y Compression\gtDZLIB3.obj ..\Lib\D5
MOVE /y Compression\gtDZLIB3.hpp ..\Lib\D5
MOVE /y Compression\gtCompressionD5.hpp ..\Lib\D5
MOVE /y Compression\gtCompressionD5.lsp ..\Lib\D5
MOVE /y Compression\gtCompressionD5.bpi ..\Lib\D5
MOVE /y Compression\gtCompressionD5.dcu ..\Lib\D5
ren Compression\gtCompressionD5.dpk.lib gtCompressionD5.lib 
MOVE /y Compression\gtCompressionD5.lib ..\Lib\D5

MOVE /y Filters\gtFilters3.obj ..\Lib\D5
MOVE /y Filters\gtFilters3.hpp ..\Lib\D5
MOVE /y Filters\gtFiltersD5.hpp ..\Lib\D5
MOVE /y Filters\gtFiltersD5.lsp ..\Lib\D5
MOVE /y Filters\gtFiltersD5.bpi ..\Lib\D5
MOVE /y Filters\gtFiltersD5.dcu ..\Lib\D5
ren Filters\gtFiltersD5.dpk.lib gtFiltersD5.lib 
MOVE /y Filters\gtFiltersD5.lib ..\Lib\D5

MOVE /y PDFFontProcessor\gtDocUsp10.obj ..\Lib\D5
MOVE /y PDFFontProcessor\gtDocUsp10.hpp ..\Lib\D5
MOVE /y PDFFontProcessor\gtGlyphInfo.obj ..\Lib\D5
MOVE /y PDFFontProcessor\gtGlyphInfo.hpp ..\Lib\D5
MOVE /y PDFFontProcessor\gtPDFFont3.obj ..\Lib\D5
MOVE /y PDFFontProcessor\gtPDFFont3.hpp ..\Lib\D5
MOVE /y PDFFontProcessor\gtMLang.obj ..\Lib\D5
MOVE /y PDFFontProcessor\gtMLang.hpp ..\Lib\D5
MOVE /y PDFFontProcessor\gtFontD5.hpp ..\Lib\D5
MOVE /y PDFFontProcessor\gtFontD5.lsp ..\Lib\D5
MOVE /y PDFFontProcessor\gtFontD5.bpi ..\Lib\D5
MOVE /y PDFFontProcessor\gtFontD5.dcu ..\Lib\D5
ren PDFFontProcessor\gtFontD5.dpk.lib gtFontD5.lib 
MOVE /y PDFFontProcessor\gtFontD5.lib ..\Lib\D5

MOVE /y PDFCrypt\gtPDFCrypt3.obj ..\Lib\D5
MOVE /y PDFCrypt\gtPDFCrypt3.hpp ..\Lib\D5
MOVE /y PDFCrypt\gtCryptD5.hpp ..\Lib\D5
MOVE /y PDFCrypt\gtCryptD5.lsp ..\Lib\D5
MOVE /y PDFCrypt\gtCryptD5.bpi ..\Lib\D5
MOVE /y PDFCrypt\gtCryptD5.dcu ..\Lib\D5
ren PDFCrypt\gtCryptD5.dpk.lib gtCryptD5.lib 
MOVE /y PDFCrypt\gtCryptD5.lib ..\Lib\D5