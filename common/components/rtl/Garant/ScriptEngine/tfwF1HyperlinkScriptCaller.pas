unit tfwF1HyperlinkScriptCaller;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$Core"
// Модуль: "tfwF1HyperlinkScriptCaller.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Core::ScriptCallers::TtfwF1HyperlinkScriptCaller
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwAxiomaticsResNameGetter,
  tfwHyperlinkScriptCaller
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TtfwF1HyperlinkScriptCaller = class(TtfwHyperlinkScriptCaller)
 protected
 // overridden protected methods
   function DoResolveIncludedFilePath(const aFile: AnsiString): AnsiString; override;
 end;//TtfwF1HyperlinkScriptCaller
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}

type
//#UC START# *77DB2124A8AEci*
//#UC END# *77DB2124A8AEci*
//#UC START# *77DB2124A8AEcit*
//#UC END# *77DB2124A8AEcit*
  TtfwF1HyperlinkScriptCallerResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
   {* Регистрация скриптованой аксиоматики }
  public
  // realized methods
   class function ResName: AnsiString; override;
//#UC START# *77DB2124A8AEpubl*
//#UC END# *77DB2124A8AEpubl*
  end;//TtfwF1HyperlinkScriptCallerResNameGetter

// start class TtfwF1HyperlinkScriptCallerResNameGetter

class function TtfwF1HyperlinkScriptCallerResNameGetter.ResName: AnsiString;
 {-}
begin
 Result := 'tfwF1HyperlinkScriptCaller';
end;//TtfwF1HyperlinkScriptCallerResNameGetter.ResName

 {$R tfwF1HyperlinkScriptCaller.res}

function TtfwF1HyperlinkScriptCaller.DoResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
//#UC START# *55D34AD90105_55D34A9B0067_var*
//#UC END# *55D34AD90105_55D34A9B0067_var*
begin
//#UC START# *55D34AD90105_55D34A9B0067_impl*
 Result := inherited DoResolveIncludedFilePath(aFile);
//#UC END# *55D34AD90105_55D34A9B0067_impl*
end;//TtfwF1HyperlinkScriptCaller.DoResolveIncludedFilePath

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация скриптованой аксиоматики
 TtfwF1HyperlinkScriptCallerResNameGetter.Register;
{$IfEnd} //not NoScripts

end.