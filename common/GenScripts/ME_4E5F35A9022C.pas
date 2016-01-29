unit nevFormulaFormatInfo;

interface

uses
 l3IntfUses
 , nevTextParaRenderInfo
 , l3InternalInterfaces
 , evResultFontInterfaces
 , nevBase
;

type
 TnevFormulaFormatInfo = class(TnevTextParaRenderInfo)
 end;//TnevFormulaFormatInfo
 
implementation

uses
 l3ImplUses
 , k2Tags
 , evFormulaParaBitmapContainer
 , ExprDraw
 , SysUtils
 , TextPara_Const
 , nevSegmentObject
 , ExprMake
 , l3_String
;

end.
