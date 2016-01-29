unit kwGetActiveEditorPageName;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwGetActiveEditorPageName.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwGetActiveEditorPageName
//
// *Формат:* main_form:GetActivePageName
// *Описание:* Помещает в стек номер активной вкладки в окне редактирования документа.
// *Примечания:*
// Константы с номерами вкладок находятся в файле:
// {code}
// w:\archi\source\projects\Archi\TestSet\Dictionary\ArchiControls.script"
// {code}
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
 TkwGetActiveEditorPageName = {scriptword} class(TtfwRegisterableWord)
  {* *Формат:* main_form:GetActivePageName
*Описание:* Помещает в стек номер активной вкладки в окне редактирования документа.
*Примечания:*
 Константы с номерами вкладок находятся в файле:
[code]
  w:\archi\source\projects\Archi\TestSet\Dictionary\ArchiControls.script"
[code] }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwGetActiveEditorPageName
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(AppClientSide)}
  ,
  Editwin
  {$IfEnd} //AppClientSide
  
  {$If defined(AppClientSide)}
  ,
  Main
  {$IfEnd} //AppClientSide
  
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwGetActiveEditorPageName

procedure TkwGetActiveEditorPageName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E60CB00004F_var*
//#UC END# *4DAEEDE10285_4E60CB00004F_var*
begin
//#UC START# *4DAEEDE10285_4E60CB00004F_impl*
 aCtx.rEngine.PushString((MainForm.ActiveMDIChild as TDocEditorWindow).nbkDocPages.ActivePageName);
//#UC END# *4DAEEDE10285_4E60CB00004F_impl*
end;//TkwGetActiveEditorPageName.DoDoIt

class function TkwGetActiveEditorPageName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'main_form:GetActivePageName';
end;//TkwGetActiveEditorPageName.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация TkwGetActiveEditorPageName
 TkwGetActiveEditorPageName.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.