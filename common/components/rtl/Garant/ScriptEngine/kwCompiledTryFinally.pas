unit kwCompiledTryFinally;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledTryFinally.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwDualCompiledWordContainer
 , tfwScriptingInterfaces
;

type
 TkwCompiledTryFinally = class(TkwDualCompiledWordContainer)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwCompiledTryFinally
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwClassRef
;

procedure TkwCompiledTryFinally.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DBAC56C017C_var*
//#UC END# *4DAEEDE10285_4DBAC56C017C_var*
begin
//#UC START# *4DAEEDE10285_4DBAC56C017C_impl*
 try
  WordToWork.DoIt(aCtx);
 finally
  f_ElseBranch.DoIt(aCtx);
 end;//try..finally
//#UC END# *4DAEEDE10285_4DBAC56C017C_impl*
end;//TkwCompiledTryFinally.DoDoIt

initialization
 TkwCompiledTryFinally.RegisterClass;
 {* Регистрация TkwCompiledTryFinally }
{$IfEnd} // NOT Defined(NoScripts)

end.
