unit tfwArchiHyperlinkScriptCaller;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$Core"
// Модуль: "tfwArchiHyperlinkScriptCaller.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Core::ScriptCallers::TtfwArchiHyperlinkScriptCaller
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
 TtfwArchiHyperlinkScriptCaller = class(TtfwHyperlinkScriptCaller)
 protected
 // overridden protected methods
   function DoResolveIncludedFilePath(const aFile: AnsiString): AnsiString; override;
 end;//TtfwArchiHyperlinkScriptCaller
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}

type
//#UC START# *2601B8C0800Aci*
//#UC END# *2601B8C0800Aci*
//#UC START# *2601B8C0800Acit*
//#UC END# *2601B8C0800Acit*
  TtfwArchiHyperlinkScriptCallerResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
   {* Регистрация скриптованой аксиоматики }
  public
  // realized methods
   class function ResName: AnsiString; override;
//#UC START# *2601B8C0800Apubl*
//#UC END# *2601B8C0800Apubl*
  end;//TtfwArchiHyperlinkScriptCallerResNameGetter

// start class TtfwArchiHyperlinkScriptCallerResNameGetter

class function TtfwArchiHyperlinkScriptCallerResNameGetter.ResName: AnsiString;
 {-}
begin
 Result := 'tfwArchiHyperlinkScriptCaller';
end;//TtfwArchiHyperlinkScriptCallerResNameGetter.ResName

 {$R tfwArchiHyperlinkScriptCaller.res}

function TtfwArchiHyperlinkScriptCaller.DoResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
//#UC START# *55D34AD90105_55D34A7E0127_var*
//#UC END# *55D34AD90105_55D34A7E0127_var*
begin
//#UC START# *55D34AD90105_55D34A7E0127_impl*
 Result := inherited DoResolveIncludedFilePath(aFile);
//#UC END# *55D34AD90105_55D34A7E0127_impl*
end;//TtfwArchiHyperlinkScriptCaller.DoResolveIncludedFilePath

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация скриптованой аксиоматики
 TtfwArchiHyperlinkScriptCallerResNameGetter.Register;
{$IfEnd} //not NoScripts

end.