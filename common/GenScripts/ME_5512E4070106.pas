unit tfwWordWorkerEx;

interface

uses
 l3IntfUses
 , tfwWordWorker
 , kwCompiledWordWorker
 , tfwScriptingInterfaces
;

type
 TtfwWordWorkerEx = class(TtfwWordWorker)
  function CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker;
 end;//TtfwWordWorkerEx
 
implementation

uses
 l3ImplUses
 , kwCompiledWordWorkerEx
;

end.
