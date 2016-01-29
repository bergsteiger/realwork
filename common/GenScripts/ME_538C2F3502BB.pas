unit RTFtoEVDWithiddenTextExtractor;

interface

uses
 l3IntfUses
 , RTFtoEVDWriterTest
 , l3Variant
;

type
 TRTFtoEVDWithiddenTextExtractor = class(TRTFtoEVDWriterTest)
 end;//TRTFtoEVDWithiddenTextExtractor
 
implementation

uses
 l3ImplUses
 , dd_lcHiddenTextExtractor
 , TestFrameWork
;

end.
