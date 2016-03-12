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
   procedure Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_GetState(var State: TvcmOperationStateIndex);
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
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
procedure TPrimContactListOptionsForm.Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
 {* Удалить }
//#UC START# *4C7D0CC90052_4C84D11E01E2test_var*
//#UC END# *4C7D0CC90052_4C84D11E01E2test_var*
begin
//#UC START# *4C7D0CC90052_4C84D11E01E2test_impl*
 if aParams.Control = trContactList then
  aParams.Op.Flag[vcm_ofEnabled] := not AddingContact and (trContactList.GetCurrentNode <> nil)
 else
  if not aParams.CallControl then
   aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4C7D0CC90052_4C84D11E01E2test_impl*
end;//TPrimContactListOptionsForm.Edit_Delete_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimContactListOptionsForm.Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Удалить }
//#UC START# *4C7D0CC90052_4C84D11E01E2exec_var*
//#UC END# *4C7D0CC90052_4C84D11E01E2exec_var*
begin
//#UC START# *4C7D0CC90052_4C84D11E01E2exec_impl*
 if aParams.Control = trContactList then
 begin
  if trContactList.GetCurrentNode <> nil then
   TdmStdRes.MakeChatDispatcher.DeleteUser(trContactList.GetCurrentNode);
 end
 else
  aParams.CallControl;
//#UC END# *4C7D0CC90052_4C84D11E01E2exec_impl*
end;//TPrimContactListOptionsForm.Edit_Delete_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimContactListOptionsForm.Edit_Delete_GetState(var State: TvcmOperationStateIndex);
 {* Удалить }
//#UC START# *4C7D0CC90052_4C84D11E01E2getstate_var*
//#UC END# *4C7D0CC90052_4C84D11E01E2getstate_var*
begin
//#UC START# *4C7D0CC90052_4C84D11E01E2getstate_impl*
 if trContactList.Focused then
  State := st_user_Edit_Delete_Contact
 else
  State := vcm_DefaultOperationState;
//#UC END# *4C7D0CC90052_4C84D11E01E2getstate_impl*
end;//TPrimContactListOptionsForm.Edit_Delete_GetState
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimContactListOptionsForm);
 {* Регистрация PrimContactListOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
