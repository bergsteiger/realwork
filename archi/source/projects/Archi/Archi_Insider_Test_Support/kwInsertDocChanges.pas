unit kwInsertDocChanges;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwInsertDocChanges.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwInsertDocChanges
//
// macros:InsertDocChanges
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
 TkwInsertDocChanges = {scriptword} class(TtfwRegisterableWord)
  {* macros:InsertDocChanges }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwInsertDocChanges
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestAdapter2
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwInsertDocChanges

procedure TkwInsertDocChanges.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E4BC07D0328_var*
//#UC END# *4DAEEDE10285_4E4BC07D0328_var*
begin
//#UC START# *4DAEEDE10285_4E4BC07D0328_impl*
 ArInsertDocChanges;
//#UC END# *4DAEEDE10285_4E4BC07D0328_impl*
end;//TkwInsertDocChanges.DoDoIt

class function TkwInsertDocChanges.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'macros:InsertDocChanges';
end;//TkwInsertDocChanges.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация TkwInsertDocChanges
 TkwInsertDocChanges.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.