unit kwCompiledWordWorkerEx;

interface

uses
 l3IntfUses
 , kwCompiledWordWorker
 , tfwScriptingInterfaces
 , tfwAnonimousWord
;

type
 TkwCompiledWordWorkerEx = class(TkwCompiledWordWorker)
  procedure DoDoIt(const aCtx: TtfwContext);
  function GetWordToRun: TtfwAnonimousWord;
 end;//TkwCompiledWordWorkerEx
 
implementation

uses
 l3ImplUses
 , tfwWordWorker
;

end.
