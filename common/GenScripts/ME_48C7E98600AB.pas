unit evTableRowPainter;

interface

uses
 l3IntfUses
 , evParaListPainter
 , nevRealTools
 , nevTools
 , nevBase
 , l3InternalInterfaces
 , l3Interfaces
 , l3Variant
;

type
 TevTableRowPainter = class(TevParaListPainter, IevTableRowPainter)
  {* "рисователь" строк таблиц }
  procedure CheckHeight(var l_Height: Integer);
  function GetRowPoint(aMaxIndex: Integer;
   out aRealPoint: InevBasePoint): InevBasePoint;
  procedure CorrectRowHeightByTopSpace(var aDelta: Integer);
   {* Добавить величину отступа верхней границы блока для КЗ. }
  function CheckChildren(const aFI: TnevFormatInfoPrim;
   const aCanvas: Il3Canvas): Boolean;
   {* [$219123966] }
  procedure CorrectTopDelta(var aDelta: Integer);
  function IsTopAnchorAtStart: Boolean;
  function GetTopAnchor4Row: InevBasePoint;
   {* Возвращает указатель на строку из View.TopAnchor }
 end;//TevTableRowPainter
 
implementation

uses
 l3ImplUses
 , SysUtils
 , k2Tags
 , l3Const
 , l3MinMax
 , evdTypes
 , Table_Const
 , TableCell_Const
 , nevFacade
 , Classes
 , evTableCellUtils
 , PrintRowHeightsSpy
 , Block_Const
 , evParaTools
 , TableRow_Const
;

end.
