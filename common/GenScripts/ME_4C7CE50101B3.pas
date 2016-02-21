unit PrimUserListOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimUserListOptions_Form.pas"
// Стереотип: "VCMForm"

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
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Add; override;
    {* Добавить }
   procedure LogoutUser; override;
    {* Отключить пользователя }
   procedure ConsultingStateForNewbie; override;
    {* Разрешить/Запретить вновь созданным пользователям использование услуги Правового консалтинга }
   procedure Autoregistration; override;
    {* Разрешить/Запретить авторегистрацию новых пользователей }
   procedure AddPrivelegedRight; override;
    {* Сделать выделенных пользователей привилегированными }
   procedure RemovePrivelegedRight; override;
    {* Отменить для выделенных пользователей режим привилегий }
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
 {* Удалить }
//#UC START# *494F89C30197_4C7CE50101B3_var*
//#UC END# *494F89C30197_4C7CE50101B3_var*
begin
//#UC START# *494F89C30197_4C7CE50101B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *494F89C30197_4C7CE50101B3_impl*
end;//TPrimUserListOptionsForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimUserListOptionsForm.Add;
 {* Добавить }
//#UC START# *494FD65902BF_4C7CE50101B3_var*
//#UC END# *494FD65902BF_4C7CE50101B3_var*
begin
//#UC START# *494FD65902BF_4C7CE50101B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *494FD65902BF_4C7CE50101B3_impl*
end;//TPrimUserListOptionsForm.Add

procedure TPrimUserListOptionsForm.LogoutUser;
 {* Отключить пользователя }
//#UC START# *4C7CDF1B0192_4C7CE50101B3_var*
//#UC END# *4C7CDF1B0192_4C7CE50101B3_var*
begin
//#UC START# *4C7CDF1B0192_4C7CE50101B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7CDF1B0192_4C7CE50101B3_impl*
end;//TPrimUserListOptionsForm.LogoutUser

procedure TPrimUserListOptionsForm.ConsultingStateForNewbie;
 {* Разрешить/Запретить вновь созданным пользователям использование услуги Правового консалтинга }
//#UC START# *4C7CDF570361_4C7CE50101B3_var*
//#UC END# *4C7CDF570361_4C7CE50101B3_var*
begin
//#UC START# *4C7CDF570361_4C7CE50101B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7CDF570361_4C7CE50101B3_impl*
end;//TPrimUserListOptionsForm.ConsultingStateForNewbie

procedure TPrimUserListOptionsForm.Autoregistration;
 {* Разрешить/Запретить авторегистрацию новых пользователей }
//#UC START# *4C7CDFE10330_4C7CE50101B3_var*
//#UC END# *4C7CDFE10330_4C7CE50101B3_var*
begin
//#UC START# *4C7CDFE10330_4C7CE50101B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7CDFE10330_4C7CE50101B3_impl*
end;//TPrimUserListOptionsForm.Autoregistration

procedure TPrimUserListOptionsForm.AddPrivelegedRight;
 {* Сделать выделенных пользователей привилегированными }
//#UC START# *4C7CE03100BF_4C7CE50101B3_var*
//#UC END# *4C7CE03100BF_4C7CE50101B3_var*
begin
//#UC START# *4C7CE03100BF_4C7CE50101B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7CE03100BF_4C7CE50101B3_impl*
end;//TPrimUserListOptionsForm.AddPrivelegedRight

procedure TPrimUserListOptionsForm.RemovePrivelegedRight;
 {* Отменить для выделенных пользователей режим привилегий }
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
 {* Регистрация PrimUserListOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
