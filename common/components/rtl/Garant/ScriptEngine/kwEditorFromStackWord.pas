unit kwEditorFromStackWord;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$Everest"
// Модуль: "kwEditorFromStackWord.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi::ScriptEngine$Everest::EditorFromStackKeyWords::TkwEditorFromStackWord
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  evCustomEditorWindow,
  tfwScriptingInterfaces
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
 TkwEditorFromStackWord = {abstract} class(_kwControlFromStackWord_)
 protected
 // realized methods
    {$If not defined(NoScripts) AND not defined(NoVCL)}
   procedure DoControl(aControl: TControl;
     const aCtx: TtfwContext); override;
    {$IfEnd} //not NoScripts AND not NoVCL
 protected
 // protected methods
   procedure DoWithEditor(const aCtx: TtfwContext;
     anEditor: TevCustomEditorWindow); virtual; abstract;
 end;//TkwEditorFromStackWord
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

// start class TkwEditorFromStackWord

{$If not defined(NoScripts) AND not defined(NoVCL)}
procedure TkwEditorFromStackWord.DoControl(aControl: TControl;
  const aCtx: TtfwContext);
//#UC START# *4F212C3A015A_4F4CB625027A_var*
//#UC END# *4F212C3A015A_4F4CB625027A_var*
begin
//#UC START# *4F212C3A015A_4F4CB625027A_impl*
 DoWithEditor(aCtx, aControl as TevCustomEditorWindow);
//#UC END# *4F212C3A015A_4F4CB625027A_impl*
end;//TkwEditorFromStackWord.DoControl
{$IfEnd} //not NoScripts AND not NoVCL

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация TkwEditorFromStackWord
 TkwEditorFromStackWord.RegisterClass;
{$IfEnd} //not NoScripts

end.