REM CommandInterpreter: $(ComSpec)
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\Lib\D7\gt*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\Lib\D7\gt*.bpl %windir%\System > nul
:finish

MOVE /y Rtl\gtUtils3.obj ..\Lib\D7
MOVE /y Rtl\gtUtils3.hpp ..\Lib\D7
MOVE /y Rtl\gtConsts3.hpp ..\Lib\D7
MOVE /y Rtl\gtConsts3.obj ..\Lib\D7
MOVE /y Rtl\gtClasses3.hpp ..\Lib\D7
MOVE /y Rtl\gtClasses3.obj ..\Lib\D7
MOVE /y Rtl\gtRtlD7.hpp ..\Lib\D7
MOVE /y Rtl\gtRtlD7.lsp ..\Lib\D7
MOVE /y Rtl\gtRtlD7.bpi ..\Lib\D7
MOVE /y Rtl\gtRtlD7.dcu ..\Lib\D7
ren Rtl\gtRtlD7.dpk.lib gtrtlD7.lib 
MOVE /y Rtl\gtrtlD7.lib ..\Lib\D7

MOVE /y Compression\gtDZLIB3.obj ..\Lib\D7
MOVE /y Compression\gtDZLIB3.hpp ..\Lib\D7
MOVE /y Compression\gtCompressionD7.hpp ..\Lib\D7
MOVE /y Compression\gtCompressionD7.lsp ..\Lib\D7
MOVE /y Compression\gtCompressionD7.bpi ..\Lib\D7
MOVE /y Compression\gtCompressionD7.dcu ..\Lib\D7
ren Compression\gtCompressionD7.dpk.lib gtCompressionD7.lib 
MOVE /y Compression\gtCompressionD7.lib ..\Lib\D7

MOVE /y Filters\gtFilters3.obj ..\Lib\D7
MOVE /y Filters\gtFilters3.hpp ..\Lib\D7
MOVE /y Filters\gtFiltersD7.hpp ..\Lib\D7
MOVE /y Filters\gtFiltersD7.lsp ..\Lib\D7
MOVE /y Filters\gtFiltersD7.bpi ..\Lib\D7
MOVE /y Filters\gtFiltersD7.dcu ..\Lib\D7
ren Filters\gtFiltersD7.dpk.lib gtFiltersD7.lib 
MOVE /y Filters\gtFiltersD7.lib ..\Lib\D7

MOVE /y PDFFontProcessor\gtDocUsp10.obj ..\Lib\D7
MOVE /y PDFFontProcessor\gtDocUsp10.hpp ..\Lib\D7
MOVE /y PDFFontProcessor\gtGlyphInfo.obj ..\Lib\D7
MOVE /y PDFFontProcessor\gtGlyphInfo.hpp ..\Lib\D7
MOVE /y PDFFontProcessor\gtPDFFont3.obj ..\Lib\D7
MOVE /y PDFFontProcessor\gtPDFFont3.hpp ..\Lib\D7
MOVE /y PDFFontProcessor\gtMLang.obj ..\Lib\D7
MOVE /y PDFFontProcessor\gtMLang.hpp ..\Lib\D7
MOVE /y PDFFontProcessor\gtFontD7.hpp ..\Lib\D7
MOVE /y PDFFontProcessor\gtFontD7.lsp ..\Lib\D7
MOVE /y PDFFontProcessor\gtFontD7.bpi ..\Lib\D7
MOVE /y PDFFontProcessor\gtFontD7.dcu ..\Lib\D7
ren PDFFontProcessor\gtFontD7.dpk.lib gtFontD7.lib 
MOVE /y PDFFontProcessor\gtFontD7.lib ..\Lib\D7

MOVE /y PDFCrypt\gtPDFCrypt3.obj ..\Lib\D7
MOVE /y PDFCrypt\gtPDFCrypt3.hpp ..\Lib\D7
MOVE /y PDFCrypt\gtCryptD7.hpp ..\Lib\D7
MOVE /y PDFCrypt\gtCryptD7.lsp ..\Lib\D7
MOVE /y PDFCrypt\gtCryptD7.bpi ..\Lib\D7
MOVE /y PDFCrypt\gtCryptD7.dcu ..\Lib\D7
ren PDFCrypt\gtCryptD7.dpk.lib gtCryptD7.lib 
MOVE /y PDFCrypt\gtCryptD7.lib ..\Lib\D7