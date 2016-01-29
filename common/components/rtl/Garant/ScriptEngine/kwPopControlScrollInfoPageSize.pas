unit kwPopControlScrollInfoPageSize;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$RTLandVCL"
// Модуль: "kwPopControlScrollInfoPageSize.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi Low Level::ScriptEngine$RTLandVCL::ScrollInfoProcessing::pop_control_ScrollInfo_PageSize
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
 TkwPopControlScrollInfoPageSize = {final scriptword} class(TkwScrollInfoWord)
 protected
 // realized methods
   procedure DoScrollInfo(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopControlScrollInfoPageSize
{$IfEnd} //not NoScripts AND not NoVCL

implementation

{$If not defined(NoScripts) AND not defined(NoVCL)}

// start class TkwPopControlScrollInfoPageSize

procedure TkwPopControlScrollInfoPageSize.DoScrollInfo(const aCtx: TtfwContext);
//#UC START# *51793A950073_51793B1402E2_var*
//#UC END# *51793A950073_51793B1402E2_var*
begin
//#UC START# *51793A950073_51793B1402E2_impl*
 aCtx.rEngine.PushInt(ScrollInfo.nPage);
//#UC END# *51793A950073_51793B1402E2_impl*
end;//TkwPopControlScrollInfoPageSize.DoScrollInfo

class function TkwPopControlScrollInfoPageSize.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:control:ScrollInfo:PageSize';
end;//TkwPopControlScrollInfoPageSize.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCL

initialization
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_control_ScrollInfo_PageSize
 TkwPopControlScrollInfoPageSize.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL

end.