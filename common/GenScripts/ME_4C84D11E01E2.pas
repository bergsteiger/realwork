unit PrimContactListOptions_Form;
 {* Совещание онлайн }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\PrimContactListOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimContactList_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimContactListOptionsForm = class(TPrimContactListForm)
  {* Совещание онлайн }
  public
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Add; override;
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure History; override;
 end;//TPrimContactListOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimContactListOptionsForm.Delete;
 {* Удалить }
//#UC START# *4C7D0CC90052_4C84D11E01E2_var*
//#UC END# *4C7D0CC90052_4C84D11E01E2_var*
begin
//#UC START# *4C7D0CC90052_4C84D11E01E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0CC90052_4C84D11E01E2_impl*
end;//TPrimContactListOptionsForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimContactListOptionsForm.Add;
//#UC START# *4C2B245F01F2_4C84D11E01E2_var*
//#UC END# *4C2B245F01F2_4C84D11E01E2_var*
begin
//#UC START# *4C2B245F01F2_4C84D11E01E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C2B245F01F2_4C84D11E01E2_impl*
end;//TPrimContactListOptionsForm.Add

{$If NOT Defined(NoVCM)}
procedure TPrimContactListOptionsForm.Ok;
 {* OK }
//#UC START# *4C762A1501FC_4C84D11E01E2_var*
//#UC END# *4C762A1501FC_4C84D11E01E2_var*
begin
//#UC START# *4C762A1501FC_4C84D11E01E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762A1501FC_4C84D11E01E2_impl*
end;//TPrimContactListOptionsForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimContactListOptionsForm.Cancel;
 {* Отмена }
//#UC START# *4C762AB601E1_4C84D11E01E2_var*
//#UC END# *4C762AB601E1_4C84D11E01E2_var*
begin
//#UC START# *4C762AB601E1_4C84D11E01E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762AB601E1_4C84D11E01E2_impl*
end;//TPrimContactListOptionsForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimContactListOptionsForm.History;
//#UC START# *4C84CC2E0253_4C84D11E01E2_var*
//#UC END# *4C84CC2E0253_4C84D11E01E2_var*
begin
//#UC START# *4C84CC2E0253_4C84D11E01E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C84CC2E0253_4C84D11E01E2_impl*
end;//TPrimContactListOptionsForm.History

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimContactListOptionsForm);
 {* Регистрация PrimContactListOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
