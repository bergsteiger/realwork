unit Settings_Module;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Settings_Module.pas"
// ���������: "VCMFormsPack"
// ������� ������: "Settings" MUID: (4AA79F72010A)
// ��� ����: "TSettingsModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ConfigInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TSettingsModule = class(TvcmModule)
  protected
   procedure OpenStyleEditorAsModal; overload;
    {* �������� ������... }
   procedure AutoLogin;
    {* �������������� ���� � ������� }
   procedure SelectConfig;
    {* ����� ������������ }
   procedure OpenConfList; overload;
    {* ������ ������������ }
   procedure LoadActiveSettings;
    {* ��������� ������������... }
   procedure UserProperties;
    {* �������� ��� ��������������� ������... }
  public
   function OpenStyleEditorAsModal(const aData: InsStyleTableSettingsInfo): Integer; overload;
   procedure CloseConfList(const aContainer: IvcmContainer);
    {* ������� ������ ������������ }
   procedure LoadSettings(const anAggregate: IvcmAggregate;
    const aData: InsConfigSettingsInfo);
    {* ������� ��������� }
   procedure OpenConfList(const aContainer: IvcmContainer); overload;
 end;//TSettingsModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , PrimStyleEditorExample_utStyleEditorExample_UserType
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsStyleEditor
 , evStyleInterface
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , nsSettingsUtils
 , DataAdapter
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , nsConfigurationList
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , SelfInfo_Form
;

{$If NOT Defined(NoVCM)}
function TSettingsModule.OpenStyleEditorAsModal(const aData: InsStyleTableSettingsInfo): Integer;
var l_SettingsData: InsStyleTableSettingsInfo;
var l_Container: IvcmEntityForm;
var l_Params: IvcmMakeParams;
//#UC START# *4ABA122E00AE_4AA79F72010A_var*
//#UC END# *4ABA122E00AE_4AA79F72010A_var*
begin
//#UC START# *4ABA122E00AE_4AA79F72010A_impl*
 Result := mrNone;
 if (aData = nil) then
  l_SettingsData := TnsStyleTableSettingsInfo.Make
 else
  l_SettingsData := aData;
 try
  l_Params := vcmCheckAggregate(vcmMakeParams);
  try
   with TevStyleInterface.Make do
    try
     Changing;
     try
      l_Container := TStyleEditorContainerForm.Make(l_SettingsData, l_Params);
      try
       l_Params := vcmMakeParams(l_Params.Aggregate, l_Container.AsContainer, l_Params.Owner);
       TStyleEditorExampleForm.Make(l_Params, vcm_ztChild,
        Ord(utStyleEditorExample));
       TStyleEditorFontForm.Make(l_SettingsData, l_Params);
       TStyleEditorNavigatorForm.Make(l_Params);
       Result := l_Container.ShowModal;
       if (Result <> mrOk) or not l_SettingsData.IsActive then
        LoadStyleTableFromSettings;
      finally
       l_Container := nil;
      end;//try..finally
     finally
      ChangedEx((Result = mrOk) and not l_SettingsData.IsActive);
     end;//try..finally
    finally
     Free;
    end;//try..finally
  finally
   l_Params := nil;
  end;//try..finally
 finally
  l_SettingsData := nil;
 end;//try..finally
//#UC END# *4ABA122E00AE_4AA79F72010A_impl*
end;//TSettingsModule.OpenStyleEditorAsModal

procedure TSettingsModule.OpenStyleEditorAsModal;
 {* �������� ������... }
//#UC START# *4ABB46310087_4AA79F72010A_var*
//#UC END# *4ABB46310087_4AA79F72010A_var*
begin
//#UC START# *4ABB46310087_4AA79F72010A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABB46310087_4AA79F72010A_impl*
end;//TSettingsModule.OpenStyleEditorAsModal

procedure TSettingsModule.AutoLogin;
 {* �������������� ���� � ������� }
//#UC START# *4ABB49400064_4AA79F72010A_var*
//#UC END# *4ABB49400064_4AA79F72010A_var*
begin
//#UC START# *4ABB49400064_4AA79F72010A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABB49400064_4AA79F72010A_impl*
end;//TSettingsModule.AutoLogin

