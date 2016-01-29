unit NSRCtoMemoryTest;

interface

uses
 l3IntfUses
 , NSRCWriterTest
;

type
 TNSRCtoMemoryTest = class(TNSRCWriterTest)
  {* Тест чтения NSRC в память }
  procedure DoIt;
 end;//TNSRCtoMemoryTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
