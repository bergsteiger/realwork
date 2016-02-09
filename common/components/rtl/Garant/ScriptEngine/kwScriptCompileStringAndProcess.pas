unit kwScriptCompileStringAndProcess;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwScriptCompileStringAndProcess.pas"
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
 TkwScriptCompileStringAndProcess = {final} class(TtfwWordWorker)
  protected
   function CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwScriptCompileStringAndProcess
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwCompiledScriptCompileStringAndProcess
;

function TkwScriptCompileStringAndProcess.CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker;
//#UC START# *4DCBD67C0362_56420D340374_var*
//#UC END# *4DCBD67C0362_56420D340374_var*
begin
//#UC START# *4DCBD67C0362_56420D340374_impl*
 Result := TkwCompiledScriptCompileStringAndProcess;
//#UC END# *4DCBD67C0362_56420D340374_impl*
end;//TkwScriptCompileStringAndProcess.CompiledWorkerClass

class function TkwScriptCompileStringAndProcess.GetWordNameForRegister: AnsiString;
begin
 Result := 'script:CompileStringAndProcess';
end;//TkwScriptCompileStringAndProcess.GetWordNameForRegister

initialization
 TkwScriptCompileStringAndProcess.RegisterInEngine;
 {* Регистрация script_CompileStringAndProcess }
{$IfEnd} // NOT Defined(NoScripts)

end.
