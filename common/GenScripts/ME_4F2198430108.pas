unit kwCompiledWordWorkerWordRunner;

interface

uses
 l3IntfUses
 , kwCompiledWordWorker
 , tfwScriptingInterfaces
 , tfwWordRefList
 , tfwTypeInfo
;

type
 RkwCompiledWordWorkerWordRunner = class of TkwCompiledWordWorkerWordRunner;
 
 TkwCompiledWordWorkerWordRunner = class(TkwCompiledWordWorker)
  procedure PushState(const aCtx: TtfwContext);
  procedure PushWordToWork(const aCtx: TtfwContext);
  procedure DoCode(const aCtx: TtfwContext);
  function ReturnsRef(const aCtx: TtfwContext): Boolean;
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCompiledWordWorkerWordRunner
 
implementation

uses
 l3ImplUses
 , SysUtils
 , kwRuntimeWordWithCode
 , tfwClassRef
;

end.
