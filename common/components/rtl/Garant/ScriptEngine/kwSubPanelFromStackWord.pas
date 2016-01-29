unit kwSubPanelFromStackWord;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$Everest"
// Модуль: "kwSubPanelFromStackWord.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi::ScriptEngine$Everest::SubPanelWords::TkwSubPanelFromStackWord
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwScriptingInterfaces,
  evSubPn
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  kwComponentFromStackWord,
  Classes
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 {$Include ..\ScriptEngine\kwControlFromStackWord.imp.pas}
 TkwSubPanelFromStackWord = {abstract} class(_kwControlFromStackWord_)
 protected
 // realized methods
    {$If not defined(NoScripts) AND not defined(NoVCL)}
   procedure DoControl(aControl: TControl;
     const aCtx: TtfwContext); override;
    {$IfEnd} //not NoScripts AND not NoVCL
 protected
 // protected methods
   procedure DoWithSubPanel(aControl: TevCustomSubPanel;
     const aCtx: TtfwContext); virtual; abstract;
 end;//TkwSubPanelFromStackWord
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  Windows
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

{$Include ..\ScriptEngine\kwControlFromStackWord.imp.pas}

// start class TkwSubPanelFromStackWord

{$If not defined(NoScripts) AND not defined(NoVCL)}
procedure TkwSubPanelFromStackWord.DoControl(aControl: TControl;
  const aCtx: TtfwContext);
//#UC START# *4F212C3A015A_52D646990049_var*
//#UC END# *4F212C3A015A_52D646990049_var*
begin
//#UC START# *4F212C3A015A_52D646990049_impl*
 DoWithSubPanel(aControl as TevCustomSubPanel, aCtx);
//#UC END# *4F212C3A015A_52D646990049_impl*
end;//TkwSubPanelFromStackWord.DoControl
{$IfEnd} //not NoScripts AND not NoVCL

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация TkwSubPanelFromStackWord
 TkwSubPanelFromStackWord.RegisterClass;
{$IfEnd} //not NoScripts

end.