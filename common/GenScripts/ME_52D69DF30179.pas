unit kwRuntimeWordWithCodeExecution;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwRuntimeWordWithCodeExecution.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwRuntimeWordWithCode
 , tfwScriptingInterfaces
;

type
 TkwRuntimeWordWithCodeExecution = class(TkwRuntimeWordWithCode)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwRuntimeWordWithCodeExecution
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TkwRuntimeWordWithCodeExecution.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_52D69DF30179_var*
//#UC END# *4DAEEDE10285_52D69DF30179_var*
begin
//#UC START# *4DAEEDE10285_52D69DF30179_impl*
 RunCode(aCtx);
//#UC END# *4DAEEDE10285_52D69DF30179_impl*
end;//TkwRuntimeWordWithCodeExecution.DoDoIt

initialization
 TkwRuntimeWordWithCodeExecution.RegisterClass;
 {* Регистрация TkwRuntimeWordWithCodeExecution }
{$IfEnd} // NOT Defined(NoScripts)

end.
