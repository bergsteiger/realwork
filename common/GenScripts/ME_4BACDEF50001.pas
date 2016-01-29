unit RTFWriterTest;

interface

uses
 l3IntfUses
 , WriterTest
 , ddRTFWriter
 , l3Filer
 , k2CustomFileReader
 , evdNativeReader
;

type
 TRTFWriterTest = class(TWriterTest)
  procedure SomeFormatToRTF(aReader: Tk2CustomFileReader;
   NeedCheck: Boolean);
  procedure EVDtoRTF(const aFileName: AnsiString;
   NeedCheck: Boolean);
  function UseExternalLinks: Boolean;
 end;//TRTFWriterTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , SysUtils
;

end.
