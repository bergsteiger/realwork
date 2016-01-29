unit kwPopControlScrollInfoMin;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$RTLandVCL"
// Модуль: "kwPopControlScrollInfoMin.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi Low Level::ScriptEngine$RTLandVCL::ScrollInfoProcessing::pop_control_ScrollInfo_Min
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCL)}
uses
  kwScrollInfoWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts AND not NoVCL

{$If not defined(NoScripts) AND not defined(NoVCL)}
type
 TkwPopControlScrollInfoMin = {final scriptword} class(TkwScrollInfoWord)
 protected
 // realized methods
   procedure DoScrollInfo(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopControlScrollInfoMin
{$IfEnd} //not NoScripts AND not NoVCL

implementation

{$If not defined(NoScripts) AND not defined(NoVCL)}

// start class TkwPopControlScrollInfoMin

procedure TkwPopControlScrollInfoMin.DoScrollInfo(const aCtx: TtfwContext);
//#UC START# *51793A950073_51793B050115_var*
//#UC END# *51793A950073_51793B050115_var*
begin
//#UC START# *51793A950073_51793B050115_impl*
 aCtx.rEngine.PushInt(ScrollInfo.nMin);
//#UC END# *51793A950073_51793B050115_impl*
end;//TkwPopControlScrollInfoMin.DoScrollInfo

class function TkwPopControlScrollInfoMin.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:control:ScrollInfo:Min';
end;//TkwPopControlScrollInfoMin.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCL

initialization
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_control_ScrollInfo_Min
 TkwPopControlScrollInfoMin.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL

end.