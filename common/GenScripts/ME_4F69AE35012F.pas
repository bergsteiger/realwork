unit kwQueryCardFormWord;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Shell_Words\kwQueryCardFormWord.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , kwFormFromControlWord
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(Admin)}
 , PrimQueryCard_Form
 {$IfEnd} // NOT Defined(Admin)
 , tfwScriptingInterfaces
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TkwQueryCardFormWord = {abstract} class(TkwFormFromControlWord)
  protected
   procedure DoQueryCardForm(aForm: TPrimQueryCardForm;
    const aCtx: TtfwContext); virtual; abstract;
   {$If NOT Defined(NoVCL)}
   procedure DoForm(aForm: TForm;
    const aCtx: TtfwContext); override;
   {$IfEnd} // NOT Defined(NoVCL)
 end;//TkwQueryCardFormWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

{$If NOT Defined(NoVCL)}
procedure TkwQueryCardFormWord.DoForm(aForm: TForm;
 const aCtx: TtfwContext);
//#UC START# *4EB25DE00396_4F69AE35012F_var*
//#UC END# *4EB25DE00396_4F69AE35012F_var*
begin
//#UC START# *4EB25DE00396_4F69AE35012F_impl*
 DoQueryCardForm(aForm As TPrimQueryCardForm, aCtx);
//#UC END# *4EB25DE00396_4F69AE35012F_impl*
end;//TkwQueryCardFormWord.DoForm
{$IfEnd} // NOT Defined(NoVCL)

initialization
 TkwQueryCardFormWord.RegisterClass;
 {* Регистрация TkwQueryCardFormWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
