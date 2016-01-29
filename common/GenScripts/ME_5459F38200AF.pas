unit m3HashHandle;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , m3BranchHandleList
;

type
 Tm3HashHandle = class(Tl3CProtoObject)
  procedure Create;
 end;//Tm3HashHandle
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
