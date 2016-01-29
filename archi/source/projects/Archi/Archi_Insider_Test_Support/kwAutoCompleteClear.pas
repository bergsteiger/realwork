unit kwAutoCompleteClear;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwAutoCompleteClear.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::EverestArchiWords::AutoComplete_Clear
//
// Очищает данные автозамены.
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
 TkwAutoCompleteClear = {final scriptword} class(TtfwRegisterableWord)
  {* Очищает данные автозамены. }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwAutoCompleteClear
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(k2ForEditor)}
  ,
  evAutoComplete
  {$IfEnd} //k2ForEditor
  
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwAutoCompleteClear

procedure TkwAutoCompleteClear.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53CD0A6A03DF_var*
//#UC END# *4DAEEDE10285_53CD0A6A03DF_var*
begin
//#UC START# *4DAEEDE10285_53CD0A6A03DF_impl*
 if AutoComplete <> nil then
  AutoComplete.ClearDataAndSave;
//#UC END# *4DAEEDE10285_53CD0A6A03DF_impl*
end;//TkwAutoCompleteClear.DoDoIt

class function TkwAutoCompleteClear.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'AutoComplete:Clear';
end;//TkwAutoCompleteClear.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация AutoComplete_Clear
 TkwAutoCompleteClear.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.