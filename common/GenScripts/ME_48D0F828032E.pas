unit nevLeafPara;

interface

uses
 l3IntfUses
 , nevPara
 , nevTools
 , l3Variant
 , nevBase
 , k2Interfaces
;

type
 TnevLeafPara = class(TnevPara, InevLeafPara)
  {* Реализация инструмента InevLeafPara }
  procedure Make(aTag: Tl3Variant);
  function GetIsHidden(aMap: TnevFormatInfoPrim;
   aHiddenStyles: TnevStandardStyles): Boolean;
  function TagIsHidden(aTag: Tl3Variant;
   aHiddenStyles: TnevStandardStyles): Boolean;
 end;//TnevLeafPara
 
implementation

uses
 l3ImplUses
 , k2Tags
 , evdStyles
 , l3String
 , evParaTools
 , CommentPara_Const
 , Block_Const
 , l3MinMax
 , TableCell_Const
;

end.
