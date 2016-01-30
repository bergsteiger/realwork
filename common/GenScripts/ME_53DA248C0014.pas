unit kwScriptCompileAndProcess;
 {* Компилирует скрипт и обрабатывает его указанной лямбдой }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwScriptCompileAndProcess.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwWordWorker
 , kwCompiledWordWorker
 , tfwScriptingInterfaces
;

type
 TkwScriptCompileAndProcess = {final} class(TtfwWordWorker)
  {* Компилирует скрипт и обрабатывает его указанной лямбдой }
  protected
   function CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwScriptCompileAndProcess
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwCompiledScriptCompileAndProcess
;

function TkwScriptCompileAndProcess.CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker;
//#UC START# *4DCBD67C0362_53DA248C0014_var*
//#UC END# *4DCBD67C0362_53DA248C0014_var*
begin
//#UC START# *4DCBD67C0362_53DA248C0014_impl*
 Result := TkwCompiledScriptcompileAndProcess;
//#UC END# *4DCBD67C0362_53DA248C0014_impl*
end;//TkwScriptCompileAndProcess.CompiledWorkerClass

class function TkwScriptCompileAndProcess.GetWordNameForRegister: AnsiString;
begin
 Result := 'script:CompileAndProcess';
end;//TkwScriptCompileAndProcess.GetWordNameForRegister

initialization
 TkwScriptCompileAndProcess.RegisterInEngine;
 {* Регистрация script_CompileAndProcess }
{$IfEnd} // NOT Defined(NoScripts)

end.
