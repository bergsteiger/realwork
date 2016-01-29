unit kwPushMainForm;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwPushMainForm.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::EditorKeyWords::push_MainForm
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwPushMainForm = {final scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPushMainForm
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  Forms
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwPushMainForm

procedure TkwPushMainForm.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F8FE54E036E_var*
//#UC END# *4DAEEDE10285_4F8FE54E036E_var*
begin
//#UC START# *4DAEEDE10285_4F8FE54E036E_impl*
 Assert(Application.MainForm <> nil);
 aCtx.rEngine.PushObj(Application.MainForm);
//#UC END# *4DAEEDE10285_4F8FE54E036E_impl*
end;//TkwPushMainForm.DoDoIt

class function TkwPushMainForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'push:MainForm';
end;//TkwPushMainForm.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация push_MainForm
 TkwPushMainForm.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.