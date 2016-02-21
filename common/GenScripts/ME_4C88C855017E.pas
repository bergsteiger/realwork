unit PrimAttributeSelectOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimAttributeSelectOptions_Form.pas"
// Стереотип: "VCMContainer"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimAttributeSelect_Form
;

type
 TPrimAttributeSelectOptionsForm = class(TPrimAttributeSelectForm)
  public
   procedure ClearAll; override;
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure OkExt; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimAttributeSelectOptionsForm

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TPrimAttributeSelectOptionsForm.ClearAll;
//#UC START# *4C2DFEE000BA_4C88C855017E_var*
//#UC END# *4C2DFEE000BA_4C88C855017E_var*
begin
//#UC START# *4C2DFEE000BA_4C88C855017E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C2DFEE000BA_4C88C855017E_impl*
end;//TPrimAttributeSelectOptionsForm.ClearAll

{$If NOT Defined(NoVCM)}
procedure TPrimAttributeSelectOptionsForm.Cancel;
 {* Отмена }
//#UC START# *4C762C910358_4C88C855017E_var*
//#UC END# *4C762C910358_4C88C855017E_var*
begin
//#UC START# *4C762C910358_4C88C855017E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762C910358_4C88C855017E_impl*
end;//TPrimAttributeSelectOptionsForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAttributeSelectOptionsForm.OkExt;
 {* OK }
//#UC START# *4C762D9B0224_4C88C855017E_var*
//#UC END# *4C762D9B0224_4C88C855017E_var*
begin
//#UC START# *4C762D9B0224_4C88C855017E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762D9B0224_4C88C855017E_impl*
end;//TPrimAttributeSelectOptionsForm.OkExt
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimAttributeSelectOptionsForm);
 {* Регистрация PrimAttributeSelectOptions }
{$IfEnd} // NOT Defined(NoScripts)

end.
