unit kwImageEnControl;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwImageEnControl.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoImageEn)}
uses
 l3IntfUses
 , imageenview
 , tfwScriptingInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , kwComponentFromStackWord
 , Classes
;

type
 {$Include w:\common\components\rtl\Garant\ScriptEngine\kwControlFromStackWord.imp.pas}
 TkwImageEnControl = {abstract} class(_kwControlFromStackWord_)
  protected
   procedure DoWithImageEn(aControl: TImageEnView;
    const aCtx: TtfwContext); virtual; abstract;
   {$If NOT Defined(NoVCL)}
   procedure DoControl(aControl: TControl;
    const aCtx: TtfwContext); override;
   {$IfEnd} // NOT Defined(NoVCL)
 end;//TkwImageEnControl
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoImageEn)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoImageEn)}
uses
 l3ImplUses
 , Windows
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\kwControlFromStackWord.imp.pas}

{$If NOT Defined(NoVCL)}
procedure TkwImageEnControl.DoControl(aControl: TControl;
 const aCtx: TtfwContext);
//#UC START# *4F212C3A015A_52E20F060237_var*
//#UC END# *4F212C3A015A_52E20F060237_var*
begin
//#UC START# *4F212C3A015A_52E20F060237_impl*
 DoWithImageEn(aControl as TImageEnView, aCtx);
//#UC END# *4F212C3A015A_52E20F060237_impl*
end;//TkwImageEnControl.DoControl
{$IfEnd} // NOT Defined(NoVCL)

initialization
 TkwImageEnControl.RegisterClass;
 {* Регистрация TkwImageEnControl }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoImageEn)

end.
