unit PrimForbidAutoregistrationOptions_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimForbidAutoregistrationOptions_Form.pas"
// ���������: "VCMForm"

{$Include nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimForbidAutoregistration_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
;

type
 TPrimForbidAutoregistrationOptionsForm = class(TPrimForbidAutoregistrationForm)
  protected
   procedure SaveAdminInfo;
  public
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimForbidAutoregistrationOptionsForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , nsVerifyValue
 , l3String
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , AdminDomainInterfaces
;

procedure TPrimForbidAutoregistrationOptionsForm.SaveAdminInfo;
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

{$If NOT Defined(NoVCM)}
procedure TPrimForbidAutoregistrationOptionsForm.Ok;
 {* OK }
//#UC START# *4C762A1501FC_4C88F1C30376_var*
//#UC END# *4C762A1501FC_4C88F1C30376_var*
begin
//#UC START# *4C762A1501FC_4C88F1C30376_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762A1501FC_4C88F1C30376_impl*
end;//TPrimForbidAutoregistrationOptionsForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimForbidAutoregistrationOptionsForm.Cancel;
 {* ������ }
//#UC START# *4C762C910358_4C88F1C30376_var*
//#UC END# *4C762C910358_4C88F1C30376_var*
begin
//#UC START# *4C762C910358_4C88F1C30376_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762C910358_4C88F1C30376_impl*
end;//TPrimForbidAutoregistrationOptionsForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimForbidAutoregistrationOptionsForm);
 {* ����������� PrimForbidAutoregistrationOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
