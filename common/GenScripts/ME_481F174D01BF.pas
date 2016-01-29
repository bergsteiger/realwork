unit nevTextParaRenderInfo;

interface

uses
 l3IntfUses
 , nevLeafRenderInfo
 , nevBase
 , l3Variant
 , nevFormatInfoList
 , nevFormatInfo
 , nevTools
;

type
 TnevTextParaRenderInfo = class(TnevLeafRenderInfo)
  function GetBlockHeaderIndent: Integer;
 end;//TnevTextParaRenderInfo
 
implementation

uses
 l3ImplUses
 , k2Tags
 , evdTypes
 , evSegLst
 , k2Base
 , l3String
 , SysUtils
 , TextPara_Const
 , LeafPara_Const
 , nevFormatInfoFactory
 , TextSegment_Const
 , l3LineArray
 , l3Types
 , l3Interfaces
 , TableCell_Const
 , evTextParaConst
 , l3Chars
 , l3Utils
 , nevSegmentObject
 , l3MinMax
 , l3SingleLineInfo
 , evTextParaTools
 , evParaTools
 , evAACContentUtils
;

end.
