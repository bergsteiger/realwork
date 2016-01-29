unit evControlGenerator;

interface

uses
 l3IntfUses
 , evDocumentPartGenerator
 , l3InterfacedString
 , l3Variant
;

type
 TevControlGenerator = class(TevDocumentPartGenerator)
 end;//TevControlGenerator
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3Base
 , l3Chars
 , evParaTools
 , evdTypes
 , TextPara_Const
 , ControlPara_Const
 , nevTools
;

end.
