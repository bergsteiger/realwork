unit PrimForbidAutoregistrationOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/PrimForbidAutoregistrationOptions_Form.pas"
// Начат: 09.09.2010 18:40
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Администратор::Admin::View::Admin::PrimForbidAutoregistrationOptions
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
  PrimForbidAutoregistration_Form
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 TPrimForbidAutoregistrationOptionsForm = {form} class(TPrimForbidAutoregistrationForm)
 protected
  procedure InitEntities; override;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Result_Ok_Test(const aParams: IvcmTestParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
 protected
 // protected methods
   function SaveAdminInfo: Boolean;
 end;//TPrimForbidAutoregistrationOptionsForm

 TvcmEntityFormRef = TPrimForbidAutoregistrationOptionsForm;
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
uses
  AdminDomainInterfaces,
  nsVerifyValue,
  l3String
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}

// start class TPrimForbidAutoregistrationOptionsForm

function TPrimForbidAutoregistrationOptionsForm.SaveAdminInfo: Boolean;

 procedure LpSelectComboBox(const aComboBox: TnscComboBox);
 //#UC START# *4C8A05EA005B__var*
 //#UC END# *4C8A05EA005B__var*
 begin
 //#UC START# *4C8A05EA005B__impl*
  with aComboBox do
  begin
   SetFocus;
   SelectAll;
  end;//with cbEmail do
 //#UC END# *4C8A05EA005B__impl*
 end;//LpSelectComboBox

//#UC START# *4C89FF5C0352_4C88F1C30376_var*
//#UC END# *4C89FF5C0352_4C88F1C30376_var*
begin
//#UC START# *4C89FF5C0352_4C88F1C30376_impl*
 Result := False;
 with dsForbidAutoregistration do
 begin
  try
   Phone := cbPhone.Text;
  except
   on E: EdsMaxLengthExceed do
   begin
    Ask(err_MaxStringLength, [E.MaxLength]);
    lpSelectComboBox(cbPhone);
    Exit;
   end;//on EdsMaxLengthExceed do
  end;//try..except
  try
   Email := cbEmail.Text;
  except
   on E: EdsMaxLengthExceed do
   begin
    Ask(err_MaxStringLength, [E.MaxLength]);
    lpSelectComboBox(cbEmail);
    Exit;
   end;//on EdsMaxLengthExceed do
  end;//try..except
 end;//with dsForbidAutoregistration do
 Result := True;
//#UC END# *4C89FF5C0352_4C88F1C30376_impl*
end;//TPrimForbidAutoregistrationOptionsForm.SaveAdminInfo

{$If not defined(NoVCM)}
procedure TPrimForbidAutoregistrationOptionsForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C762A1501FC_4C88F1C30376test_var*
//#UC END# *4C762A1501FC_4C88F1C30376test_var*
begin
//#UC START# *4C762A1501FC_4C88F1C30376test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := not l3IsNil(cbPhone.Text) or
  (not l3IsNil(cbEmail.Text) and nsEmailVerify.Verify(cbEmail.Text));
//#UC END# *4C762A1501FC_4C88F1C30376test_impl*
end;//TPrimForbidAutoregistrationOptionsForm.Result_Ok_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimForbidAutoregistrationOptionsForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C762A1501FC_4C88F1C30376exec_var*
//#UC END# *4C762A1501FC_4C88F1C30376exec_var*
begin
//#UC START# *4C762A1501FC_4C88F1C30376exec_impl*
 if SaveAdminInfo then
 begin
  dsForbidAutoregistration.NeedForbid := True;
  SafeClose;
 end;//if SaveAdminInfo then
//#UC END# *4C762A1501FC_4C88F1C30376exec_impl*
end;//TPrimForbidAutoregistrationOptionsForm.Result_Ok_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimForbidAutoregistrationOptionsForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C762C910358_4C88F1C30376exec_var*
//#UC END# *4C762C910358_4C88F1C30376exec_var*
begin
//#UC START# *4C762C910358_4C88F1C30376exec_impl*
 dsForbidAutoregistration.NeedForbid := False;
 SafeClose;
//#UC END# *4C762C910358_4C88F1C30376exec_impl*
end;//TPrimForbidAutoregistrationOptionsForm.Result_Cancel_Execute
{$IfEnd} //not NoVCM

procedure TPrimForbidAutoregistrationOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  ToolbarAtBottom(en_Result);
  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, Result_Ok_Test, nil);
  ShowInContextMenu(en_Result, op_Ok, false);
  ShowInToolbar(en_Result, op_Ok, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, nil, nil);
  ShowInContextMenu(en_Result, op_Cancel, false);
  ShowInToolbar(en_Result, op_Cancel, true);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация PrimForbidAutoregistrationOptions
 TtfwClassRef.Register(TPrimForbidAutoregistrationOptionsForm);
{$IfEnd} //Admin AND not NoScripts

end.