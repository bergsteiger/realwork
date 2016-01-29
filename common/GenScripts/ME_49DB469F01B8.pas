unit evControlsBlockPainter;

interface

uses
 l3IntfUses
 , evDocumentPartPainter
 , l3Variant
 , l3Interfaces
 , nevBase
;

type
 TevControlsBlockPainter = class(TevDocumentPartPainter)
  {* Рисователь группы контролов }
 end;//TevControlsBlockPainter
 
implementation

uses
 l3ImplUses
 , l3CustomString
 , l3InternalInterfaces
 , l3Units
 , evDocumentPart
 , TextPara_Const
 , evdStyles
 , k2Tags
 , k2Base
 , evControlsBlockConst
 , evControlParaTools
 , evdTypes
 , l3Defaults
 , Graphics
 , Cloak_Const
 , l3Math
 , l3Const
 , l3Types
 , l3String
 , NodeGroup_Const
 , ControlsBlock_Const
;

end.
