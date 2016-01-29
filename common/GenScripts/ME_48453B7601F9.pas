unit evCursorTools;

interface

uses
 l3IntfUses
 , nevTools
 , l3Variant
 , l3Types
 , k2Base
 , evInternalInterfaces
 , nevBase
;

type
 TevBool2FlagsAtEnd = array [Boolean] of TevInsertParaFlags;
 
implementation

uses
 l3ImplUses
 , SysUtils
 , k2OpMisc
 , evMsgCode
 , l3Base
 , evOp
 , k2Tags
 , k2InterfaceFactory
 , nevFacade
;

end.
