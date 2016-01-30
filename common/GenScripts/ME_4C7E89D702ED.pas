unit PrimFoldersInfoOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersInfoOptions_Form.pas"
// Стереотип: "VCMContainer"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimFoldersInfo_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimFoldersInfoOptionsForm = class(TPrimFoldersInfoForm)
  public
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimFoldersInfoOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersInfoOptionsForm.Ok;
 {* OK }
//#UC START# *4C762A1501FC_4C7E89D702ED_var*
//#UC END# *4C762A1501FC_4C7E89D702ED_var*
begin
//#UC START# *4C762A1501FC_4C7E89D702ED_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762A1501FC_4C7E89D702ED_impl*
end;//TPrimFoldersInfoOptionsForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersInfoOptionsForm.Cancel;
 {* Отмена }
//#UC START# *4C762C910358_4C7E89D702ED_var*
//#UC END# *4C762C910358_4C7E89D702ED_var*
begin
//#UC START# *4C762C910358_4C7E89D702ED_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762C910358_4C7E89D702ED_impl*
end;//TPrimFoldersInfoOptionsForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimFoldersInfoOptionsForm);
 {* Регистрация PrimFoldersInfoOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