procedure TSettingsModule.SelectConfig;
 {* ����� ������������ }
//#UC START# *4ABB4BB100C0_4AA79F72010A_var*
//#UC END# *4ABB4BB100C0_4AA79F72010A_var*
begin
//#UC START# *4ABB4BB100C0_4AA79F72010A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABB4BB100C0_4AA79F72010A_impl*
end;//TSettingsModule.SelectConfig

procedure TSettingsModule.OpenConfList;
 {* ������ ������������ }
//#UC START# *4ABB4E9A0064_4AA79F72010A_var*
//#UC END# *4ABB4E9A0064_4AA79F72010A_var*
begin
//#UC START# *4ABB4E9A0064_4AA79F72010A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABB4E9A0064_4AA79F72010A_impl*
end;//TSettingsModule.OpenConfList

procedure TSettingsModule.CloseConfList(const aContainer: IvcmContainer);
 {* ������� ������ ������������ }
//#UC START# *4ABB51300045_4AA79F72010A_var*
var
 l_Form: IvcmEntityForm;
//#UC END# *4ABB51300045_4AA79F72010A_var*
begin
//#UC START# *4ABB51300045_4AA79F72010A_impl*
 Assert(aContainer <> nil);
 aContainer.HasForm(fm_en_ConfigurationList.rFormID,
                    vcm_ztNavigator,
                    True,
                    @l_Form);
 if l_Form <> nil then
  l_Form.SafeClose;
//#UC END# *4ABB51300045_4AA79F72010A_impl*
end;//TSettingsModule.CloseConfList

procedure TSettingsModule.LoadSettings(const anAggregate: IvcmAggregate;
 const aData: InsConfigSettingsInfo);
 {* ������� ��������� }
//#UC START# *4ABB5496029E_4AA79F72010A_var*
//#UC END# *4ABB5496029E_4AA79F72010A_var*
begin
//#UC START# *4ABB5496029E_4AA79F72010A_impl*
 (* aParams �������� ������������� ������������ (IConfiguration), ���������� ��
  enConfigurationList *)
 Result := Tcf_Settings.Make(aData, vcmMakeParams(anAggregate), vcm_ztModal);
//#UC END# *4ABB5496029E_4AA79F72010A_impl*
end;//TSettingsModule.LoadSettings

procedure TSettingsModule.LoadActiveSettings;
 {* ��������� ������������... }
//#UC START# *4ABB5926039A_4AA79F72010A_var*
//#UC END# *4ABB5926039A_4AA79F72010A_var*
begin
//#UC START# *4ABB5926039A_4AA79F72010A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABB5926039A_4AA79F72010A_impl*
end;//TSettingsModule.LoadActiveSettings

procedure TSettingsModule.OpenConfList(const aContainer: IvcmContainer);
//#UC START# *4AC0FF9D0332_4AA79F72010A_var*
var
 l_Form : IvcmEntityForm;
//#UC END# *4AC0FF9D0332_4AA79F72010A_var*
begin
//#UC START# *4AC0FF9D0332_4AA79F72010A_impl*
 l_Form := Ten_ConfigurationList.MakeSingleChild(CheckContainer(aContainer),
                             vcmCheckAggregate(
                              vcmMakeParams(nil,
                                        CheckContainer(aContainer))),
                             vcm_ztNavigator);

 if (l_Form <> nil) then
  l_Form.SetActiveInParent;
//#UC END# *4AC0FF9D0332_4AA79F72010A_impl*
end;//TSettingsModule.OpenConfList

procedure TSettingsModule.UserProperties;
 {* �������� ��� ��������������� ������... }
//#UC START# *4B506F0902B5_4AA79F72010A_var*
//#UC END# *4B506F0902B5_4AA79F72010A_var*
begin
//#UC START# *4B506F0902B5_4AA79F72010A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B506F0902B5_4AA79F72010A_impl*
end;//TSettingsModule.UserProperties
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
