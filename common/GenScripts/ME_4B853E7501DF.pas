unit EVDtoNSRCPlusWriterTest;

interface

uses
 l3IntfUses
 , EVDtoNSRCWriterTest
;

type
 TEVDtoNSRCPlusWriterTest = class(TEVDtoNSRCWriterTest)
  {* ���� ������ � NSRC+ }
  function IsNSRCPlus: Boolean;
 end;//TEVDtoNSRCPlusWriterTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
