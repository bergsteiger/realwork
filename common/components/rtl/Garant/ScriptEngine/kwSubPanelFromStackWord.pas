unit kwSubPanelFromStackWord;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwSubPanelFromStackWord.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , evSubPn
 , tfwScriptingInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , kwComponentFromStackWord
 , Classes
;

type
 {$Include w:\common\components\rtl\Garant\ScriptEngine\kwControlFromStackWord.imp.pas}
 TkwSubPanelFromStackWord = {abstract} class(_kwControlFromStackWord_)
  protected
   procedure DoWithSubPanel(aControl: TevCustomSubPanel;
    const aCtx: TtfwContext); virtual; abstract;
   {$If NOT Defined(NoVCL)}
   procedure DoControl(aControl: TControl;
    const aCtx: TtfwContext); override;
   {$IfEnd} // NOT Defined(NoVCL)
 end;//TkwSubPanelFromStackWord
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

{$Include w:\common\components\rtl\Garant\ScriptEngine\kwControlFromStackWord.imp.pas}

{$If NOT Defined(NoVCL)}
procedure TkwSubPanelFromStackWord.DoControl(aControl: TControl;
 const aCtx: TtfwContext);
//#UC START# *4F212C3A015A_52D646990049_var*
//#UC END# *4F212C3A015A_52D646990049_var*
begin
//#UC START# *4F212C3A015A_52D646990049_impl*
 DoWithSubPanel(aControl as TevCustomSubPanel, aCtx);
//#UC END# *4F212C3A015A_52D646990049_impl*
end;//TkwSubPanelFromStackWord.DoControl
{$IfEnd} // NOT Defined(NoVCL)

initialization
 TkwSubPanelFromStackWord.RegisterClass;
 {* Регистрация TkwSubPanelFromStackWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
