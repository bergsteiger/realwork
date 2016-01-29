unit kwMakeChangeDoc;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwMakeChangeDoc.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwMakeChangeDoc
//
// macros:MakeChangeDoc
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
 TkwMakeChangeDoc = {scriptword} class(TtfwRegisterableWord)
  {* macros:MakeChangeDoc }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwMakeChangeDoc
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestAdapter2
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwMakeChangeDoc

procedure TkwMakeChangeDoc.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E4BBADC02A0_var*
//#UC END# *4DAEEDE10285_4E4BBADC02A0_var*
begin
//#UC START# *4DAEEDE10285_4E4BBADC02A0_impl*
 ArMakeChangeDoc;
//#UC END# *4DAEEDE10285_4E4BBADC02A0_impl*
end;//TkwMakeChangeDoc.DoDoIt

class function TkwMakeChangeDoc.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'macros:MakeChangeDoc';
end;//TkwMakeChangeDoc.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация TkwMakeChangeDoc
 TkwMakeChangeDoc.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.