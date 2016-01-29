unit evDocumentPartPainter;

interface

uses
 l3IntfUses
 , evParaListPainter
 , l3Units
 , l3Variant
 , l3Interfaces
 , nevBase
 , nevRealTools
;

type
 TevDocumentPartPainter = class(TevParaListPainter)
  {* Реализация интерфейса IevPainter для блока параграфов }
  procedure CorrectFrameBounds;
  function DoWithFrameName(aDrawText: Boolean): Tl3Point;
  function FirstParaAsHeader: Boolean;
  procedure CheckColor4ExpandedText;
  procedure DrawFrameName;
   {* Рисует имя блока в области рамки }
  function NeedDrawPlus: Boolean;
   {* Нужно ли рисовать плюс/минус для открытия/сворачивания блока }
  function NeedCalcSpace: Boolean;
   {* Проверка для срабатывания примеси. }
  function HeaderOwnSpace: Boolean;
  function GetSpaceTop(anInc: Boolean): Integer;
 end;//TevDocumentPartPainter
 
implementation

uses
 l3ImplUses
 , evDocumentPart
 , l3Defaults
 , Graphics
 , k2Tags
 , evDef
 , l3CustomString
 , evConst
 , l3MinMax
 , l3Const
 , l3Types
 , l3String
 , l3Chars
 , l3Math
 , evParaTools
 , l3InternalInterfaces
 , evTextStyle_Const
 , nevTools
;

end.
