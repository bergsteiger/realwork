unit PrimGroupListOptions_Form;
 {* Группы пользователей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimGroupListOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimGroupList_Form
;

type
 TPrimGroupListOptionsForm = class(TPrimGroupListForm)
  {* Группы пользователей }
  public
   procedure Add; override;
    {* Добавить }
   procedure ChangeBaseAccess; override;
   procedure Rename; override;
    {* Переименовать группу }
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimGroupListOptionsForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TPrimGroupListOptionsForm.Add;
 {* Добавить }
//#UC START# *49EC7545036C_4C8A09A40104_var*
//#UC END# *49EC7545036C_4C8A09A40104_var*
begin
//#UC START# *49EC7545036C_4C8A09A40104_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EC7545036C_4C8A09A40104_impl*
end;//TPrimGroupListOptionsForm.Add

procedure TPrimGroupListOptionsForm.ChangeBaseAccess;
//#UC START# *49EC755501FB_4C8A09A40104_var*
//#UC END# *49EC755501FB_4C8A09A40104_var*
begin
//#UC START# *49EC755501FB_4C8A09A40104_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EC755501FB_4C8A09A40104_impl*
end;//TPrimGroupListOptionsForm.ChangeBaseAccess

procedure TPrimGroupListOptionsForm.Rename;
 {* Переименовать группу }
//#UC START# *49EEF22D004A_4C8A09A40104_var*
//#UC END# *49EEF22D004A_4C8A09A40104_var*
begin
//#UC START# *49EEF22D004A_4C8A09A40104_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EEF22D004A_4C8A09A40104_impl*
end;//TPrimGroupListOptionsForm.Rename

{$If NOT Defined(NoVCM)}
procedure TPrimGroupListOptionsForm.Delete;
 {* Удалить }
//#UC START# *4C7D0CC90052_4C8A09A40104_var*
//#UC END# *4C7D0CC90052_4C8A09A40104_var*
begin
//#UC START# *4C7D0CC90052_4C8A09A40104_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0CC90052_4C8A09A40104_impl*
end;//TPrimGroupListOptionsForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimGroupListOptionsForm);
 {* Регистрация PrimGroupListOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
