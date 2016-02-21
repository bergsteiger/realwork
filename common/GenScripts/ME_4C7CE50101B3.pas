unit PrimUserListOptions_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimUserListOptions_Form.pas"
// ���������: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimUserList_Form
;

type
 TPrimUserListOptionsForm = class(TPrimUserListForm)
  public
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* ������� }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Add; override;
    {* �������� }
   procedure LogoutUser; override;
    {* ��������� ������������ }
   procedure ConsultingStateForNewbie; override;
    {* ���������/��������� ����� ��������� ������������� ������������� ������ ��������� ����������� }
   procedure Autoregistration; override;
    {* ���������/��������� ��������������� ����� ������������� }
   procedure AddPrivelegedRight; override;
    {* ������� ���������� ������������� ������������������ }
   procedure RemovePrivelegedRight; override;
    {* �������� ��� ���������� ������������� ����� ���������� }
   procedure UserFilter; override;
   procedure DisableConsulting; override;
   procedure EnableConsulting; override;
 end;//TPrimUserListOptionsForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimUserListOptionsForm.Delete;
 {* ������� }
//#UC START# *494F89C30197_4C7CE50101B3_var*
//#UC END# *494F89C30197_4C7CE50101B3_var*
begin
//#UC START# *494F89C30197_4C7CE50101B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *494F89C30197_4C7CE50101B3_impl*
end;//TPrimUserListOptionsForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimUserListOptionsForm.Add;
 {* �������� }
//#UC START# *494FD65902BF_4C7CE50101B3_var*
//#UC END# *494FD65902BF_4C7CE50101B3_var*
begin
//#UC START# *494FD65902BF_4C7CE50101B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *494FD65902BF_4C7CE50101B3_impl*
end;//TPrimUserListOptionsForm.Add

procedure TPrimUserListOptionsForm.LogoutUser;
 {* ��������� ������������ }
//#UC START# *4C7CDF1B0192_4C7CE50101B3_var*
//#UC END# *4C7CDF1B0192_4C7CE50101B3_var*
begin
//#UC START# *4C7CDF1B0192_4C7CE50101B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7CDF1B0192_4C7CE50101B3_impl*
end;//TPrimUserListOptionsForm.LogoutUser

procedure TPrimUserListOptionsForm.ConsultingStateForNewbie;
 {* ���������/��������� ����� ��������� ������������� ������������� ������ ��������� ����������� }
//#UC START# *4C7CDF570361_4C7CE50101B3_var*
//#UC END# *4C7CDF570361_4C7CE50101B3_var*
begin
//#UC START# *4C7CDF570361_4C7CE50101B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7CDF570361_4C7CE50101B3_impl*
end;//TPrimUserListOptionsForm.ConsultingStateForNewbie

procedure TPrimUserListOptionsForm.Autoregistration;
 {* ���������/��������� ��������������� ����� ������������� }
//#UC START# *4C7CDFE10330_4C7CE50101B3_var*
//#UC END# *4C7CDFE10330_4C7CE50101B3_var*
begin
//#UC START# *4C7CDFE10330_4C7CE50101B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7CDFE10330_4C7CE50101B3_impl*
end;//TPrimUserListOptionsForm.Autoregistration

procedure TPrimUserListOptionsForm.AddPrivelegedRight;
 {* ������� ���������� ������������� ������������������ }
//#UC START# *4C7CE03100BF_4C7CE50101B3_var*
//#UC END# *4C7CE03100BF_4C7CE50101B3_var*
begin
//#UC START# *4C7CE03100BF_4C7CE50101B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7CE03100BF_4C7CE50101B3_impl*
end;//TPrimUserListOptionsForm.AddPrivelegedRight

procedure TPrimUserListOptionsForm.RemovePrivelegedRight;
 {* �������� ��� ���������� ������������� ����� ���������� }
//#UC START# *4C7CE0710199_4C7CE50101B3_var*
//#UC END# *4C7CE0710199_4C7CE50101B3_var*
begin
//#UC START# *4C7CE0710199_4C7CE50101B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7CE0710199_4C7CE50101B3_impl*
end;//TPrimUserListOptionsForm.RemovePrivelegedRight

procedure TPrimUserListOptionsForm.UserFilter;
//#UC START# *4C7CEDAC0209_4C7CE50101B3_var*
//#UC END# *4C7CEDAC0209_4C7CE50101B3_var*
begin
//#UC START# *4C7CEDAC0209_4C7CE50101B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7CEDAC0209_4C7CE50101B3_impl*
end;//TPrimUserListOptionsForm.UserFilter

procedure TPrimUserListOptionsForm.DisableConsulting;
//#UC START# *4C7CEDB701D6_4C7CE50101B3_var*
//#UC END# *4C7CEDB701D6_4C7CE50101B3_var*
begin
//#UC START# *4C7CEDB701D6_4C7CE50101B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7CEDB701D6_4C7CE50101B3_impl*
end;//TPrimUserListOptionsForm.DisableConsulting

procedure TPrimUserListOptionsForm.EnableConsulting;
//#UC START# *4C7CEDC20353_4C7CE50101B3_var*
//#UC END# *4C7CEDC20353_4C7CE50101B3_var*
begin
//#UC START# *4C7CEDC20353_4C7CE50101B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7CEDC20353_4C7CE50101B3_impl*
end;//TPrimUserListOptionsForm.EnableConsulting

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimUserListOptionsForm);
 {* ����������� PrimUserListOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
