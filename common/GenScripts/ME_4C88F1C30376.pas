unit PrimForbidAutoregistrationOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimForbidAutoregistrationOptions_Form.pas"
// Стереотип: "VCMForm"

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
   function SaveAdminInfo: Boolean;
  public
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
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

function TPrimForbidAutoregistrationOptionsForm.SaveAdminInfo: Boolean;

 procedure lp_SelectComboBox(const aComboBox: TnscComboBox);
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
 end;//lp_SelectComboBox

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
 {* Отмена }
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
 {* Регистрация PrimForbidAutoregistrationOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
