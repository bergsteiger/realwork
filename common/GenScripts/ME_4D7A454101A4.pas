unit PrimBaseSearchContainer_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\PrimBaseSearchContainer_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "PrimBaseSearchContainer" MUID: (4D7A454101A4)
// Имя типа: "TPrimBaseSearchContainerForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimSaveLoadOptionsForBaseSearch_Form
 , BaseSearchInterfaces
 , vtPanel
;

type
 // ztChild

 TPrimBaseSearchContainerForm = class(TPrimSaveLoadOptionsForBaseSearchForm, InsMainMenuLikeBaseSearchOwner)
  private
   f_ChildZone: TvtPanel;
    {* Поле для свойства ChildZone }
  protected
   function IsIt: Boolean;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   function DoGetFormSetImageIndex: Integer; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure NotifyUserTypeSet; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property ChildZone: TvtPanel
    read f_ChildZone;
 end;//TPrimBaseSearchContainerForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , nsTabbedInterfaceTypes
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TPrimBaseSearchContainerForm.IsIt: Boolean;
//#UC START# *4F20313F00E3_4D7A454101A4_var*
//#UC END# *4F20313F00E3_4D7A454101A4_var*
begin
//#UC START# *4F20313F00E3_4D7A454101A4_impl*
 Result := true;
//#UC END# *4F20313F00E3_4D7A454101A4_impl*
end;//TPrimBaseSearchContainerForm.IsIt

{$If NOT Defined(NoVCM)}
procedure TPrimBaseSearchContainerForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4D7A454101A4_var*
//#UC END# *4A8E8F2E0195_4D7A454101A4_var*
begin
//#UC START# *4A8E8F2E0195_4D7A454101A4_impl*
 inherited;
 ChildZone.Align := alTop;
 ChildZone.Top := pnHeader.Top + pnHeader.Height;
 ChildZone.Height := 122 + 13;
//#UC END# *4A8E8F2E0195_4D7A454101A4_impl*
end;//TPrimBaseSearchContainerForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimBaseSearchContainerForm.NotifyUserTypeSet;
//#UC START# *4D78E2BB0211_4D7A454101A4_var*
//#UC END# *4D78E2BB0211_4D7A454101A4_var*
begin
//#UC START# *4D78E2BB0211_4D7A454101A4_impl*
 inherited;
 ChildZone.Color := ParentZone.Color;
//#UC END# *4D78E2BB0211_4D7A454101A4_impl*
end;//TPrimBaseSearchContainerForm.NotifyUserTypeSet
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function TPrimBaseSearchContainerForm.DoGetFormSetImageIndex: Integer;
//#UC START# *53B649F600A3_4D7A454101A4_var*
//#UC END# *53B649F600A3_4D7A454101A4_var*
begin
//#UC START# *53B649F600A3_4D7A454101A4_impl*
 Result := NsTabIconIndex(titBaseSearch);
//#UC END# *53B649F600A3_4D7A454101A4_impl*
end;//TPrimBaseSearchContainerForm.DoGetFormSetImageIndex
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

{$If NOT Defined(NoVCM)}
procedure TPrimBaseSearchContainerForm.MakeControls;
begin
 inherited;
 f_ChildZone := TvtPanel.Create(Self);
 f_ChildZone.Name := 'ChildZone';
 f_ChildZone.Parent := Self;
 with DefineZone(vcm_ztChild, f_ChildZone) do
 begin
 end;//with DefineZone(vcm_ztChild
end;//TPrimBaseSearchContainerForm.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimBaseSearchContainerForm);
 {* Регистрация PrimBaseSearchContainer }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
