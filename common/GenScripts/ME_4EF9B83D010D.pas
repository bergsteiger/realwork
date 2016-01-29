unit evTableCursorPrim;

interface

uses
 l3IntfUses
 , evParaListCursor
 , evInternalInterfaces
 , nevTools
 , nevBase
 , l3Interfaces
 , l3Types
 , l3IID
;

type
 TevTableCursorPrim = class(TevParaListCursor, IevChangeParamTool)
  function ChangeParam(const aMarker: IevMarker;
   aValue: Integer;
   const anOpPack: InevOp;
   SeeByLevel: Boolean;
   aMinIndex: Tl3Index;
   aMaxIndex: Tl3Index): Boolean;
   {* Изменить значение параметра }
 end;//TevTableCursorPrim
 
implementation

uses
 l3ImplUses
 , SysUtils
 , evdTypes
 , l3Units
 , k2Interfaces
 , l3MinMax
 , evConst
 , nevInterfaces
 , evTableMarker
 , k2Tags
 , l3Variant
;

end.
