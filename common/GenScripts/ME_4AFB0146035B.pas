unit PrimAdmin_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimAdmin_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "PrimAdmin" MUID: (4AFB0146035B)
// Имя типа: "TPrimAdminForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 , vtProportionalPanel
 , vtSizeablePanel
 , vtPanel
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimAdminForm = class({$If NOT Defined(NoVCM)}
 TvcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  private
   f_BackgroundPanel: TvtProportionalPanel;
    {* Поле для свойства BackgroundPanel }
   f_PropertyZone: TvtSizeablePanel;
    {* Поле для свойства PropertyZone }
   f_TreeZone: TvtPanel;
    {* Поле для свойства TreeZone }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property BackgroundPanel: TvtProportionalPanel
    read f_BackgroundPanel;
   property PropertyZone: TvtSizeablePanel
    read f_PropertyZone;
   property TreeZone: TvtPanel
    read f_TreeZone;
 end;//TPrimAdminForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , l3StringIDEx
 , Admin_Users_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_ResultEx_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimAdmin_utAdmin_UserType
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

{$If NOT Defined(NoVCM)}
const
 {* Локализуемые строки utAdminLocalConstants }
 str_utAdminCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utAdminCaption'; rValue : 'Администрирование пользователей');
  {* Заголовок пользовательского типа "Администрирование пользователей" }

procedure TPrimAdminForm.InitFields;
//#UC START# *47A042E100E2_4AFB0146035B_var*
//#UC END# *47A042E100E2_4AFB0146035B_var*
begin
//#UC START# *47A042E100E2_4AFB0146035B_impl*
 inherited;
 ActiveControl := TreeZone;
//#UC END# *47A042E100E2_4AFB0146035B_impl*
end;//TPrimAdminForm.InitFields

procedure TPrimAdminForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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

procedure TPrimAdminForm.MakeControls;
begin
 inherited;
 with AddUsertype(utAdminName,
  str_utAdminCaption,
  str_utAdminCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utAdminName
 f_BackgroundPanel := TvtProportionalPanel.Create(Self);
 f_BackgroundPanel.Name := 'BackgroundPanel';
 f_BackgroundPanel.Parent := Self;
 f_PropertyZone := TvtSizeablePanel.Create(Self);
 f_PropertyZone.Name := 'PropertyZone';
 f_PropertyZone.Parent := BackgroundPanel;
 with DefineZone(vcm_ztChild, f_PropertyZone) do
 begin
 end;//with DefineZone(vcm_ztChild
 f_TreeZone := TvtPanel.Create(Self);
 f_TreeZone.Name := 'TreeZone';
 f_TreeZone.Parent := BackgroundPanel;
 with DefineZone(vcm_ztParent, f_TreeZone) do
 begin
 end;//with DefineZone(vcm_ztParent
end;//TPrimAdminForm.MakeControls

initialization
 str_utAdminCaption.Init;
 {* Инициализация str_utAdminCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimAdminForm);
 {* Регистрация PrimAdmin }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(Admin)
end.
