unit WikiReaderTest;

interface

uses
 l3IntfUses
 , WriterTest
;

type
 TWikiReaderTest = class(TWriterTest)
  procedure WikiToEVD(const aFileName: AnsiString);
 end;//TWikiReaderTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , evWikiReader
 , SysUtils
;

end.
