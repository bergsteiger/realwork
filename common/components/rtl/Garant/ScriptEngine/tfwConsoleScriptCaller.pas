unit tfwConsoleScriptCaller;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$Core"
// Модуль: "tfwConsoleScriptCaller.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Core::ScriptCallers::TtfwConsoleScriptCaller
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwDefaultScriptCaller,
  l3Interfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TtfwConsoleScriptCaller = class(TtfwDefaultScriptCaller)
 protected
 // overridden protected methods
   function DictPath: AnsiString; override;
 public
 // overridden public methods
   procedure DoPrint(const aStr: Tl3WString); override;
 end;//TtfwConsoleScriptCaller
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  l3String,
  SysUtils
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TtfwConsoleScriptCaller

procedure TtfwConsoleScriptCaller.DoPrint(const aStr: Tl3WString);
//#UC START# *55C491FC025C_55C48FCE03AB_var*
//#UC END# *55C491FC025C_55C48FCE03AB_var*
begin
//#UC START# *55C491FC025C_55C48FCE03AB_impl*
 System.WriteLn(l3Str(aStr));
//#UC END# *55C491FC025C_55C48FCE03AB_impl*
end;//TtfwConsoleScriptCaller.DoPrint

function TtfwConsoleScriptCaller.DictPath: AnsiString;
//#UC START# *55CC867301F7_55C48FCE03AB_var*
//#UC END# *55CC867301F7_55C48FCE03AB_var*
begin
//#UC START# *55CC867301F7_55C48FCE03AB_impl*
 Result := SysUtils.GetCurrentDir;
//#UC END# *55CC867301F7_55C48FCE03AB_impl*
end;//TtfwConsoleScriptCaller.DictPath

{$IfEnd} //not NoScripts

end.