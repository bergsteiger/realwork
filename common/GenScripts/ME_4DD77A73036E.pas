unit nevTableRowBaseLine4Anchor;

interface

uses
 l3IntfUses
 , nevTools
 , l3Variant
 , nevBase
 , k2Interfaces
;

type
 TnevTableRowBaseLine4Anchor = class(_nevTableRowBaseLineCommon_)
  {* Базовая линия для якоря }
  function GetBottomIndex(const aView: InevView): Integer;
  function GoToNextRow(const aView: InevView;
   const aPoint: InevBasePoint;
   var aDiff: Integer;
   aMoveUp: Boolean): Boolean;
   {* Подготовка точки от объединенной ячейки к "перескоку" на следущую строку. }
  function GetStartPoint4RemoveDiff(const aView: InevView;
   aHeadCell: Boolean;
   anIndex: Integer;
   var aMoveUp: Boolean): InevBasePoint;
  function CalcDiff4CenterAlign(const aView: InevView;
   const aPoint: InevBasePoint;
   aMoveUp: Boolean): Integer;
   {* Рассчитывает отступ (сверху или снизу) для ячейки с выравниванием по вертикали посердине. }
  procedure RemoveDiff(const aView: InevView;
   aHeadCell: Boolean;
   const aTestPoint: InevBasePoint;
   const aMaxPoint: InevBasePoint;
   var aMaxFI: TnevFormatInfoPrim;
   anIndex: Integer;
   anHeadIndex: Integer);
  procedure Create(aRow: Tl3Variant);
  function Make(aRow: Tl3Variant): InevPoint;
  function DoDiff(const aView: InevView;
   const aPoint: InevBasePoint;
   aMap: TnevFormatInfoPrim): Integer;
  function CheckMaxID(aMaxID: Integer): InevBasePoint;
  function SimpleMode: Boolean;
  function GetInner4SimpleMode: InevBasePoint;
 end;//TnevTableRowBaseLine4Anchor
 
implementation

uses
 l3ImplUses
 , nevAfterEndPoint
 , evTableCellUtils
 , evConst
 , l3MinMax
 , nevFacade
 , evOp
 , Math
 , nevBeforeStartPoint
 , evCursorTools
 , evdTypes
 , k2Tags
 , l3Base
 , SysUtils
;

end.
