unit PrimPageSetup_Form;
 {* Настройка страницы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimPageSetup_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimPageSetup" MUID: (4AAF8637036A)
// Имя типа: "TPrimPageSetupForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , ConfigInterfaces
 , vtGroupBox
 {$If Defined(Nemesis)}
 , nscPageControl
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimPageSetupForm = class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Настройка страницы }
  private
   f_PreviewGroupBox: TvtGroupBox;
    {* Поле для свойства PreviewGroupBox }
   f_SettingsPageControl: TnscPageControl;
    {* Поле для свойства SettingsPageControl }
  protected
   f_CurrentColontitul: Integer;
   f_PageSetup: InsPageSettingsInfo;
   f_DisableControls: Boolean;
  protected
   function pm_GetPreviewGroupBox: TvtGroupBox;
   function pm_GetSettingsPageControl: TnscPageControl;
   procedure ReadPageFormats; virtual; abstract;
   procedure SetColontitulComboBoxItemIndex(aIndex: Integer); virtual; abstract;
   procedure ToGUIMargins; virtual; abstract;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function Make(const aData: InsPageSettingsInfo): IvcmEntityForm; reintroduce;
  public
   property PreviewGroupBox: TvtGroupBox
    read pm_GetPreviewGroupBox;
   property SettingsPageControl: TnscPageControl
    read pm_GetSettingsPageControl;
 end;//TPrimPageSetupForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , nsPageSetup
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimPageSetup_pstNone_UserType
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4AAF8637036Aimpl_uses*
 //#UC END# *4AAF8637036Aimpl_uses*
;

{$If NOT Defined(NoVCM)}
function TPrimPageSetupForm.pm_GetPreviewGroupBox: TvtGroupBox;
begin
 if (f_PreviewGroupBox = nil) then
  f_PreviewGroupBox := FindComponent('PreviewGroupBox') As TvtGroupBox;
 Result := f_PreviewGroupBox;
end;//TPrimPageSetupForm.pm_GetPreviewGroupBox

function TPrimPageSetupForm.pm_GetSettingsPageControl: TnscPageControl;
begin
 if (f_SettingsPageControl = nil) then
  f_SettingsPageControl := FindComponent('SettingsPageControl') As TnscPageControl;
 Result := f_SettingsPageControl;
end;//TPrimPageSetupForm.pm_GetSettingsPageControl

class function TPrimPageSetupForm.Make(const aData: InsPageSettingsInfo): IvcmEntityForm;
var
 l_Inst : TPrimPageSetupForm;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrimPageSetupForm.Make

procedure TPrimPageSetupForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4AAF8637036A_var*
//#UC END# *479731C50290_4AAF8637036A_var*
begin
//#UC START# *479731C50290_4AAF8637036A_impl*
 f_PageSetup := nil;
 inherited;
//#UC END# *479731C50290_4AAF8637036A_impl*
end;//TPrimPageSetupForm.Cleanup

procedure TPrimPageSetupForm.MakeControls;
begin
 inherited;
 with AddUsertype(pstNoneName,
  str_pstNoneCaption,
  str_pstNoneCaption,
  True,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(pstNoneName
end;//TPrimPageSetupForm.MakeControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimPageSetupForm);
 {* Регистрация PrimPageSetup }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin)
end.
