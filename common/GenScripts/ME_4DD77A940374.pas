unit nevTableRowBaseLine4Print;

interface

uses
 l3IntfUses
 , nevTools
 , l3Variant
 , nevBase
;

type
 TnevTableRowBaseLine4Print = class(_nevTableRowBaseLineCommon_)
  {* Базовая линия для печати }
  function Make(aRow: Tl3Variant): InevPoint;
  function DoDiff(const aView: InevView;
   const aPoint: InevBasePoint;
   aMap: TnevFormatInfoPrim): Integer;
  function CheckMaxID(aMaxID: Integer): InevBasePoint;
  function SimpleMode: Boolean;
  function GetInner4SimpleMode: InevBasePoint;
 end;//TnevTableRowBaseLine4Print
 
implementation

uses
 l3ImplUses
 , evdTypes
 , l3MinMax
 , nevAfterEndPoint
 , k2Tags
 , l3Base
 , evTableCellUtils
 , SysUtils
;

end.
