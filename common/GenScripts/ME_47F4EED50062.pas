unit NOT_FINISHED_vcmForm;
 {* ������� ���������� �����. }

// ������: "w:\common\components\gui\Garant\VCM\implementation\Visual\NOT_FINISHED_vcmForm.pas"
// ���������: "UtilityPack"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmUserInteractiveForm
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , afwInterfaces
 , vcmLayoutImplementation
;

type
 TvcmCloseQueryEvent = procedure(Sender: TObject;
  var CanClose: Boolean;
  aCaller: TCustomForm) of object;

 TvcmInterfacedForm = class(TvcmUserInteractiveForm)
  protected
   procedure DoSaveInSettings; virtual;
   procedure ClearModal; virtual;
   function SafeClose: Boolean; virtual; abstract;
   function CallCloseQuery(aCaller: TCustomForm): Boolean; virtual;
  public
   function NeedSaveInSettings: Boolean; virtual;
 end;//TvcmInterfacedForm

 TvcmTextForm = class(TvcmInterfacedForm, IafwTextControl)
  protected
   function pm_GetCCaption: IafwCString;
   procedure pm_SetCCaption(const aValue: IafwCString);
   function SafeClose: Boolean; override;
 end;//TvcmTextForm

 TvcmFormImplementation = class(TvcmLayoutImplementation)
  protected
   function GetIsAcceptable(aDataUpdate: Boolean): Boolean; override;
    {* ����� �� ��������� ����� � ������� �������� (��������, �� ������� ����) }
 end;//TvcmFormImplementation

 TvcmForm = class(TvcmTextForm)
  protected
   procedure DoLoadFromSettings; virtual;
   function NeedNotifyContainerOnCaptionChanged: Boolean; virtual;
   function IsAcceptable(aDataUpdate: Boolean): Boolean; virtual;
    {* ����� �� ��������� ����� � ������� �������� (��������, �� ������� ����) }
 end;//TvcmForm

 TvcmCloseQueryEvent = procedure(Sender: TObject;
  var CanClose: Boolean;
  aCaller: TCustomForm) of object;
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVGScene)}
 , vcmDialogs
 {$IfEnd} // NOT Defined(NoVGScene)
 , vtDialogsResEx
;

procedure TvcmInterfacedForm.DoSaveInSettings;
//#UC START# *4F7B072201AA_49525AB4009E_var*
//#UC END# *4F7B072201AA_49525AB4009E_var*
begin
//#UC START# *4F7B072201AA_49525AB4009E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F7B072201AA_49525AB4009E_impl*
end;//TvcmInterfacedForm.DoSaveInSettings

function TvcmInterfacedForm.NeedSaveInSettings: Boolean;
//#UC START# *4FC38C4C0119_49525AB4009E_var*
//#UC END# *4FC38C4C0119_49525AB4009E_var*
begin
//#UC START# *4FC38C4C0119_49525AB4009E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FC38C4C0119_49525AB4009E_impl*
end;//TvcmInterfacedForm.NeedSaveInSettings

procedure TvcmInterfacedForm.ClearModal;
//#UC START# *501FEC7203A5_49525AB4009E_var*
//#UC END# *501FEC7203A5_49525AB4009E_var*
begin
//#UC START# *501FEC7203A5_49525AB4009E_impl*
 !!! Needs to be implemented !!!
//#UC END# *501FEC7203A5_49525AB4009E_impl*
end;//TvcmInterfacedForm.ClearModal

function TvcmInterfacedForm.CallCloseQuery(aCaller: TCustomForm): Boolean;
//#UC START# *4980407F0076_49525AB4009E_var*
//#UC END# *4980407F0076_49525AB4009E_var*
begin
//#UC START# *4980407F0076_49525AB4009E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4980407F0076_49525AB4009E_impl*
end;//TvcmInterfacedForm.CallCloseQuery

function TvcmTextForm.pm_GetCCaption: IafwCString;
//#UC START# *473DAC05025F_49525AC30370get_var*
//#UC END# *473DAC05025F_49525AC30370get_var*
begin
//#UC START# *473DAC05025F_49525AC30370get_impl*
 !!! Needs to be implemented !!!
//#UC END# *473DAC05025F_49525AC30370get_impl*
end;//TvcmTextForm.pm_GetCCaption

procedure TvcmTextForm.pm_SetCCaption(const aValue: IafwCString);
//#UC START# *473DAC05025F_49525AC30370set_var*
//#UC END# *473DAC05025F_49525AC30370set_var*
begin
//#UC START# *473DAC05025F_49525AC30370set_impl*
 !!! Needs to be implemented !!!
//#UC END# *473DAC05025F_49525AC30370set_impl*
end;//TvcmTextForm.pm_SetCCaption

function TvcmTextForm.SafeClose: Boolean;
//#UC START# *537B402502DD_49525AC30370_var*
//#UC END# *537B402502DD_49525AC30370_var*
begin
//#UC START# *537B402502DD_49525AC30370_impl*
 !!! Needs to be implemented !!!
//#UC END# *537B402502DD_49525AC30370_impl*
end;//TvcmTextForm.SafeClose

function TvcmFormImplementation.GetIsAcceptable(aDataUpdate: Boolean): Boolean;
 {* ����� �� ��������� ����� � ������� �������� (��������, �� ������� ����) }
//#UC START# *55127C030325_4F22CFBC016D_var*
//#UC END# *55127C030325_4F22CFBC016D_var*
begin
//#UC START# *55127C030325_4F22CFBC016D_impl*
 !!! Needs to be implemented !!!
//#UC END# *55127C030325_4F22CFBC016D_impl*
end;//TvcmFormImplementation.GetIsAcceptable

procedure TvcmForm.DoLoadFromSettings;
//#UC START# *4E7C2AA3037E_49525AED007D_var*
//#UC END# *4E7C2AA3037E_49525AED007D_var*
begin
//#UC START# *4E7C2AA3037E_49525AED007D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E7C2AA3037E_49525AED007D_impl*
end;//TvcmForm.DoLoadFromSettings

function TvcmForm.NeedNotifyContainerOnCaptionChanged: Boolean;
//#UC START# *546304500231_49525AED007D_var*
//#UC END# *546304500231_49525AED007D_var*
begin
//#UC START# *546304500231_49525AED007D_impl*
 !!! Needs to be implemented !!!
//#UC END# *546304500231_49525AED007D_impl*
end;//TvcmForm.NeedNotifyContainerOnCaptionChanged

function TvcmForm.IsAcceptable(aDataUpdate: Boolean): Boolean;
 {* ����� �� ��������� ����� � ������� �������� (��������, �� ������� ����) }
//#UC START# *55127A5401DE_49525AED007D_var*
//#UC END# *55127A5401DE_49525AED007D_var*
begin
//#UC START# *55127A5401DE_49525AED007D_impl*
 !!! Needs to be implemented !!!
//#UC END# *55127A5401DE_49525AED007D_impl*
end;//TvcmForm.IsAcceptable

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmInterfacedForm);
 {* ����������� TvcmInterfacedForm }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmTextForm);
 {* ����������� TvcmTextForm }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmForm);
 {* ����������� TvcmForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
