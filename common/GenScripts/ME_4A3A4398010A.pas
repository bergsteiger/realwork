unit evParaListCursorInsertable;

interface

uses
 l3IntfUses
 , evParaListCursorPrim
 , nevTools
 , nevBase
 , l3Variant
;

type
 TevParaListCursorInsertable = class(TevParaListCursorPrim, IevOpInsertPara)
  function DoIt(const anOpPack: InevOp;
   aPara: Tl3Variant;
   aFlags: TevInsertParaFlags): Boolean;
 end;//TevParaListCursorInsertable
 
implementation

uses
 l3ImplUses
;

end.
