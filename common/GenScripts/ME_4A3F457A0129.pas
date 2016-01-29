unit nevParaListAnchor;

interface

uses
 l3IntfUses
 , nevAnchor
 , nevTools
 , nevBase
 , k2Interfaces
 , l3Variant
;

type
 TnevParaListAnchor = class(TnevAnchor)
  {* якорь дл€ списков параграфов }
  procedure CheckInner;
  procedure ClearInner;
  procedure ClearInnerInFire;
  function GetAtStart: Boolean;
  function GetAtEnd(const aView: InevView): Boolean;
  function GetVertPosition(const aView: InevView;
   aMap: TnevFormatInfoPrim): TnevParaIndex;
  procedure SetPID(aValue: Integer);
  function GetPID: Integer;
 end;//TnevParaListAnchor
 
implementation

uses
 l3ImplUses
 , k2Tags
 , SysUtils
 , l3MinMax
 , Table_Const
 , nevParaListAnchorModifyTypes
;

end.
