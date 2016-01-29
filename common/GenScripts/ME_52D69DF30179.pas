unit kwRuntimeWordWithCodeExecution;

interface

uses
 l3IntfUses
 , kwRuntimeWordWithCode
 , tfwScriptingInterfaces
;

type
 TkwRuntimeWordWithCodeExecution = class(TkwRuntimeWordWithCode)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwRuntimeWordWithCodeExecution
 
implementation

uses
 l3ImplUses
;

end.
