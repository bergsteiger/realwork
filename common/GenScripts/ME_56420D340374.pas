unit kwScriptCompileStringAndProcess;

interface

uses
 l3IntfUses
 , tfwWordWorker
 , kwCompiledWordWorker
 , tfwScriptingInterfaces
;

type
 TkwScriptCompileStringAndProcess = class(TtfwWordWorker)
  function CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker;
 end;//TkwScriptCompileStringAndProcess
 
implementation

uses
 l3ImplUses
 , kwCompiledScriptCompileStringAndProcess
;

end.
