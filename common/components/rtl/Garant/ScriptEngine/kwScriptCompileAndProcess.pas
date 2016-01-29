unit kwScriptCompileAndProcess;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine"
// ������: "kwScriptCompileAndProcess.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi Low Level::ScriptEngine::ScriptsCompilingAndProcessing::script_CompileAndProcess
//
// ����������� ������ � ������������ ��� ��������� �������
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwWordWorker,
  tfwScriptingInterfaces,
  kwCompiledWordWorker
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwScriptCompileAndProcess = {final scriptword} class(TtfwWordWorker)
  {* ����������� ������ � ������������ ��� ��������� ������� }
 protected
 // realized methods
   function CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker; override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwScriptCompileAndProcess
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  kwCompiledScriptCompileAndProcess
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwScriptCompileAndProcess

function TkwScriptCompileAndProcess.CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker;
//#UC START# *4DCBD67C0362_53DA248C0014_var*
//#UC END# *4DCBD67C0362_53DA248C0014_var*
begin
//#UC START# *4DCBD67C0362_53DA248C0014_impl*
 Result := TkwCompiledScriptcompileAndProcess;
//#UC END# *4DCBD67C0362_53DA248C0014_impl*
end;//TkwScriptCompileAndProcess.CompiledWorkerClass

class function TkwScriptCompileAndProcess.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'script:CompileAndProcess';
end;//TkwScriptCompileAndProcess.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� script_CompileAndProcess
 TkwScriptCompileAndProcess.RegisterInEngine;
{$IfEnd} //not NoScripts

end.