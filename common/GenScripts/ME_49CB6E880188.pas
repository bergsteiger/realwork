unit evCellsOffsets;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , evEpsilonLongIntList
;

type
 TevCellsOffsets = class(Tl3ProtoObject)
  {* работа со смещени€ми €чеек }
  procedure Clear;
  procedure AddCellWidth;
  procedure CheckOffset(aCheckWidth: Boolean);
  function CheckParam: Boolean;
  procedure RecalcOffset;
  procedure ClearOffset;
  procedure SetWidth(aWidth: Integer);
 end;//TevCellsOffsets
 
implementation

uses
 l3ImplUses
 , SysUtils
 , evConst
;

end.
