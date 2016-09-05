unit kwCompiledIF;
 {* Внутренняя скомпилированная версия IF. }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledIF.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwCompiledIF" MUID: (4DB6EE250251)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwDualCompiledWordContainer
 , tfwScriptingInterfaces
;

type
 TkwCompiledIF = class(TkwDualCompiledWordContainer)
  {* Внутренняя скомпилированная версия IF. }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwCompiledIF
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *4DB6EE250251impl_uses*
 //#UC END# *4DB6EE250251impl_uses*
;

procedure TkwCompiledIF.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DB6EE250251_var*
//#UC END# *4DAEEDE10285_4DB6EE250251_var*
begin
//#UC START# *4DAEEDE10285_4DB6EE250251_impl*
 if aCtx.rEngine.PopBool then
  WordToWork.DoIt(aCtx)
 else
 if (f_ElseBranch <> nil) then
  f_ElseBranch.DoIt(aCtx);
//#UC END# *4DAEEDE10285_4DB6EE250251_impl*
end;//TkwCompiledIF.DoDoIt

initialization
 TkwCompiledIF.RegisterClass;
 {* Регистрация TkwCompiledIF }
{$IfEnd} // NOT Defined(NoScripts)

end.
