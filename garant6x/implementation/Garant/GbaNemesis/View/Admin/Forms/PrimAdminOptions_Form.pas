unit PrimAdminOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/PrimAdminOptions_Form.pas"
// Начат: 09.09.2010 17:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 Администратор::Admin::View::Admin::PrimAdminOptions
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
  Classes
  {$If not defined(NoVCM)}
  ,
  OfficeLike_ResultEx_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  PrimAdmin_Form,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 TPrimAdminOptionsForm = {form} class(TPrimAdminForm)
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
   {$If not defined(NoVCM)}
   procedure Result_OkExt_Test(const aParams: IvcmTestParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_OkExt_Execute(const aParams: IvcmExecuteParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
 end;//TPrimAdminOptionsForm

 TvcmContainerFormRef = TPrimAdminOptionsForm;
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
uses
  SysUtils
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //Admin

{$If defined(Admin)}

// start class TPrimAdminOptionsForm

{$If not defined(NoVCM)}
procedure TPrimAdminOptionsForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C762C910358_4C88E37B0049test_var*
var
 l_Form : IvcmEntityForm;
//#UC END# *4C762C910358_4C88E37B0049test_var*
begin
//#UC START# *4C762C910358_4C88E37B0049test_impl*
 if HasForm(vcm_ztChild, False, @l_Form) then
  try
   l_Form.Entity.Operation(TdmStdRes.opcode_Result_Cancel, aParams As IvcmTestParams);
   aParams.Op.Flag[vcm_ofVisible] := False;
  finally
   l_Form := nil;
  end
 else
 begin
  aParams.Op.Flag[vcm_ofVisible] := False;
  aParams.Op.Flag[vcm_ofEnabled] := False;
 end;
//#UC END# *4C762C910358_4C88E37B0049test_impl*
end;//TPrimAdminOptionsForm.Result_Cancel_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimAdminOptionsForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C762C910358_4C88E37B0049exec_var*
var
 l_Form : IvcmEntityForm;
//#UC END# *4C762C910358_4C88E37B0049exec_var*
begin
//#UC START# *4C762C910358_4C88E37B0049exec_impl*
 if HasForm(vcm_ztChild, False, @l_Form) then
  try
   l_Form.Entity.Operation(TdmStdRes.opcode_Result_Cancel, aParams As IvcmExecuteParams);
  finally
   l_Form := nil;
  end;
//#UC END# *4C762C910358_4C88E37B0049exec_impl*
end;//TPrimAdminOptionsForm.Result_Cancel_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimAdminOptionsForm.Result_OkExt_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C762D9B0224_4C88E37B0049test_var*
var
 l_Form : IvcmEntityForm;
//#UC END# *4C762D9B0224_4C88E37B0049test_var*
begin
//#UC START# *4C762D9B0224_4C88E37B0049test_impl*
 if HasForm(vcm_ztChild, False, @l_Form) then
  try
   l_Form.Entity.Operation(TdmStdRes.opcode_Result_Save, aParams As IvcmTestParams);
   aParams.Op.Flag[vcm_ofVisible] := False;
  finally
   l_Form := nil;
  end
 else
 begin
  aParams.Op.Flag[vcm_ofVisible] := False;
  aParams.Op.Flag[vcm_ofEnabled] := False;
 end;
//#UC END# *4C762D9B0224_4C88E37B0049test_impl*
end;//TPrimAdminOptionsForm.Result_OkExt_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimAdminOptionsForm.Result_OkExt_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C762D9B0224_4C88E37B0049exec_var*
var
 l_Form : IvcmEntityForm;
//#UC END# *4C762D9B0224_4C88E37B0049exec_var*
begin
//#UC START# *4C762D9B0224_4C88E37B0049exec_impl*
 if HasForm(vcm_ztChild, False, @l_Form) then
  try
   l_Form.Entity.Operation(TdmStdRes.opcode_Result_Save, aParams As IvcmExecuteParams);
  finally
   l_Form := nil;
  end;
//#UC END# *4C762D9B0224_4C88E37B0049exec_impl*
end;//TPrimAdminOptionsForm.Result_OkExt_Execute
{$IfEnd} //not NoVCM

procedure TPrimAdminOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, Result_Cancel_Test, nil);
  ShowInContextMenu(en_Result, op_Cancel, false);
  ShowInToolbar(en_Result, op_Cancel, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_OkExt, Result_OkExt_Execute, Result_OkExt_Test, nil);
  ShowInContextMenu(en_Result, op_OkExt, false);
  ShowInToolbar(en_Result, op_OkExt, true);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация PrimAdminOptions
 TtfwClassRef.Register(TPrimAdminOptionsForm);
{$IfEnd} //Admin AND not NoScripts

end.