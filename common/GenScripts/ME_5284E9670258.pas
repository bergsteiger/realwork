unit kwIfElse;

interface

uses
 l3IntfUses
 , tfwWordWorker
 , kwCompiledWordWorker
 , tfwScriptingInterfaces
 , kwCompiledWordPrim
;

type
 TkwIfElse = class(TtfwWordWorker)
  function CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker;
 end;//TkwIfElse
 
implementation

uses
 l3ImplUses
 , kwCompiledIfElse
 , kwTemporaryCompiledCode
;

end.
