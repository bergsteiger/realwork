unit kwCompiledTryExcept;
 {* Скомпилированная версия try except }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledTryExcept.pas"
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
 TkwCompiledTryExcept = class(TkwDualCompiledWordContainer)
  {* Скомпилированная версия try except }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwCompiledTryExcept
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , StrUtils
;

procedure TkwCompiledTryExcept.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DBADEE702A8_var*
var
 l_Ctx : TtfwContext;
 l_WasException : Boolean;
//#UC END# *4DAEEDE10285_4DBADEE702A8_var*
begin
//#UC START# *4DAEEDE10285_4DBADEE702A8_impl*
 try
  WordToWork.DoIt(aCtx);
 except
  on EtfwCodeFlowException do
   raise;
  on E : Exception do
  begin
   l_Ctx := aCtx;
   l_WasException := false;
   try
    l_Ctx.rException := E;
    try
     f_ElseBranch.DoIt(l_Ctx);
    except
     l_WasException := true;
     raise;
    end;//try..except
   finally
    if not l_WasException then
     aCtx.rEngine.WordSuccess;
    Finalize(l_Ctx);
   end;//try..finally
  end;//on E : Exception
 end;//try..except
//#UC END# *4DAEEDE10285_4DBADEE702A8_impl*
end;//TkwCompiledTryExcept.DoDoIt

initialization
 TkwCompiledTryExcept.RegisterClass;
 {* Регистрация TkwCompiledTryExcept }
{$IfEnd} // NOT Defined(NoScripts)

end.
