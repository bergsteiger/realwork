unit EVDtoNSRCOldWriterTest;

interface

uses
 l3IntfUses
 , EVDtoNSRCWriterTest
;

type
 TEVDtoNSRCOldWriterTest = class(TEVDtoNSRCWriterTest)
  function IsNSRCPlus: Boolean;
 end;//TEVDtoNSRCOldWriterTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
