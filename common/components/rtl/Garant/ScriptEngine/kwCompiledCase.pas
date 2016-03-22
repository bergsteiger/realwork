unit kwCompiledCase;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledCase.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwCompiledCase" MUID: (4DBAEEEC00CF)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwRuntimeWordWithCode
 , tfwScriptingInterfaces
;

type
 TkwCompiledCase = class(TkwRuntimeWordWithCode)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwCompiledCase
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwClassRef
;

procedure TkwCompiledCase.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DBAEEEC00CF_var*
var
 l_V : Integer;
 l_I : Integer;
 l_C : Integer;
//#UC END# *4DAEEDE10285_4DBAEEEC00CF_var*
begin
//#UC START# *4DAEEDE10285_4DBAEEEC00CF_impl*
 l_V := aCtx.rEngine.PopInt;
 l_I := 0;
 l_C := Code.Count - 1;
 while (l_I < l_C) do
 begin
  if Code[l_I].IsDefaultBranch then
  begin
   Code[l_I + 1].DoIt(aCtx);
   break;
  end//Code[l_I].IsDefaultBranch
  else
  begin
   Code[l_I].DoIt(aCtx);
   if (aCtx.rEngine.PopInt = l_V) then
   begin
    Code[l_I + 1].DoIt(aCtx);
    break;
   end;//aCtx.rEngine.PopInt = l_V
  end;//Code[l_I].IsDefaultBranch
  Inc(l_I, 2);
 end;//l_I < l_C
//#UC END# *4DAEEDE10285_4DBAEEEC00CF_impl*
end;//TkwCompiledCase.DoDoIt

initialization
 TkwCompiledCase.RegisterClass;
 {* Регистрация TkwCompiledCase }
{$IfEnd} // NOT Defined(NoScripts)

end.
