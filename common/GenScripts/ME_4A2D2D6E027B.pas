unit evParaListCursorPair;

interface

uses
 l3IntfUses
 , evCursorPair
 , nevTools
 , l3Variant
 , l3IID
 , l3Interfaces
 , l3Core
 , nevBase
 , k2Interfaces
;

type
 TevParaListCursorPair = class(TevCursorPair)
  {* Выделение для списка параграфов }
  function GetParaBlockBordersPrim(const aChildPara: InevPara;
   aPID: LongInt;
   out cParaStart: InevBasePoint;
   out cParaFinish: InevBasePoint): Boolean;
  procedure ArrangeFoundCursors(anIndex: LongInt;
   var theStart: InevBasePoint;
   var theFinish: InevBasePoint);
 end;//TevParaListCursorPair
 
implementation

uses
 l3ImplUses
 , SysUtils
 , Classes
 , l3MinMax
 , l3Base
 , nevFacade
 , k2Base
 , afwFacade
 , l3InterfacesMisc
 , k2Tags
 , nevNavigation
 , ParaList_Const
 , evdInterfaces
 , k2BaseTypes
 , evParaPackOperation
 , k2OpMisc
 , evdStyles
 , evOp
 , TextPara_Const
 , evParaTools
 , evCursorTools
 , evCursorConst
 , evTypes
 , nevInterfaces
 , l3Const
 , evParaListCursorPrim
;

end.
