unit PrimFoldersInfoOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders/Forms/PrimFoldersInfoOptions_Form.pas"
// Начат: 01.09.2010 21:14
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 Основные прецеденты::Folders::View::Folders::PrimFoldersInfoOptions
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
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  PrimFoldersInfo_Form,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimFoldersInfoOptionsForm = {form} class(TPrimFoldersInfoForm)
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
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
 end;//TPrimFoldersInfoOptionsForm

 TvcmContainerFormRef = TPrimFoldersInfoOptionsForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimFoldersInfoOptionsForm

{$If not defined(NoVCM)}
procedure TPrimFoldersInfoOptionsForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C762A1501FC_4C7E89D702EDtest_var*
var
 l_Form : IvcmEntityForm;
//#UC END# *4C762A1501FC_4C7E89D702EDtest_var*
begin
//#UC START# *4C762A1501FC_4C7E89D702EDtest_impl*
 if HasForm(vcm_ztChild, False, @l_Form) then
  try
   l_Form.Entity.Operation(TdmStdRes.opcode_ResultExt_Ok, aParams As IvcmTestParams);
   aParams.Op.Flag[vcm_ofVisible] := True;
  finally
   l_Form := nil;
  end
 else
 begin
  aParams.Op.Flag[vcm_ofVisible] := False;
  aParams.Op.Flag[vcm_ofEnabled] := False;
 end;
//#UC END# *4C762A1501FC_4C7E89D702EDtest_impl*
end;//TPrimFoldersInfoOptionsForm.Result_Ok_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimFoldersInfoOptionsForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C762A1501FC_4C7E89D702EDexec_var*
var
 l_Form : IvcmEntityForm;
//#UC END# *4C762A1501FC_4C7E89D702EDexec_var*
begin
//#UC START# *4C762A1501FC_4C7E89D702EDexec_impl*
 if HasForm(vcm_ztChild, False, @l_Form) then
  try
   l_Form.Entity.Operation(TdmStdRes.opcode_ResultExt_Ok, aParams As IvcmExecuteParams);
  finally
   l_Form := nil;
  end;
//#UC END# *4C762A1501FC_4C7E89D702EDexec_impl*
end;//TPrimFoldersInfoOptionsForm.Result_Ok_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimFoldersInfoOptionsForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C762C910358_4C7E89D702EDtest_var*
//#UC END# *4C762C910358_4C7E89D702EDtest_var*
begin
//#UC START# *4C762C910358_4C7E89D702EDtest_impl*
 aParams.Op.Flag[vcm_ofVisible] := True;
 aParams.Op.Flag[vcm_ofEnabled] := True;
//#UC END# *4C762C910358_4C7E89D702EDtest_impl*
end;//TPrimFoldersInfoOptionsForm.Result_Cancel_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimFoldersInfoOptionsForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C762C910358_4C7E89D702EDexec_var*
var
 l_Form : IvcmEntityForm;
//#UC END# *4C762C910358_4C7E89D702EDexec_var*
begin
//#UC START# *4C762C910358_4C7E89D702EDexec_impl*
 if HasForm(vcm_ztChild, False, @l_Form) then
  try
   l_Form.Entity.Operation(TdmStdRes.opcode_ResultExt_Cancel, aParams As IvcmExecuteParams);
  finally
   l_Form := nil;
  end;
//#UC END# *4C762C910358_4C7E89D702EDexec_impl*
end;//TPrimFoldersInfoOptionsForm.Result_Cancel_Execute
{$IfEnd} //not NoVCM

procedure TPrimFoldersInfoOptionsForm.InitEntities;
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
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, Result_Cancel_Test, nil);
  ShowInContextMenu(en_Result, op_Cancel, false);
  ShowInToolbar(en_Result, op_Cancel, true);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimFoldersInfoOptions
 TtfwClassRef.Register(TPrimFoldersInfoOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.