unit EVDtoNSRCWriterTest;

interface

uses
 l3IntfUses
 , NSRCWriterTest
;

type
 TEVDtoNSRCWriterTest = class(TNSRCWriterTest)
  {* ���� ������ �� EVD � NSRC }
  procedure DoIt;
  function IsNSRCPlus: Boolean;
 end;//TEVDtoNSRCWriterTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , l3Except
;

end.
