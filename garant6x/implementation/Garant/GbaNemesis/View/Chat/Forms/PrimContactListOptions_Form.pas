unit PrimContactListOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Chat/Forms/PrimContactListOptions_Form.pas"
// Начат: 06.09.2010 15:32
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Встроенные продукты::Chat::View::Chat::PrimContactListOptions
//
// Совещание онлайн
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  ,
  PrimContactList_Form,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimContactListOptionsForm = {form} class(TPrimContactListForm)
  {* Совещание онлайн }
 protected
  procedure InitEntities; override;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
     {* Удалить }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Delete_GetState(var State: TvcmOperationStateIndex);
     {* Удалить }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Удалить }
   {$IfEnd} //not NoVCM
 end;//TPrimContactListOptionsForm

 TvcmEntityFormRef = TPrimContactListOptionsForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a},
  Base_Operations_Chat_Controls
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimContactListOptionsForm

{$If not defined(NoVCM)}
procedure TPrimContactListOptionsForm.Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimContactListOptionsForm.Edit_Delete_GetState(var State: TvcmOperationStateIndex);
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimContactListOptionsForm.Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
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
{$IfEnd} //not NoVCM

procedure TPrimContactListOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Delete, Edit_Delete_Execute, Edit_Delete_Test, Edit_Delete_GetState);
  ShowInContextMenu(en_Edit, op_Delete, true);
  ShowInToolbar(en_Edit, op_Delete, true);
  {$IfEnd} //not NoVCM

  ShowInContextMenu(en_Chat, op_Add, true);
  ShowInToolbar(en_Chat, op_Add, true);
  {$If not defined(NoVCM)}
  
  ShowInContextMenu(en_Result, op_Ok, false);
  ShowInToolbar(en_Result, op_Ok, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  
  ShowInContextMenu(en_Result, op_Cancel, false);
  ShowInToolbar(en_Result, op_Cancel, true);
  {$IfEnd} //not NoVCM

  
  ShowInContextMenu(en_Chat, op_History, true);
  ShowInToolbar(en_Chat, op_History, true);
 end;//with Entities.Entities
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimContactListOptions
 TtfwClassRef.Register(TPrimContactListOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.