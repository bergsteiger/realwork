unit PrimContactListOptions_Form;
 {* Совещание онлайн }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\PrimContactListOptions_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimContactListOptions" MUID: (4C84D11E01E2)
// Имя типа: "TPrimContactListOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimContactList_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimContactListOptionsForm = class(TPrimContactListForm)
  {* Совещание онлайн }
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
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
 , Base_Operations_F1Services_Contracts
 , Base_Operations_Chat_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4C84D11E01E2impl_uses*
 //#UC END# *4C84D11E01E2impl_uses*
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
   TChatService.Instance.MakeChatDispatcher.DeleteUser(trContactList.GetCurrentNode);
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

{$If NOT Defined(NoVCM)}
procedure TPrimContactListOptionsForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishOp(en_Edit, op_Delete, Edit_Delete_Execute, Edit_Delete_Test, Edit_Delete_GetState);
  ShowInContextMenu(en_Edit, op_Delete, True);
  ShowInToolbar(en_Edit, op_Delete, True);
  ShowInContextMenu(en_Chat, op_Add, True);
  ShowInToolbar(en_Chat, op_Add, True);
  ShowInContextMenu(en_Result, op_Ok, False);
  ShowInToolbar(en_Result, op_Ok, True);
  ShowInContextMenu(en_Result, op_Cancel, False);
  ShowInToolbar(en_Result, op_Cancel, True);
  ShowInContextMenu(en_Chat, op_History, True);
  ShowInToolbar(en_Chat, op_History, True);
 end;//with Entities.Entities
end;//TPrimContactListOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimContactListOptionsForm);
 {* Регистрация PrimContactListOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
