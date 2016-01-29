unit NSRCtoNSRCTest;

interface

uses
 l3IntfUses
 , NSRCWriterTest
;

type
 TNSRCtoNSRCTest = class(TNSRCWriterTest)
  {* Тест преобразования NSRC в NSRC }
  procedure DoIt;
  function IsPlus: Boolean;
   {* NSRC+? }
 end;//TNSRCtoNSRCTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
