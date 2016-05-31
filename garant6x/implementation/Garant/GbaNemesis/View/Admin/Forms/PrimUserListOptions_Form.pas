unit PrimUserListOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimUserListOptions_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimUserListOptions" MUID: (4C7CE50101B3)
// Имя типа: "TPrimUserListOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimUserList_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimUserListOptionsForm = class(TPrimUserListForm)
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimUserListOptionsForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Admin_Users_Controls
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4C7CE50101B3impl_uses*
 //#UC END# *4C7CE50101B3impl_uses*
;

{$If NOT Defined(NoVCM)}
procedure TPrimUserListOptionsForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  ShowInContextMenu(en_Edit, op_Delete, True);
  ShowInToolbar(en_Edit, op_Delete, False);
  ShowInContextMenu(en_Users, op_Add, False);
  ShowInToolbar(en_Users, op_Add, True);
  ShowInContextMenu(en_Users, op_LogoutUser, False);
  ShowInToolbar(en_Users, op_LogoutUser, True);
  ShowInContextMenu(en_Users, op_ConsultingStateForNewbie, False);
  ShowInToolbar(en_Users, op_ConsultingStateForNewbie, True);
  ShowInContextMenu(en_Users, op_Autoregistration, False);
  ShowInToolbar(en_Users, op_Autoregistration, True);
  ShowInContextMenu(en_Users, op_AddPrivelegedRight, True);
  ShowInToolbar(en_Users, op_AddPrivelegedRight, False);
  ShowInContextMenu(en_Users, op_RemovePrivelegedRight, True);
  ShowInToolbar(en_Users, op_RemovePrivelegedRight, False);
  ShowInContextMenu(en_Users, op_UserFilter, False);
  ShowInToolbar(en_Users, op_UserFilter, True);
  ShowInContextMenu(en_Users, op_DisableConsulting, True);
  ShowInToolbar(en_Users, op_DisableConsulting, True);
  ShowInContextMenu(en_Users, op_EnableConsulting, True);
  ShowInToolbar(en_Users, op_EnableConsulting, True);
 end;//with Entities.Entities
end;//TPrimUserListOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimUserListOptionsForm);
 {* Регистрация PrimUserListOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
