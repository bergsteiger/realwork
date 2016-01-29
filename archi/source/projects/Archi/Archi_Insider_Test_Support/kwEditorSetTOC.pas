unit kwEditorSetTOC;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwEditorSetTOC.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwEditorSetTOC
//
// редактор:установить_оглавление
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
 TkwEditorSetTOC = {scriptword} class(TtfwRegisterableWord)
  {* редактор:установить_оглавление }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwEditorSetTOC
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestsAdapter
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwEditorSetTOC

procedure TkwEditorSetTOC.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4ECB504D000B_var*
var
 l_BlockID: Integer;
//#UC END# *4DAEEDE10285_4ECB504D000B_var*
begin
//#UC START# *4DAEEDE10285_4ECB504D000B_impl*
 if aCtx.rEngine.IsTopInt then
  l_BlockID := aCtx.rEngine.PopInt
 else
  Assert(False, 'Не задан номер блока!');
 ArSetContentsSub(l_BlockID);
//#UC END# *4DAEEDE10285_4ECB504D000B_impl*
end;//TkwEditorSetTOC.DoDoIt

class function TkwEditorSetTOC.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'редактор:установить_оглавление';
end;//TkwEditorSetTOC.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация TkwEditorSetTOC
 TkwEditorSetTOC.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.