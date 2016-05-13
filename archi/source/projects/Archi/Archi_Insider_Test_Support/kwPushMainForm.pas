unit kwPushMainForm;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwPushMainForm.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "push_MainForm" MUID: (4F8FE54E036E)
// Имя типа: "TkwPushMainForm"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwPushMainForm = {final} class(TtfwRegisterableWord)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwPushMainForm
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

class function TkwPushMainForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'push:MainForm';
end;//TkwPushMainForm.GetWordNameForRegister

procedure TkwPushMainForm.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F8FE54E036E_var*
//#UC END# *4DAEEDE10285_4F8FE54E036E_var*
begin
//#UC START# *4DAEEDE10285_4F8FE54E036E_impl*
 Assert(Application.MainForm <> nil);
 aCtx.rEngine.PushObj(Application.MainForm);
//#UC END# *4DAEEDE10285_4F8FE54E036E_impl*
end;//TkwPushMainForm.DoDoIt

initialization
 TkwPushMainForm.RegisterInEngine;
 {* Регистрация push_MainForm }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
