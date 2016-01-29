unit PrimAdmin_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/PrimAdmin_Form.pas"
// Начат: 11.11.2009 21:24
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 Администратор::Admin::View::Admin::PrimAdmin
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmContainerForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  PrimAdmin_utAdmin_UserType,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 TPrimAdminForm = {form} class(TvcmContainerForm)
 private
 // private fields
   f_BackgroundPanel : TvtProportionalPanel;
    {* Поле для свойства BackgroundPanel}
   f_PropertyZone : TvtSizeablePanel;
    {* Поле для свойства PropertyZone}
   f_TreeZone : TvtPanel;
    {* Поле для свойства TreeZone}
 protected
  procedure MakeControls; override;
 protected
 // overridden protected methods
   procedure InitFields; override;
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 public
 // public properties
   property BackgroundPanel: TvtProportionalPanel
     read f_BackgroundPanel;
   property PropertyZone: TvtSizeablePanel
     read f_PropertyZone;
   property TreeZone: TvtPanel
     read f_TreeZone;
 end;//TPrimAdminForm
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
uses
  Admin_Users_Controls
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_ResultEx_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}

var
   { Локализуемые строки utAdminLocalConstants }
  str_utAdminCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utAdminCaption'; rValue : 'Администрирование пользователей');
   { Заголовок пользовательского типа "Администрирование пользователей" }

// start class TPrimAdminForm

procedure TPrimAdminForm.InitFields;
//#UC START# *47A042E100E2_4AFB0146035B_var*
//#UC END# *47A042E100E2_4AFB0146035B_var*
begin
//#UC START# *47A042E100E2_4AFB0146035B_impl*
 inherited;
 ActiveControl := TreeZone;
//#UC END# *47A042E100E2_4AFB0146035B_impl*
end;//TPrimAdminForm.InitFields

{$If not defined(NoVCM)}
procedure TPrimAdminForm.InitControls;
//#UC START# *4A8E8F2E0195_4AFB0146035B_var*
//#UC END# *4A8E8F2E0195_4AFB0146035B_var*
begin
//#UC START# *4A8E8F2E0195_4AFB0146035B_impl*
 inherited;
 with BackgroundPanel do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;
 with TreeZone do
 begin
  Align := alClient;
  BevelOuter := bvNone;
  Constraints.MinHeight := 100;
 end;
 with PropertyZone do
 begin
  ResizeAreaWidth := 5;
  SizeableSides := [szTop];
  SplitterBevel := bvRaised;
  Align := alBottom;
  Height := 195;
  BevelOuter := bvNone;
 end;
//#UC END# *4A8E8F2E0195_4AFB0146035B_impl*
end;//TPrimAdminForm.InitControls
{$IfEnd} //not NoVCM

procedure TPrimAdminForm.MakeControls;
begin
 inherited;
 f_BackgroundPanel := TvtProportionalPanel.Create(Self);
 f_BackgroundPanel.Name := 'BackgroundPanel';
 f_BackgroundPanel.Parent := Self;
 f_PropertyZone := TvtSizeablePanel.Create(Self);
 f_PropertyZone.Name := 'PropertyZone';
 f_PropertyZone.Parent := BackgroundPanel;
 with DefineZone(vcm_ztChild, f_PropertyZone) do
 begin
 end;//with DefineZone(vcm_ztChild, f_PropertyZone)
 f_TreeZone := TvtPanel.Create(Self);
 f_TreeZone.Name := 'TreeZone';
 f_TreeZone.Parent := BackgroundPanel;
 with DefineZone(vcm_ztParent, f_TreeZone) do
 begin
 end;//with DefineZone(vcm_ztParent, f_TreeZone)
 with AddUsertype(utAdminName,
  str_utAdminCaption,
  str_utAdminCaption,
  true,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utAdminName
end;

{$IfEnd} //Admin

initialization
{$If defined(Admin)}
// Инициализация str_utAdminCaption
 str_utAdminCaption.Init;
{$IfEnd} //Admin
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация PrimAdmin
 TtfwClassRef.Register(TPrimAdminForm);
{$IfEnd} //Admin AND not NoScripts

end.