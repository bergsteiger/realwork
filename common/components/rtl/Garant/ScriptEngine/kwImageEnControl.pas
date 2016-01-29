unit kwImageEnControl;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$ImageEn"
// Модуль: "kwImageEnControl.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi::ScriptEngine$ImageEn::ImageEnView::TkwImageEnControl
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoImageEn) AND not defined(NoScripts)}
uses
  imageenview,
  tfwScriptingInterfaces
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  kwComponentFromStackWord,
  Classes
  ;
{$IfEnd} //not NoImageEn AND not NoScripts

{$If not defined(NoImageEn) AND not defined(NoScripts)}
type
 {$Include ..\ScriptEngine\kwControlFromStackWord.imp.pas}
 TkwImageEnControl = {abstract} class(_kwControlFromStackWord_)
 protected
 // realized methods
    {$If not defined(NoScripts) AND not defined(NoVCL)}
   procedure DoControl(aControl: TControl;
     const aCtx: TtfwContext); override;
    {$IfEnd} //not NoScripts AND not NoVCL
 protected
 // protected methods
   procedure DoWithImageEn(aControl: TImageEnView;
     const aCtx: TtfwContext); virtual; abstract;
 end;//TkwImageEnControl
{$IfEnd} //not NoImageEn AND not NoScripts

implementation

{$If not defined(NoImageEn) AND not defined(NoScripts)}
uses
  Windows
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //not NoImageEn AND not NoScripts

{$If not defined(NoImageEn) AND not defined(NoScripts)}

{$Include ..\ScriptEngine\kwControlFromStackWord.imp.pas}

// start class TkwImageEnControl

{$If not defined(NoScripts) AND not defined(NoVCL)}
procedure TkwImageEnControl.DoControl(aControl: TControl;
  const aCtx: TtfwContext);
//#UC START# *4F212C3A015A_52E20F060237_var*
//#UC END# *4F212C3A015A_52E20F060237_var*
begin
//#UC START# *4F212C3A015A_52E20F060237_impl*
 DoWithImageEn(aControl as TImageEnView, aCtx);
//#UC END# *4F212C3A015A_52E20F060237_impl*
end;//TkwImageEnControl.DoControl
{$IfEnd} //not NoScripts AND not NoVCL

{$IfEnd} //not NoImageEn AND not NoScripts

initialization
{$If not defined(NoImageEn) AND not defined(NoScripts)}
// Регистрация TkwImageEnControl
 TkwImageEnControl.RegisterClass;
{$IfEnd} //not NoImageEn AND not NoScripts

end.