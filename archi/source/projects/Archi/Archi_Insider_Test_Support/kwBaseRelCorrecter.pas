unit kwBaseRelCorrecter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwBaseRelCorrecter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::CommonArchiWords::base_RelCorrecter
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
 TkwBaseRelCorrecter = {final scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwBaseRelCorrecter
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestAdapter2
  ;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwBaseRelCorrecter

procedure TkwBaseRelCorrecter.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_526E5B5D033B_var*
var
 l_FileName: AnsiString;
//#UC END# *4DAEEDE10285_526E5B5D033B_var*
begin
//#UC START# *4DAEEDE10285_526E5B5D033B_impl*
 RunnerAssert(aCtx.rEngine.IsTopString, 'Не задано имя файла!', aCtx);
 l_FileName := aCtx.rEngine.PopDelphiString;
 l_FileName := aCtx.rCaller.ResolveInputFilePath(l_FileName);
 acCorrectRelatedText(l_FileName);
//#UC END# *4DAEEDE10285_526E5B5D033B_impl*
end;//TkwBaseRelCorrecter.DoDoIt

class function TkwBaseRelCorrecter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'base:RelCorrecter';
end;//TkwBaseRelCorrecter.GetWordNameForRegister

{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация base_RelCorrecter
 TkwBaseRelCorrecter.RegisterInEngine;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

end.