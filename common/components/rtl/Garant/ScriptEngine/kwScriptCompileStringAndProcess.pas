unit kwScriptCompileStringAndProcess;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwScriptCompileStringAndProcess.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "script_CompileStringAndProcess" MUID: (56420D340374)
// Имя типа: "TkwScriptCompileStringAndProcess"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

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
 //#UC START# *56420D340374impl_uses*
 //#UC END# *56420D340374impl_uses*
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
