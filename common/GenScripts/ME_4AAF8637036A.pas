unit PrimPageSetup_Form;
 {* ��������� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimPageSetup_Form.pas"
// ���������: "VCMForm"

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
;

type
 TPrimPageSetupForm = class(TvcmEntityForm)
  {* ��������� �������� }
  private
   f_PreviewGroupBox: TvtGroupBox;
    {* ���� ��� �������� PreviewGroupBox }
   f_SettingsPageControl: TnscPageControl;
    {* ���� ��� �������� SettingsPageControl }
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
    {* ������� ������� ����� �������. }
  public
   class function Make(const aData: InsPageSettingsInfo): BadFactoryType; reintroduce;
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
 , l3StringIDEx
 , nsPageSetup
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
const
 {* ������������ ������ pstNoneLocalConstants }
 str_pstNoneCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pstNoneCaption'; rValue : '��������� ��������');
  {* ��������� ����������������� ���� "��������� ��������" }

function TPrimPageSetupForm.pm_GetPreviewGroupBox: TvtGroupBox;
//#UC START# *4AC608FA0372_4AAF8637036Aget_var*
//#UC END# *4AC608FA0372_4AAF8637036Aget_var*
begin
//#UC START# *4AC608FA0372_4AAF8637036Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC608FA0372_4AAF8637036Aget_impl*
end;//TPrimPageSetupForm.pm_GetPreviewGroupBox

function TPrimPageSetupForm.pm_GetSettingsPageControl: TnscPageControl;
//#UC START# *4AC60C6B023A_4AAF8637036Aget_var*
//#UC END# *4AC60C6B023A_4AAF8637036Aget_var*
begin
//#UC START# *4AC60C6B023A_4AAF8637036Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC60C6B023A_4AAF8637036Aget_impl*
end;//TPrimPageSetupForm.pm_GetSettingsPageControl

class function TPrimPageSetupForm.Make(const aData: InsPageSettingsInfo): BadFactoryType;
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
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_4AAF8637036A_var*
//#UC END# *479731C50290_4AAF8637036A_var*
begin
//#UC START# *479731C50290_4AAF8637036A_impl*
 f_PageSetup := nil;
 inherited;
//#UC END# *479731C50290_4AAF8637036A_impl*
end;//TPrimPageSetupForm.Cleanup

initialization
 str_pstNoneCaption.Init;
 {* ������������� str_pstNoneCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimPageSetupForm);
 {* ����������� PrimPageSetup }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin)
end.
