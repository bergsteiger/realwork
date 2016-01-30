{$IfNDef kwControlFromStackWord_imp}

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwControlFromStackWord.imp.pas"
// Стереотип: "Impurity"

{$Define kwControlFromStackWord_imp}

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 _kwControlFromStackWord_ = {abstract} class(TkwComponentFromStackWord)
  protected
   procedure DoControl(aControl: TControl;
    const aCtx: TtfwContext); virtual; abstract;
   procedure DoComponent(aComponent: TComponent;
    const aCtx: TtfwContext); override;
 end;//_kwControlFromStackWord_

{$Else NOT Defined(NoScripts) AND NOT Defined(NoVCL)}

_kwControlFromStackWord_ = TkwComponentFromStackWord;

{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
{$Else kwControlFromStackWord_imp}

{$IfNDef kwControlFromStackWord_imp_impl}

{$Define kwControlFromStackWord_imp_impl}

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
procedure _kwControlFromStackWord_.DoComponent(aComponent: TComponent;
 const aCtx: TtfwContext);
//#UC START# *4F21485E0184_4F212C120371_var*
//#UC END# *4F21485E0184_4F212C120371_var*
begin
//#UC START# *4F21485E0184_4F212C120371_impl*
 RunnerAssert(aComponent Is TControl, aComponent.Name + ' не является контролом, а является компонентом класса ' + aComponent.ClassName, aCtx);
 DoControl(aComponent As TControl, aCtx);
//#UC END# *4F21485E0184_4F212C120371_impl*
end;//_kwControlFromStackWord_.DoComponent
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

{$EndIf kwControlFromStackWord_imp_impl}

{$EndIf kwControlFromStackWord_imp}

