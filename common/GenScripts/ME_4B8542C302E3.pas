unit EVDtoBothNSRCWriterTest;

interface

uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TEVDtoBothNSRCWriterTest = class(TEVDtoNSRCPlusWriterTest)
  {* ���� ������ � NSRC+ � NSRC }
  procedure ToOldNSRC;
 end;//TEVDtoBothNSRCWriterTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
