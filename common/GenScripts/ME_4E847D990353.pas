unit HTMLtoEVDWriterTest;

interface

uses
 l3IntfUses
 , WriterTest
;

type
 THTMLtoEVDWriterTest = class(TWriterTest)
  procedure HTMLtoEVD(const aFileName: AnsiString);
 end;//THTMLtoEVDWriterTest
 
implementation

uses
 l3ImplUses
 , ddHTMLReader
 , TestFrameWork
 , SysUtils
;

end.
