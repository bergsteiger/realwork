unit kwPopControlScrollInfoMax;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$RTLandVCL"
// Модуль: "kwPopControlScrollInfoMax.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi Low Level::ScriptEngine$RTLandVCL::ScrollInfoProcessing::pop_control_ScrollInfo_Max
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
 TkwPopControlScrollInfoMax = {final scriptword} class(TkwScrollInfoWord)
 protected
 // realized methods
   procedure DoScrollInfo(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopControlScrollInfoMax
{$IfEnd} //not NoScripts AND not NoVCL

implementation

{$If not defined(NoScripts) AND not defined(NoVCL)}

// start class TkwPopControlScrollInfoMax

procedure TkwPopControlScrollInfoMax.DoScrollInfo(const aCtx: TtfwContext);
//#UC START# *51793A950073_51793B0D02BB_var*
//#UC END# *51793A950073_51793B0D02BB_var*
begin
//#UC START# *51793A950073_51793B0D02BB_impl*
 aCtx.rEngine.PushInt(ScrollInfo.nMax);
//#UC END# *51793A950073_51793B0D02BB_impl*
end;//TkwPopControlScrollInfoMax.DoScrollInfo

class function TkwPopControlScrollInfoMax.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:control:ScrollInfo:Max';
end;//TkwPopControlScrollInfoMax.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCL

initialization
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_control_ScrollInfo_Max
 TkwPopControlScrollInfoMax.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL

end.