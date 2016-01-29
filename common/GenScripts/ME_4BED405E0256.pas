unit NSRCtoEVDTest;

interface

uses
 l3IntfUses
 , NSRCWriterTest
;

type
 TNSRCtoEVDTest = class(TNSRCWriterTest)
  {* Тест преобразования NSRC в EVD }
  procedure DoIt;
 end;//TNSRCtoEVDTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
