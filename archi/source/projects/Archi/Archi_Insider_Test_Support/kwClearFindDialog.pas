unit kwClearFindDialog;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwClearFindDialog.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::EverestArchiWords::ClearFindDialog
//
// Очищает диалог поиска (удаляет его объект).
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
 TkwClearFindDialog = {final scriptword} class(TtfwRegisterableWord)
  {* Очищает диалог поиска (удаляет его объект). }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwClearFindDialog
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  D_TxSrch
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwClearFindDialog

procedure TkwClearFindDialog.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_533433C700C0_var*
//#UC END# *4DAEEDE10285_533433C700C0_var*
begin
//#UC START# *4DAEEDE10285_533433C700C0_impl*
 TTextSearchDlg.ClearFindWindow
//#UC END# *4DAEEDE10285_533433C700C0_impl*
end;//TkwClearFindDialog.DoDoIt

class function TkwClearFindDialog.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ClearFindDialog';
end;//TkwClearFindDialog.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация ClearFindDialog
 TkwClearFindDialog.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.