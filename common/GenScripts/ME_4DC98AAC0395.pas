unit kwCompiledIncluded;

interface

uses
 l3IntfUses
 , kwCompiledWordPrim
 , tfwScriptingInterfaces
;

type
 TkwCompiledIncluded = class(TkwCompiledWordPrim)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCompiledIncluded
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
