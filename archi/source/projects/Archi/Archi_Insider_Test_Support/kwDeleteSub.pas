unit kwDeleteSub;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwDeleteSub.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwDeleteSub
//
// окно_редактора:удалить_саб
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
 TkwDeleteSub = {scriptword} class(TtfwRegisterableWord)
  {* окно_редактора:удалить_саб }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDeleteSub
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestsAdapter
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwDeleteSub

procedure TkwDeleteSub.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E01AD1F02CA_var*
//#UC END# *4DAEEDE10285_4E01AD1F02CA_var*
begin
//#UC START# *4DAEEDE10285_4E01AD1F02CA_impl*
 if aCtx.rEngine.IsTopInt then
  arDeleteSub(aCtx.rEngine.PopInt);
//#UC END# *4DAEEDE10285_4E01AD1F02CA_impl*
end;//TkwDeleteSub.DoDoIt

class function TkwDeleteSub.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'окно_редактора:удалить_саб';
end;//TkwDeleteSub.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация TkwDeleteSub
 TkwDeleteSub.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.