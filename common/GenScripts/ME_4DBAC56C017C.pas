unit kwCompiledTryFinally;

interface

uses
 l3IntfUses
 , kwDualCompiledWordContainer
 , tfwScriptingInterfaces
;

type
 TkwCompiledTryFinally = class(TkwDualCompiledWordContainer)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCompiledTryFinally
 
implementation

uses
 l3ImplUses
 , tfwClassRef
;

end.
