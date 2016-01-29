unit kwOpenInsDWin;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwOpenInsDWin.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwOpenInsDWin
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
 TkwOpenInsDWin = {scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwOpenInsDWin
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestsAdapter
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwOpenInsDWin

procedure TkwOpenInsDWin.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E2448BD014D_var*
//#UC END# *4DAEEDE10285_4E2448BD014D_var*
begin
//#UC START# *4DAEEDE10285_4E2448BD014D_impl*
 AcOpenInsDWin;
//#UC END# *4DAEEDE10285_4E2448BD014D_impl*
end;//TkwOpenInsDWin.DoDoIt

class function TkwOpenInsDWin.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'редактор_словарей';
end;//TkwOpenInsDWin.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация TkwOpenInsDWin
 TkwOpenInsDWin.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.