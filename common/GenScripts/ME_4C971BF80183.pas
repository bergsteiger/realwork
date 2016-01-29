unit RTFReaderTest;

interface

uses
 l3IntfUses
 , WriterTest
;

type
 TRTFReaderTest = class(TWriterTest)
  procedure RTFtoEVD(const aFileName: AnsiString);
  function GetEnablePictures: Boolean;
 end;//TRTFReaderTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , SysUtils
 , ddRTFReader
;

end.
