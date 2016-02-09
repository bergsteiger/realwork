unit kwEditorFromStackWord;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackWord.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , kwComponentFromStackWord
 , Classes
;

type
 {$Include kwControlFromStackWord.imp.pas}
 TkwEditorFromStackWord = {abstract} class(_kwControlFromStackWord_)
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); virtual; abstract;
   {$If NOT Defined(NoVCL)}
   procedure DoControl(aControl: TControl;
    const aCtx: TtfwContext); override;
   {$IfEnd} // NOT Defined(NoVCL)
 end;//TkwEditorFromStackWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Windows
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

{$Include kwControlFromStackWord.imp.pas}

{$If NOT Defined(NoVCL)}
procedure TkwEditorFromStackWord.DoControl(aControl: TControl;
 const aCtx: TtfwContext);
//#UC START# *4F212C3A015A_4F4CB625027A_var*
//#UC END# *4F212C3A015A_4F4CB625027A_var*
begin
//#UC START# *4F212C3A015A_4F4CB625027A_impl*
 DoWithEditor(aCtx, aControl as TevCustomEditorWindow);
//#UC END# *4F212C3A015A_4F4CB625027A_impl*
end;//TkwEditorFromStackWord.DoControl
{$IfEnd} // NOT Defined(NoVCL)

initialization
 TkwEditorFromStackWord.RegisterClass;
 {* Регистрация TkwEditorFromStackWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
