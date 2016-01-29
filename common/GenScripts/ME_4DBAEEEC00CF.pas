unit kwCompiledCase;

interface

uses
 l3IntfUses
 , kwRuntimeWordWithCode
 , tfwScriptingInterfaces
;

type
 TkwCompiledCase = class(TkwRuntimeWordWithCode)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCompiledCase
 
implementation

uses
 l3ImplUses
 , tfwClassRef
;

end.
