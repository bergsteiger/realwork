unit kwMainFormClearHistory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwMainFormClearHistory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::CommonArchiWords::MainForm_ClearHistory
//
// Очищает историю переходов по документам.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwMainFormClearHistory = {final scriptword} class(TtfwRegisterableWord)
  {* Очищает историю переходов по документам. }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwMainFormClearHistory
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  Main
  ;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwMainFormClearHistory

procedure TkwMainFormClearHistory.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5370939A008D_var*
//#UC END# *4DAEEDE10285_5370939A008D_var*
begin
//#UC START# *4DAEEDE10285_5370939A008D_impl*
 MainForm.ClearHistory;
//#UC END# *4DAEEDE10285_5370939A008D_impl*
end;//TkwMainFormClearHistory.DoDoIt

class function TkwMainFormClearHistory.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'MainForm:ClearHistory';
end;//TkwMainFormClearHistory.GetWordNameForRegister

{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация MainForm_ClearHistory
 TkwMainFormClearHistory.RegisterInEngine;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

end.