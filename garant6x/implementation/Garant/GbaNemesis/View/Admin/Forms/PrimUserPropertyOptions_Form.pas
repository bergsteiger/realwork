unit PrimUserPropertyOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/PrimUserPropertyOptions_Form.pas"
// Начат: 10.09.2010 14:41
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Администратор::Admin::View::Admin::PrimUserPropertyOptions
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  Admin_Users_Controls,
  PrimUserProperty_Form
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 TPrimUserPropertyOptionsForm = {form} class(TPrimUserPropertyForm)
 protected
  procedure InitEntities; override;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   procedure Result_Save_Test(const aParams: IvcmTestParamsPrim);
     {* Сохранить }
   procedure Result_Save_GetState(var State: TvcmOperationStateIndex);
     {* Сохранить }
   procedure Result_Save_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Сохранить }
 end;//TPrimUserPropertyOptionsForm

 TvcmEntityFormRef = TPrimUserPropertyOptionsForm;
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}

// start class TPrimUserPropertyOptionsForm

{$If not defined(NoVCM)}
procedure TPrimUserPropertyOptionsForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C762C910358_4C8A0B4500F0test_var*
//#UC END# *4C762C910358_4C8A0B4500F0test_var*
begin
//#UC START# *4C762C910358_4C8A0B4500F0test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Assigned(dsUserProperty) and dsUserProperty.IsChanged;
//#UC END# *4C762C910358_4C8A0B4500F0test_impl*
end;//TPrimUserPropertyOptionsForm.Result_Cancel_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimUserPropertyOptionsForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C762C910358_4C8A0B4500F0exec_var*
var
 l_NeedNotify: Boolean;
//#UC END# *4C762C910358_4C8A0B4500F0exec_var*
begin
//#UC START# *4C762C910358_4C8A0B4500F0exec_impl*
 l_NeedNotify := Assigned(dsUserProperty) and dsUserProperty.IsNewUser;
 RestoreFields;
 if l_NeedNotify then
  dsUserProperty.CreateUserFinished(False);
//#UC END# *4C762C910358_4C8A0B4500F0exec_impl*
end;//TPrimUserPropertyOptionsForm.Result_Cancel_Execute
{$IfEnd} //not NoVCM

procedure TPrimUserPropertyOptionsForm.Result_Save_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7BB8DD0057_4C8A0B4500F0test_var*
//#UC END# *4C7BB8DD0057_4C8A0B4500F0test_var*
begin
//#UC START# *4C7BB8DD0057_4C8A0B4500F0test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := f_IsCorrectInfo and Assigned(dsUserProperty) and dsUserProperty.IsChanged;
//#UC END# *4C7BB8DD0057_4C8A0B4500F0test_impl*
end;//TPrimUserPropertyOptionsForm.Result_Save_Test

procedure TPrimUserPropertyOptionsForm.Result_Save_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4C7BB8DD0057_4C8A0B4500F0getstate_var*
//#UC END# *4C7BB8DD0057_4C8A0B4500F0getstate_var*
begin
//#UC START# *4C7BB8DD0057_4C8A0B4500F0getstate_impl*
 if Assigned(dsUserProperty) and dsUserProperty.IsNewUser then
  State := st_user_Result_Save_Create
 else
  State := vcm_DefaultOperationState;
//#UC END# *4C7BB8DD0057_4C8A0B4500F0getstate_impl*
end;//TPrimUserPropertyOptionsForm.Result_Save_GetState

procedure TPrimUserPropertyOptionsForm.Result_Save_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7BB8DD0057_4C8A0B4500F0exec_var*
//#UC END# *4C7BB8DD0057_4C8A0B4500F0exec_var*
begin
//#UC START# *4C7BB8DD0057_4C8A0B4500F0exec_impl*
 SaveChangedProfile(dsUserProperty);
//#UC END# *4C7BB8DD0057_4C8A0B4500F0exec_impl*
end;//TPrimUserPropertyOptionsForm.Result_Save_Execute

procedure TPrimUserPropertyOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  ToolbarAtBottom(en_Result);
  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, Result_Cancel_Test, nil);
  ShowInContextMenu(en_Result, op_Cancel, false);
  ShowInToolbar(en_Result, op_Cancel, true);
  {$IfEnd} //not NoVCM

  PublishOp(en_Result, op_Save, Result_Save_Execute, Result_Save_Test, Result_Save_GetState);
  ShowInContextMenu(en_Result, op_Save, false);
  ShowInToolbar(en_Result, op_Save, true);
 end;//with Entities.Entities
end;

{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация PrimUserPropertyOptions
 TtfwClassRef.Register(TPrimUserPropertyOptionsForm);
{$IfEnd} //Admin AND not NoScripts

end.