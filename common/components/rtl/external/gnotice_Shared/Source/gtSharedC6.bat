REM CommandInterpreter: $(ComSpec)
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\Lib\C6\gt*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\Lib\C6\gt*.bpl %windir%\System > nul
:finish

MOVE /y Rtl\gtUtils3.obj ..\Lib\C6
MOVE /y Rtl\gtUtils3.hpp ..\Lib\C6
MOVE /y Rtl\gtConsts3.hpp ..\Lib\C6
MOVE /y Rtl\gtConsts3.obj ..\Lib\C6
MOVE /y Rtl\gtClasses3.hpp ..\Lib\C6
MOVE /y Rtl\gtClasses3.obj ..\Lib\C6
MOVE /y Rtl\gtRtlD6.hpp ..\Lib\C6
MOVE /y Rtl\gtRtlD6.lsp ..\Lib\C6
MOVE /y Rtl\gtRtlD6.bpi ..\Lib\C6
MOVE /y Rtl\gtRtlD6.dcu ..\Lib\C6
ren Rtl\gtRtlD6.dpk.lib gtrtlD6.lib 
MOVE /y Rtl\gtrtlD6.lib ..\Lib\C6

MOVE /y Compression\gtDZLIB3.obj ..\Lib\C6
MOVE /y Compression\gtDZLIB3.hpp ..\Lib\C6
MOVE /y Compression\gtCompressionD6.hpp ..\Lib\C6
MOVE /y Compression\gtCompressionD6.lsp ..\Lib\C6
MOVE /y Compression\gtCompressionD6.bpi ..\Lib\C6
MOVE /y Compression\gtCompressionD6.dcu ..\Lib\C6
ren Compression\gtCompressionD6.dpk.lib gtCompressionD6.lib 
MOVE /y Compression\gtCompressionD6.lib ..\Lib\C6

MOVE /y Filters\gtFilters3.obj ..\Lib\C6
MOVE /y Filters\gtFilters3.hpp ..\Lib\C6
MOVE /y Filters\gtFiltersD6.hpp ..\Lib\C6
MOVE /y Filters\gtFiltersD6.lsp ..\Lib\C6
MOVE /y Filters\gtFiltersD6.bpi ..\Lib\C6
MOVE /y Filters\gtFiltersD6.dcu ..\Lib\C6
ren Filters\gtFiltersD6.dpk.lib gtFiltersD6.lib 
MOVE /y Filters\gtFiltersD6.lib ..\Lib\C6

MOVE /y PDFFontProcessor\gtDocUsp10.obj ..\Lib\C6
MOVE /y PDFFontProcessor\gtDocUsp10.hpp ..\Lib\C6
MOVE /y PDFFontProcessor\gtGlyphInfo.obj ..\Lib\C6
MOVE /y PDFFontProcessor\gtGlyphInfo.hpp ..\Lib\C6
MOVE /y PDFFontProcessor\gtPDFFont3.obj ..\Lib\C6
MOVE /y PDFFontProcessor\gtPDFFont3.hpp ..\Lib\C6
MOVE /y PDFFontProcessor\gtMLang.obj ..\Lib\C6
MOVE /y PDFFontProcessor\gtMLang.hpp ..\Lib\C6
MOVE /y PDFFontProcessor\gtFontD6.hpp ..\Lib\C6
MOVE /y PDFFontProcessor\gtFontD6.lsp ..\Lib\C6
MOVE /y PDFFontProcessor\gtFontD6.bpi ..\Lib\C6
MOVE /y PDFFontProcessor\gtFontD6.dcu ..\Lib\C6
ren PDFFontProcessor\gtFontD6.dpk.lib gtFontD6.lib 
MOVE /y PDFFontProcessor\gtFontD6.lib ..\Lib\C6

MOVE /y PDFCrypt\gtPDFCrypt3.obj ..\Lib\C6
MOVE /y PDFCrypt\gtPDFCrypt3.hpp ..\Lib\C6
MOVE /y PDFCrypt\gtCryptD6.hpp ..\Lib\C6
MOVE /y PDFCrypt\gtCryptD6.lsp ..\Lib\C6
MOVE /y PDFCrypt\gtCryptD6.bpi ..\Lib\C6
MOVE /y PDFCrypt\gtCryptD6.dcu ..\Lib\C6
ren PDFCrypt\gtCryptD6.dpk.lib gtCryptD6.lib 
MOVE /y PDFCrypt\gtCryptD6.lib ..\Lib\C6