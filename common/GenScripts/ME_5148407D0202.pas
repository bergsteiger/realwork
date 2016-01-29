unit CellsCountStack.imp;

interface

uses
 l3IntfUses
 , l3ProtoIntegerList
;

type
 _CellsCountStack_ = class
  procedure FreeCellsCountStack;
  function GetCellsCountStack: Tl3ProtoIntegerList;
  procedure PopCellsCount;
  procedure PushCellsCount;
  function GetTopValue: Integer;
  procedure IncTopValue;
 end;//_CellsCountStack_
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
