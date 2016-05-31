unit PrimUserPropertyOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimUserPropertyOptions_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimUserPropertyOptions" MUID: (4C8A0B4500F0)
// Имя типа: "TPrimUserPropertyOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimUserProperty_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Admin_Users_Controls
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimUserPropertyOptionsForm = class(TPrimUserPropertyForm)
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Result_Save_Test(const aParams: IvcmTestParamsPrim);
    {* Сохранить }
   procedure Result_Save_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Сохранить }
   procedure Result_Save_GetState(var State: TvcmOperationStateIndex);
    {* Сохранить }
 end;//TPrimUserPropertyOptionsForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4C8A0B4500F0impl_uses*
 //#UC END# *4C8A0B4500F0impl_uses*
;

{$If NOT Defined(NoVCM)}
procedure TPrimUserPropertyOptionsForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
 {* Отмена }
//#UC START# *4C762C910358_4C8A0B4500F0test_var*
//#UC END# *4C762C910358_4C8A0B4500F0test_var*
begin
//#UC START# *4C762C910358_4C8A0B4500F0test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Assigned(dsUserProperty) and dsUserProperty.IsChanged;
//#UC END# *4C762C910358_4C8A0B4500F0test_impl*
end;//TPrimUserPropertyOptionsForm.Result_Cancel_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimUserPropertyOptionsForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
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
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimUserPropertyOptionsForm.Result_Save_Test(const aParams: IvcmTestParamsPrim);
 {* Сохранить }
//#UC START# *4C7BB8DD0057_4C8A0B4500F0test_var*
//#UC END# *4C7BB8DD0057_4C8A0B4500F0test_var*
begin
//#UC START# *4C7BB8DD0057_4C8A0B4500F0test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := f_IsCorrectInfo and Assigned(dsUserProperty) and dsUserProperty.IsChanged;
//#UC END# *4C7BB8DD0057_4C8A0B4500F0test_impl*
end;//TPrimUserPropertyOptionsForm.Result_Save_Test

procedure TPrimUserPropertyOptionsForm.Result_Save_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Сохранить }
//#UC START# *4C7BB8DD0057_4C8A0B4500F0exec_var*
//#UC END# *4C7BB8DD0057_4C8A0B4500F0exec_var*
begin
//#UC START# *4C7BB8DD0057_4C8A0B4500F0exec_impl*
 SaveChangedProfile(dsUserProperty);
//#UC END# *4C7BB8DD0057_4C8A0B4500F0exec_impl*
end;//TPrimUserPropertyOptionsForm.Result_Save_Execute

procedure TPrimUserPropertyOptionsForm.Result_Save_GetState(var State: TvcmOperationStateIndex);
 {* Сохранить }
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

{$If NOT Defined(NoVCM)}
procedure TPrimUserPropertyOptionsForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  ToolbarAtBottom(en_Result);
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, Result_Cancel_Test, nil);
  ShowInContextMenu(en_Result, op_Cancel, False);
  ShowInToolbar(en_Result, op_Cancel, True);
  PublishOp(en_Result, op_Save, Result_Save_Execute, Result_Save_Test, Result_Save_GetState);
  ShowInContextMenu(en_Result, op_Save, False);
  ShowInToolbar(en_Result, op_Save, True);
 end;//with Entities.Entities
end;//TPrimUserPropertyOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimUserPropertyOptionsForm);
 {* Регистрация PrimUserPropertyOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
