unit kwScriptCompileAndProcess;

interface

uses
 l3IntfUses
 , tfwWordWorker
 , kwCompiledWordWorker
 , tfwScriptingInterfaces
;

type
 TkwScriptCompileAndProcess = class(TtfwWordWorker)
  {* ����������� ������ � ������������ ��� ��������� ������� }
  function CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker;
 end;//TkwScriptCompileAndProcess
 
implementation

uses
 l3ImplUses
 , kwCompiledScriptCompileAndProcess
;

end.
