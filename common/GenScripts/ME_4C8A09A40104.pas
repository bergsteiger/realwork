unit PrimGroupListOptions_Form;
 {* Группы пользователей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimGroupListOptions_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimGroupListOptions" MUID: (4C8A09A40104)
// Имя типа: "TPrimGroupListOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimGroupList_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimGroupListOptionsForm = class(TPrimGroupListForm)
  {* Группы пользователей }
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimGroupListOptionsForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , Admin_Users_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4C8A09A40104impl_uses*
 //#UC END# *4C8A09A40104impl_uses*
;

{$If NOT Defined(NoVCM)}
procedure TPrimGroupListOptionsForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  ShowInContextMenu(en_Groups, op_Add, False);
  ShowInToolbar(en_Groups, op_Add, True);
  ShowInContextMenu(en_Groups, op_ChangeBaseAccess, True);
  ShowInToolbar(en_Groups, op_ChangeBaseAccess, False);
  ShowInContextMenu(en_Groups, op_Rename, True);
  ShowInToolbar(en_Groups, op_Rename, True);
  ShowInContextMenu(en_Edit, op_Delete, True);
  ShowInToolbar(en_Edit, op_Delete, True);
 end;//with Entities.Entities
end;//TPrimGroupListOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimGroupListOptionsForm);
 {* Регистрация PrimGroupListOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
