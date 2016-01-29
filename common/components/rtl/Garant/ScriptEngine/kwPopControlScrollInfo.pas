unit kwPopControlScrollInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$RTLandVCL"
// Модуль: "kwPopControlScrollInfo.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi Low Level::ScriptEngine$RTLandVCL::ScrollInfoProcessing::pop_control_ScrollInfo
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
 TkwPopControlScrollInfo = {final scriptword} class(TkwScrollInfoWord)
 protected
 // realized methods
   procedure DoScrollInfo(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopControlScrollInfo
{$IfEnd} //not NoScripts AND not NoVCL

implementation

{$If not defined(NoScripts) AND not defined(NoVCL)}

// start class TkwPopControlScrollInfo

procedure TkwPopControlScrollInfo.DoScrollInfo(const aCtx: TtfwContext);
//#UC START# *51793A950073_51793AE70134_var*
//#UC END# *51793A950073_51793AE70134_var*
begin
//#UC START# *51793A950073_51793AE70134_impl*
 aCtx.rEngine.PushInt(ScrollInfo.nPos);
 aCtx.rEngine.PushInt(ScrollInfo.nPage);
 aCtx.rEngine.PushInt(ScrollInfo.nMin);
 aCtx.rEngine.PushInt(ScrollInfo.nMax);
//#UC END# *51793A950073_51793AE70134_impl*
end;//TkwPopControlScrollInfo.DoScrollInfo

class function TkwPopControlScrollInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:control:ScrollInfo';
end;//TkwPopControlScrollInfo.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCL

initialization
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_control_ScrollInfo
 TkwPopControlScrollInfo.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL

end.