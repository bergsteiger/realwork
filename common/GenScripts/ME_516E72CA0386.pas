unit EVDtoHTMLWriterTest;

interface

uses
 l3IntfUses
 , WriterTest
 , l3Filer
 , ddHTMLWriter
 , k2CustomFileReader
;

type
 TEVDtoHTMLWriterTest = class(TWriterTest)
  procedure EVDtoHTML(const aFileName: AnsiString);
  procedure SomeFormatToHTML(aReader: Tk2CustomFileReader);
 end;//TEVDtoHTMLWriterTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , evdNativeReader
 , SysUtils
;

end.
