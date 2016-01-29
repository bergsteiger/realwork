unit kwPopControlScrollInfoPosition;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$RTLandVCL"
// Модуль: "kwPopControlScrollInfoPosition.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi Low Level::ScriptEngine$RTLandVCL::ScrollInfoProcessing::pop_control_ScrollInfo_Position
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
 TkwPopControlScrollInfoPosition = {final scriptword} class(TkwScrollInfoWord)
 protected
 // realized methods
   procedure DoScrollInfo(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopControlScrollInfoPosition
{$IfEnd} //not NoScripts AND not NoVCL

implementation

{$If not defined(NoScripts) AND not defined(NoVCL)}

// start class TkwPopControlScrollInfoPosition

procedure TkwPopControlScrollInfoPosition.DoScrollInfo(const aCtx: TtfwContext);
//#UC START# *51793A950073_51793B1F01AA_var*
//#UC END# *51793A950073_51793B1F01AA_var*
begin
//#UC START# *51793A950073_51793B1F01AA_impl*
 aCtx.rEngine.PushInt(ScrollInfo.nPos);
//#UC END# *51793A950073_51793B1F01AA_impl*
end;//TkwPopControlScrollInfoPosition.DoScrollInfo

class function TkwPopControlScrollInfoPosition.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:control:ScrollInfo:Position';
end;//TkwPopControlScrollInfoPosition.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCL

initialization
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_control_ScrollInfo_Position
 TkwPopControlScrollInfoPosition.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL

end.