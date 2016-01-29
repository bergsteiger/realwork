unit EVDtoEVDOEMTableFlagTest;

interface

uses
 l3IntfUses
 , EVDtoEVDWriterTest
 , l3Variant
;

type
 TEVDtoEVDOEMTableFlagTest = class(TEVDtoEVDWriterTest)
  {* Тест фильтра"'Выливать в псевдографику" }
 end;//TEVDtoEVDOEMTableFlagTest
 
implementation

uses
 l3ImplUses
 , evOEMTableFlagFilter
 , TestFrameWork
;

end.
