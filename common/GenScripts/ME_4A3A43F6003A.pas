unit evParaListCursorDeletable;

interface

uses
 l3IntfUses
 , evParaListCursorInsertable
 , nevTools
 , nevBase
;

type
 TevParaListCursorDeletable = class(TevParaListCursorInsertable, IevOpDeletePara)
  function DoIt(const anOpPack: InevOp;
   aFlags: TevDeleteParaFlags): Boolean;
 end;//TevParaListCursorDeletable
 
implementation

uses
 l3ImplUses
 , evParaListCursorPrim
 , evOp
 , evCursorConst
 , evCursorTools
 , l3Base
 , k2Facade
 , k2Interfaces
 , SysUtils
 , l3Variant
;

end.
