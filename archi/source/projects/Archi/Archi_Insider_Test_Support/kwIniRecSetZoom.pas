unit kwIniRecSetZoom;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwIniRecSetZoom.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwIniRecSetZoom
//
// IniRec:SetZoom
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
 TkwIniRecSetZoom = {scriptword} class(TtfwRegisterableWord)
  {* IniRec:SetZoom }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwIniRecSetZoom
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestAdapter2
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwIniRecSetZoom

procedure TkwIniRecSetZoom.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E83072D01FF_var*
//#UC END# *4DAEEDE10285_4E83072D01FF_var*
begin
//#UC START# *4DAEEDE10285_4E83072D01FF_impl*
 if aCtx.rEngine.IsTopInt then
  ArIniRecSetZoom(aCtx.rEngine.PopInt)
 else
  Assert(False, 'Значение Zoom должно быть в виде числа!');
//#UC END# *4DAEEDE10285_4E83072D01FF_impl*
end;//TkwIniRecSetZoom.DoDoIt

class function TkwIniRecSetZoom.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'IniRec:SetZoom';
end;//TkwIniRecSetZoom.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация TkwIniRecSetZoom
 TkwIniRecSetZoom.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.