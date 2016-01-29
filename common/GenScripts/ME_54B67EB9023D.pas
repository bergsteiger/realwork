unit l3SimpleMemoryManagerPrim;

interface

uses
 l3IntfUses
 , Refcounted
;

type
 Tl3SimpleMemoryManagerPrim = class(TRefcounted)
  procedure Create;
 end;//Tl3SimpleMemoryManagerPrim
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
