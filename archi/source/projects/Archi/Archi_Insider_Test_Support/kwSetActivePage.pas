unit kwSetActivePage;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwSetActivePage.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwSetActivePage
//
// *Формат:* ID_вкладки окно_редактора:перейти_на_вкладку
// *Описание:* Делает активной вкладку с номером ID_вкладки.
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
 TkwSetActivePage = {scriptword} class(TtfwRegisterableWord)
  {* *Формат:* ID_вкладки окно_редактора:перейти_на_вкладку
*Описание:* Делает активной вкладку с номером ID_вкладки.
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
 end;//TkwSetActivePage
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestsAdapter
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwSetActivePage

procedure TkwSetActivePage.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4EAFC7190370_var*
//#UC END# *4DAEEDE10285_4EAFC7190370_var*
begin
//#UC START# *4DAEEDE10285_4EAFC7190370_impl*
 if aCtx.rEngine.IsTopInt then
  AcSetActivePage(aCtx.rEngine.PopInt)
 else
  Assert(False, 'Не задан номер вкладки!');
//#UC END# *4DAEEDE10285_4EAFC7190370_impl*
end;//TkwSetActivePage.DoDoIt

class function TkwSetActivePage.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'окно_редактора:перейти_на_вкладку';
end;//TkwSetActivePage.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация TkwSetActivePage
 TkwSetActivePage.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.