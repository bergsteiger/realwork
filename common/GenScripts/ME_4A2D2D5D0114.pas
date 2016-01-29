unit evCursorPair;

interface

uses
 l3IntfUses
 , evSelection
 , nevTools
 , l3IID
 , nevBase
 , l3Interfaces
 , k2ToolPrim
;

type
 TevCursorPair = class(TevRange)
  {* Базовый класс для реализации выделения }
  procedure GetBlockBorders;
  function IsSolid(const aView: InevView): Boolean;
 end;//TevCursorPair
 
implementation

uses
 l3ImplUses
 , l3Const
 , k2TagGen
 , l3MinMax
 , evCursor
 , nevPersistentDocumentContainer
 , evTypes
 , evExcept
 , nevInterfaces
 , SysUtils
;

end.
