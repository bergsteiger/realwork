unit nsHAFPainter;
 {* - }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\nsHAFPainter.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , nsHAFPainterPrim
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , afwInterfaces
 , l3InternalInterfaces
;

type
 TnsHAFPainter = class(TnsHAFPainterPrim{$If NOT Defined(NoVCM)}
 , IvcmSettingsSource
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* - }
  private
   f_BaseId: AnsiString;
   f_Settings: IvcmSettings;
    {* Поле для свойства Settings }
  protected
   function pm_GetSettings: IafwSettings;
   procedure pm_SetSettings(const aValue: IafwSettings);
   function pm_GetBaseId: AnsiString;
   procedure pm_SetBaseId(const aValue: AnsiString);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
   function IsSettingAffectsUs(const aSettingId: TafwSettingId): Boolean; override;
  public
   constructor Create(const aMacroReplacer: Il3HAFMacroReplacer); override;
   procedure ReadColontitulSettings; override;
  public
   property Settings: IvcmSettings
    read f_Settings;
 end;//TnsHAFPainter
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , SysUtils
 , afwFacade
 , evTypes
 , nsConst
 , nsSettings
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
;

function TnsHAFPainter.pm_GetSettings: IafwSettings;
//#UC START# *473DA149020D_47F2317F015Eget_var*
//#UC END# *473DA149020D_47F2317F015Eget_var*
begin
//#UC START# *473DA149020D_47F2317F015Eget_impl*
 Result := f_Settings;
//#UC END# *473DA149020D_47F2317F015Eget_impl*
end;//TnsHAFPainter.pm_GetSettings

procedure TnsHAFPainter.pm_SetSettings(const aValue: IafwSettings);
//#UC START# *473DA149020D_47F2317F015Eset_var*
//#UC END# *473DA149020D_47F2317F015Eset_var*
begin
//#UC START# *473DA149020D_47F2317F015Eset_impl*
 f_Settings := aValue;
//#UC END# *473DA149020D_47F2317F015Eset_impl*
end;//TnsHAFPainter.pm_SetSettings

function TnsHAFPainter.pm_GetBaseId: AnsiString;
//#UC START# *473DA15800E2_47F2317F015Eget_var*
//#UC END# *473DA15800E2_47F2317F015Eget_var*
begin
//#UC START# *473DA15800E2_47F2317F015Eget_impl*
 Result := f_BaseId;
//#UC END# *473DA15800E2_47F2317F015Eget_impl*
end;//TnsHAFPainter.pm_GetBaseId

procedure TnsHAFPainter.pm_SetBaseId(const aValue: AnsiString);
//#UC START# *473DA15800E2_47F2317F015Eset_var*
//#UC END# *473DA15800E2_47F2317F015Eset_var*
begin
//#UC START# *473DA15800E2_47F2317F015Eset_impl*
 f_BaseId := aValue;
//#UC END# *473DA15800E2_47F2317F015Eset_impl*
end;//TnsHAFPainter.pm_SetBaseId

procedure TnsHAFPainter.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_47F2317F015E_var*
//#UC END# *479731C50290_47F2317F015E_var*
begin
//#UC START# *479731C50290_47F2317F015E_impl*
 f_Settings := nil;
 inherited;
//#UC END# *479731C50290_47F2317F015E_impl*
end;//TnsHAFPainter.Cleanup

procedure TnsHAFPainter.ClearFields;
begin
 f_Settings := nil;
 inherited;
end;//TnsHAFPainter.ClearFields

constructor TnsHAFPainter.Create(const aMacroReplacer: Il3HAFMacroReplacer);
//#UC START# *5243CCEE0271_47F2317F015E_var*
//#UC END# *5243CCEE0271_47F2317F015E_var*
begin
//#UC START# *5243CCEE0271_47F2317F015E_impl*
 if (afw.Application <> nil) then
  f_Settings := afw.Application.Settings;
 inherited;
//#UC END# *5243CCEE0271_47F2317F015E_impl*
end;//TnsHAFPainter.Create

function TnsHAFPainter.IsSettingAffectsUs(const aSettingId: TafwSettingId): Boolean;
//#UC START# *5243E95503E4_47F2317F015E_var*
//#UC END# *5243E95503E4_47F2317F015E_var*
begin
//#UC START# *5243E95503E4_47F2317F015E_impl*
 Result := ANSISameText(aSettingId, pi_Print_Catchwords_First_UpLeft) or
           ANSISameText(aSettingId, pi_Print_Catchwords_First_UpRight) or
           ANSISameText(aSettingId, pi_Print_Catchwords_First_BottomLeft) or
           ANSISameText(aSettingId, pi_Print_Catchwords_First_BottomRight) or

           ANSISameText(aSettingId, pi_Print_Catchwords_Other_UpLeft) or
           ANSISameText(aSettingId, pi_Print_Catchwords_Other_UpRight) or
           ANSISameText(aSettingId, pi_Print_Catchwords_Other_BottomLeft) or
           ANSISameText(aSettingId, pi_Print_Catchwords_Other_BottomRight);
//#UC END# *5243E95503E4_47F2317F015E_impl*
end;//TnsHAFPainter.IsSettingAffectsUs

procedure TnsHAFPainter.ReadColontitulSettings;
//#UC START# *5243E9AE0230_47F2317F015E_var*
//#UC END# *5243E9AE0230_47F2317F015E_var*
begin
//#UC START# *5243E9AE0230_47F2317F015E_impl*
 inherited;
 if (Settings <> nil) then
  with Settings do
  begin
   f_Colontituls[pcUpLeftFirst] := LoadString(pi_Print_Catchwords_First_UpLeft, dv_Print_Catchwords_First_UpLeft);
   f_Colontituls[pcUpRightFirst] := LoadString(pi_Print_Catchwords_First_UpRight, dv_Print_Catchwords_First_UpRight);
   f_Colontituls[pcDownLeftFirst] := LoadString(pi_Print_Catchwords_First_BottomLeft, dv_Print_Catchwords_First_BottomLeft);
   f_Colontituls[pcDownRightFirst] := LoadString(pi_Print_Catchwords_First_BottomRight, dv_Print_Catchwords_First_BottomRight);
  //
   f_Colontituls[pcUpLeft] := LoadString(pi_Print_Catchwords_Other_UpLeft, dv_Print_Catchwords_Other_UpLeft);
   f_Colontituls[pcUpRight] := LoadString(pi_Print_Catchwords_Other_UpRight, dv_Print_Catchwords_Other_UpRight);
   f_Colontituls[pcDownLeft] := LoadString(pi_Print_Catchwords_Other_BottomLeft, dv_Print_Catchwords_Other_BottomLeft);
   f_Colontituls[pcDownRight] := LoadString(pi_Print_Catchwords_Other_BottomRight, dv_Print_Catchwords_Other_BottomRight);
  end;//with Settings
//#UC END# *5243E9AE0230_47F2317F015E_impl*
end;//TnsHAFPainter.ReadColontitulSettings
{$IfEnd} // NOT Defined(Admin)

end.
