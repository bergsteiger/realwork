unit XMLWriterTest;

interface

uses
 l3IntfUses
 , WriterTest
 , evdXMLWriter
 , l3Filer
 , k2CustomFileReader
 , evdNativeReader
;

type
 TXMLWriterTest = class(TWriterTest)
  procedure SomeFormatToXML(aReader: Tk2CustomFileReader;
   NeedCheck: Boolean);
  procedure EVDtoXML(const aFileName: AnsiString;
   NeedCheck: Boolean);
 end;//TXMLWriterTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , SysUtils
;

end.
