unit evTextParaCursor;

interface

uses
 l3IntfUses
 , evLeafParaCursor
 , nevTools
 , nevBase
 , l3Variant
 , l3IID
 , l3Core
 , l3Interfaces
;

type
 TevTextParaCursor = class(TevLeafParaCursor, IevTagLine)
  {* Реализация курсора для текстового параграфа }
  function DoPrevCharForDelete(const aView: InevView;
   const anOp: InevOp): Boolean;
  procedure CheckSegments(aPos: Integer;
   const anOp: InevOp);
  function GetLine(aMap: TnevFormatInfoPrim): Integer;
  function LineEnd: Boolean;
  function GetLC(aSelf: _nevTextParaViewBounds_;
   aMap: TnevFormatInfoPrim): TnevLineCoord;
   {* Возвращает текущую строку }
  procedure SetLinePrim(aValue: Integer;
   aMap: TnevFormatInfoPrim);
 end;//TevTextParaCursor
 
implementation

uses
 l3ImplUses
 , evCursorConst
 , evTextParaTools
 , evHyperlink
 , k2Tags
 , evDrawLineTool
 , LeafPara_Const
 , StyledLeafPara_Const
 , TableCell_Const
 , Document_Const
 , TextPara_Const
 , Formula_Const
 , BitmapPara_Const
 , HyperLink_Const
 , evdTypes
 , k2Base
 , nevNavigation
 , evSegLst
 , k2Const
 , l3InterfacedString
 , l3CustomString
 , l3String
 , l3Types
 , ObjectSegment_Const
 , evParaTools
 , k2BaseTypes
 , evTextParaOp
 , evCursorTools
 , Classes
 , l3Base
 , l3LineArray
 , l3Units
 , l3MinMax
 , evOp
 , l3Const
 , k2OpMisc
 , l3Chars
 , evExcept
 , evTabIndentMarker
 , nevInterfaces
 , evTextParaMarkers
 , evTextParaOpEx
 , evTextManipulationInterfaces
 , k2Facade
 , l3UnitsTools
 , evSegment
 , ContentsElement_Const
 , evAlignBySeparatorUtils
 , k2String
 , SysUtils
 , evdStyles
;

type
 PevTextParaCursor = ^TevTextParaCursor;
 
end.
