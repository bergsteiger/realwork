unit kwElse;

interface

uses
 l3IntfUses
 , tfwWordWorker
 , kwCompiledWordWorker
 , tfwScriptingInterfaces
 , kwCompiledWordPrim
;

type
 TkwElse = class(TtfwWordWorker)
  function CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker;
 end;//TkwElse
 
implementation

uses
 l3ImplUses
 , kwCompiledWord
 , kwCompiledIfElse
;

end.
