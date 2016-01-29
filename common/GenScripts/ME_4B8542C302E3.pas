unit EVDtoBothNSRCWriterTest;

interface

uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TEVDtoBothNSRCWriterTest = class(TEVDtoNSRCPlusWriterTest)
  {* Тест записи в NSRC+ и NSRC }
  procedure ToOldNSRC;
 end;//TEVDtoBothNSRCWriterTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
