unit kwSearchWinSaveDocumentList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwSearchWinSaveDocumentList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::CommonArchiWords::SearchWin_SaveDocumentList
//
// Формат:
// {code}
// aFileName SearchWin:SaveDocumentList
// {code}
// Сохраняет список документов в файл aFileName. Аналоична команде "Сохранить как..." в окне
// выборке. Окно выборки должно быть активно.
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
 TkwSearchWinSaveDocumentList = {final scriptword} class(TtfwRegisterableWord)
  {* Формат: 
[code]
aFileName SearchWin:SaveDocumentList
[code]
Сохраняет список документов в файл aFileName. Аналоична команде "Сохранить как..." в окне выборке. Окно выборки должно быть активно. }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwSearchWinSaveDocumentList
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestAdapter2
  ;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwSearchWinSaveDocumentList

procedure TkwSearchWinSaveDocumentList.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_537076040297_var*
var
 l_FileName: AnsiString;
//#UC END# *4DAEEDE10285_537076040297_var*
begin
//#UC START# *4DAEEDE10285_537076040297_impl*
 RunnerAssert(aCtx.rEngine.IsTopString, 'Не задано расширение!', aCtx);
 l_FileName := aCtx.rEngine.PopDelphiString;
 l_FileName := aCtx.rCaller.ResolveInputFilePath(l_FileName);
 AcSaveDocAs(l_FileName);
//#UC END# *4DAEEDE10285_537076040297_impl*
end;//TkwSearchWinSaveDocumentList.DoDoIt

class function TkwSearchWinSaveDocumentList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'SearchWin:SaveDocumentList';
end;//TkwSearchWinSaveDocumentList.GetWordNameForRegister

{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация SearchWin_SaveDocumentList
 TkwSearchWinSaveDocumentList.RegisterInEngine;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

end.