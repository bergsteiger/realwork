unit kwWinControlFromStackWord;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwWinControlFromStackWord.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwWinControlFromStackWord" MUID: (4F212C680161)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , Controls
 , tfwScriptingInterfaces
 , kwComponentFromStackWord
 , Classes
;

type
 {$Include w:\common\components\rtl\Garant\ScriptEngine\kwControlFromStackWord.imp.pas}
 TkwWinControlFromStackWord = {abstract} class(_kwControlFromStackWord_)
  protected
   procedure DoWinControl(aControl: TWinControl;
    const aCtx: TtfwContext); virtual; abstract;
   procedure DoControl(aControl: TControl;
    const aCtx: TtfwContext); override;
 end;//TkwWinControlFromStackWord
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Windows
 , Forms
 //#UC START# *4F212C680161impl_uses*
 //#UC END# *4F212C680161impl_uses*
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\kwControlFromStackWord.imp.pas}

procedure TkwWinControlFromStackWord.DoControl(aControl: TControl;
 const aCtx: TtfwContext);
//#UC START# *4F212C3A015A_4F212C680161_var*
//#UC END# *4F212C3A015A_4F212C680161_var*
begin
//#UC START# *4F212C3A015A_4F212C680161_impl*
 DoWinControl(aControl As TWinControl, aCtx);
//#UC END# *4F212C3A015A_4F212C680161_impl*
end;//TkwWinControlFromStackWord.DoControl

initialization
 TkwWinControlFromStackWord.RegisterClass;
 {* Регистрация TkwWinControlFromStackWord }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
