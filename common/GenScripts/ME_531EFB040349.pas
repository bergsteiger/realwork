unit k2ToolCacheList;

interface

uses
 l3IntfUses
 , k2ToolPrimList
 , k2ToolPrim
;

type
 Tk2ToolCacheList = class(Tk2ToolPrimList)
  function GetFree: Tk2ToolPrim;
 end;//Tk2ToolCacheList
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
