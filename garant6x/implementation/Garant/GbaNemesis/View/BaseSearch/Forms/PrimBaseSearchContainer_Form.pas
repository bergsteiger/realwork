unit PrimBaseSearchContainer_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaseSearch/Forms/PrimBaseSearchContainer_Form.pas"
// Начат: 11.03.2011 18:52
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 Основные прецеденты::BaseSearch::View::BaseSearch$Module::PrimBaseSearchContainer
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
  vtPanel,
  BaseSearchInterfaces,
  PrimSaveLoadOptionsForBaseSearch_Form,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimBaseSearchContainerForm = {form} class(TPrimSaveLoadOptionsForBaseSearchForm, InsMainMenuLikeBaseSearchOwner)
 private
 // private fields
   f_ChildZone : TvtPanel;
    {* Поле для свойства ChildZone}
 protected
  procedure MakeControls; override;
 protected
 // realized methods
   function IsIt: Boolean;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
    {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
   function DoGetFormSetImageIndex: Integer; override;
    {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
 public
 // overridden public methods
    {$If not defined(NoVCM)}
   procedure NotifyUserTypeSet; override;
     {* Сигнатура метода NotifyUserTypeSet }
    {$IfEnd} //not NoVCM
 public
 // public properties
   property ChildZone: TvtPanel
     read f_ChildZone;
 end;//TPrimBaseSearchContainerForm

 TvcmContainerFormRef = TPrimBaseSearchContainerForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  nsTabbedInterfaceTypes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimBaseSearchContainerForm

function TPrimBaseSearchContainerForm.IsIt: Boolean;
//#UC START# *4F20313F00E3_4D7A454101A4_var*
//#UC END# *4F20313F00E3_4D7A454101A4_var*
begin
//#UC START# *4F20313F00E3_4D7A454101A4_impl*
 Result := true;
//#UC END# *4F20313F00E3_4D7A454101A4_impl*
end;//TPrimBaseSearchContainerForm.IsIt

{$If not defined(NoVCM)}
procedure TPrimBaseSearchContainerForm.InitControls;
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimBaseSearchContainerForm.NotifyUserTypeSet;
//#UC START# *4D78E2BB0211_4D7A454101A4_var*
//#UC END# *4D78E2BB0211_4D7A454101A4_var*
begin
//#UC START# *4D78E2BB0211_4D7A454101A4_impl*
 inherited;
 ChildZone.Color := ParentZone.Color;
//#UC END# *4D78E2BB0211_4D7A454101A4_impl*
end;//TPrimBaseSearchContainerForm.NotifyUserTypeSet
{$IfEnd} //not NoVCM

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
function TPrimBaseSearchContainerForm.DoGetFormSetImageIndex: Integer;
//#UC START# *53B649F600A3_4D7A454101A4_var*
//#UC END# *53B649F600A3_4D7A454101A4_var*
begin
//#UC START# *53B649F600A3_4D7A454101A4_impl*
 Result := NsTabIconIndex(titBaseSearch);
//#UC END# *53B649F600A3_4D7A454101A4_impl*
end;//TPrimBaseSearchContainerForm.DoGetFormSetImageIndex
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

procedure TPrimBaseSearchContainerForm.MakeControls;
begin
 inherited;
 f_ChildZone := TvtPanel.Create(Self);
 f_ChildZone.Name := 'ChildZone';
 f_ChildZone.Parent := Self;
 with DefineZone(vcm_ztChild, f_ChildZone) do
 begin
 end;//with DefineZone(vcm_ztChild, f_ChildZone)
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimBaseSearchContainer
 TtfwClassRef.Register(TPrimBaseSearchContainerForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.