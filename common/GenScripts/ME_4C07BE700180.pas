unit EVDtoEVDEmptyRowTest;

interface

uses
 l3IntfUses
 , EVDtoEVDWriterTest
 , l3Variant
;

type
 TEVDtoEVDEmptyRowTest = class(TEVDtoEVDWriterTest)
 end;//TEVDtoEVDEmptyRowTest
 
implementation

uses
 l3ImplUses
 , evdEmptyRowFilter
 , TestFrameWork
;

end.
