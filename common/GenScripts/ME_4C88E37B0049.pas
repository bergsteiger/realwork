unit PrimAdminOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimAdminOptions_Form.pas"
// Стереотип: "VCMContainer"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimAdmin_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_ResultEx_Controls
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimAdminOptionsForm = class(TPrimAdminForm)
  public
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_OkExt_Test(const aParams: IvcmTestParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_OkExt_Execute(const aParams: IvcmExecuteParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimAdminOptionsForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimAdminOptionsForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
 {* Отмена }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAdminOptionsForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAdminOptionsForm.Result_OkExt_Test(const aParams: IvcmTestParamsPrim);
 {* OK }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAdminOptionsForm.Result_OkExt_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
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
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimAdminOptionsForm);
 {* Регистрация PrimAdminOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
