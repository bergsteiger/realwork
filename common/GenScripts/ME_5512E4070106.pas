unit tfwWordWorkerEx;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwWordWorkerEx.pas"
// Стереотип: "SimpleClass"

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
 TtfwWordWorkerEx = {abstract} class(TtfwWordWorker)
  protected
   function CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker; override;
 end;//TtfwWordWorkerEx
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwCompiledWordWorkerEx
;

function TtfwWordWorkerEx.CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker;
//#UC START# *4DCBD67C0362_5512E4070106_var*
//#UC END# *4DCBD67C0362_5512E4070106_var*
begin
//#UC START# *4DCBD67C0362_5512E4070106_impl*
 Result := TkwCompiledWordWorkerEx;
//#UC END# *4DCBD67C0362_5512E4070106_impl*
end;//TtfwWordWorkerEx.CompiledWorkerClass

initialization
 TtfwWordWorkerEx.RegisterClass;
 {* Регистрация TtfwWordWorkerEx }
{$IfEnd} // NOT Defined(NoScripts)

end.
