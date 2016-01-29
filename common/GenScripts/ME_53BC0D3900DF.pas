unit BadEVDTest;

interface

uses
 l3IntfUses
 , EVDtoEVDWriterTest
 , l3Variant
;

type
 TBadEVDTest = class(TEVDtoEVDWriterTest)
 end;//TBadEVDTest
 
implementation

uses
 l3ImplUses
 , evdBadEVDToEmptyDocumentTranslator
 , TestFrameWork
;

end.
