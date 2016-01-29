unit EVDtoNSRCPlusWriterTest;

interface

uses
 l3IntfUses
 , EVDtoNSRCWriterTest
;

type
 TEVDtoNSRCPlusWriterTest = class(TEVDtoNSRCWriterTest)
  {* Тест записи в NSRC+ }
  function IsNSRCPlus: Boolean;
 end;//TEVDtoNSRCPlusWriterTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
