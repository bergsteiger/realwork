unit kwCompiledRules;

interface

uses
 l3IntfUses
 , kwRuntimeWordWithCode
 , tfwScriptingInterfaces
;

type
 TkwCompiledRules = class(TkwRuntimeWordWithCode)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCompiledRules
 
implementation

uses
 l3ImplUses
 , tfwClassRef
;

end.
