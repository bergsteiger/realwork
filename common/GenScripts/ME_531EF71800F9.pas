unit k2InterfaceCache;

interface

uses
 l3IntfUses
 , k2InterfaceList
 , k2ToolPrim
;

type
 Tk2InterfaceCache = object(Tk2InterfaceList)
 end;//Tk2InterfaceCache
 
implementation

uses
 l3ImplUses
 , k2ToolCacheList
 , k2ToolPrimList
 , SysUtils
 , l3ProtoObject
 , l3ProtoObjectRefList
;

end.
