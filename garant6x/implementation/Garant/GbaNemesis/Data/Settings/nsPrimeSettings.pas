unit nsPrimeSettings;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Settings/nsPrimeSettings.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Data::Settings::TnsPrimeSettings
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(nsWithoutLogin)}
uses
  afwInterfaces,
  PrimeUnit,
  bsInterfaces,
  nsSettingsPrim,
  SettingsUnit
  ;
{$IfEnd} //nsWithoutLogin

{$If defined(nsWithoutLogin)}
type
 TnsPrimeSettings = class(TnsSettingsPrim, IafwSettings, InsSettingsNotify, InsSettings)
 private
 // private fields
   f_State : TafwSettingsState;
 protected
 // realized methods
   function pm_GetState: TafwSettingsState;
   procedure pm_SetState(aValue: TafwSettingsState);
   procedure AddListener(const aListener: InsUserSettingsEditListener); overload; 
   procedure RemoveListener(const aListener: InsUserSettingsEditListener); overload; 
   procedure AddListener(const aListener: InsUserSettingsListener); overload; 
   procedure RemoveListener(const aListener: InsUserSettingsListener); overload; 
   procedure StartEdit;
     {* вызывается перед началом редактирования }
   procedure UserSettingsChanged;
     {* при изменении\восстановлении пользовательских настроек }
   procedure StartReplace;
     {* вызывается перед переключением конфигурации }
   procedure FinishReplace;
     {* вызывается по окончании переключения конфигурации }
   function pm_GetSettingsNotify: InsSettingsNotify;
   function pm_GetData: ISettingsManager;
   procedure pm_SetData(const aValue: ISettingsManager);
   function LoadDouble(const aSettingId: TafwSettingId;
    aDefault: Double = 0;
    aRestoreDefault: Boolean = False): Double;
   procedure SaveDouble(const aSettingId: TafwSettingId;
    aValue: Double;
    aDefault: Double = 0;
    aSetAsDefault: Boolean = False);
 public
 // public methods
   class function Make(const aSettings: IPrimeSettingsManager): IafwSettings; reintroduce;
   constructor Create(const aSettings: IPrimeSettingsManager); reintroduce;
 end;//TnsPrimeSettings
{$IfEnd} //nsWithoutLogin

implementation

{$If defined(nsWithoutLogin)}

// start class TnsPrimeSettings

class function TnsPrimeSettings.Make(const aSettings: IPrimeSettingsManager): IafwSettings;
var
 l_Inst : TnsPrimeSettings;
begin
 l_Inst := Create(aSettings);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

constructor TnsPrimeSettings.Create(const aSettings: IPrimeSettingsManager);
//#UC START# *4C99BA8A0231_4C99AEBC01B3_var*
//#UC END# *4C99BA8A0231_4C99AEBC01B3_var*
begin
//#UC START# *4C99BA8A0231_4C99AEBC01B3_impl*
 inherited Create(aSettings);
 f_State := afw_ssNone;
//#UC END# *4C99BA8A0231_4C99AEBC01B3_impl*
end;//TnsPrimeSettings.Create

function TnsPrimeSettings.pm_GetState: TafwSettingsState;
//#UC START# *48896A7B0311_4C99AEBC01B3get_var*
//#UC END# *48896A7B0311_4C99AEBC01B3get_var*
begin
//#UC START# *48896A7B0311_4C99AEBC01B3get_impl*
 Result := f_State;
//#UC END# *48896A7B0311_4C99AEBC01B3get_impl*
end;//TnsPrimeSettings.pm_GetState

procedure TnsPrimeSettings.pm_SetState(aValue: TafwSettingsState);
//#UC START# *48896A7B0311_4C99AEBC01B3set_var*
//#UC END# *48896A7B0311_4C99AEBC01B3set_var*
begin
//#UC START# *48896A7B0311_4C99AEBC01B3set_impl*
 f_State := aValue;
//#UC END# *48896A7B0311_4C99AEBC01B3set_impl*
end;//TnsPrimeSettings.pm_SetState

procedure TnsPrimeSettings.AddListener(const aListener: InsUserSettingsEditListener);
//#UC START# *4914446E0280_4C99AEBC01B3_var*
//#UC END# *4914446E0280_4C99AEBC01B3_var*
begin
//#UC START# *4914446E0280_4C99AEBC01B3_impl*
// Do nothing
//#UC END# *4914446E0280_4C99AEBC01B3_impl*
end;//TnsPrimeSettings.AddListener

procedure TnsPrimeSettings.RemoveListener(const aListener: InsUserSettingsEditListener);
//#UC START# *4914447B01C4_4C99AEBC01B3_var*
//#UC END# *4914447B01C4_4C99AEBC01B3_var*
begin
//#UC START# *4914447B01C4_4C99AEBC01B3_impl*
// Do nothing
//#UC END# *4914447B01C4_4C99AEBC01B3_impl*
end;//TnsPrimeSettings.RemoveListener

procedure TnsPrimeSettings.AddListener(const aListener: InsUserSettingsListener);
//#UC START# *491444880189_4C99AEBC01B3_var*
//#UC END# *491444880189_4C99AEBC01B3_var*
begin
//#UC START# *491444880189_4C99AEBC01B3_impl*
// Do nothing
//#UC END# *491444880189_4C99AEBC01B3_impl*
end;//TnsPrimeSettings.AddListener

procedure TnsPrimeSettings.RemoveListener(const aListener: InsUserSettingsListener);
//#UC START# *4914449202EA_4C99AEBC01B3_var*
//#UC END# *4914449202EA_4C99AEBC01B3_var*
begin
//#UC START# *4914449202EA_4C99AEBC01B3_impl*
// Do nothing
//#UC END# *4914449202EA_4C99AEBC01B3_impl*
end;//TnsPrimeSettings.RemoveListener

procedure TnsPrimeSettings.StartEdit;
//#UC START# *491444D00360_4C99AEBC01B3_var*
//#UC END# *491444D00360_4C99AEBC01B3_var*
begin
//#UC START# *491444D00360_4C99AEBC01B3_impl*
// Do nothing
//#UC END# *491444D00360_4C99AEBC01B3_impl*
end;//TnsPrimeSettings.StartEdit

procedure TnsPrimeSettings.UserSettingsChanged;
//#UC START# *491444E70109_4C99AEBC01B3_var*
//#UC END# *491444E70109_4C99AEBC01B3_var*
begin
//#UC START# *491444E70109_4C99AEBC01B3_impl*
// Do nothing
//#UC END# *491444E70109_4C99AEBC01B3_impl*
end;//TnsPrimeSettings.UserSettingsChanged

procedure TnsPrimeSettings.StartReplace;
//#UC START# *491444FB0228_4C99AEBC01B3_var*
//#UC END# *491444FB0228_4C99AEBC01B3_var*
begin
//#UC START# *491444FB0228_4C99AEBC01B3_impl*
// Do nothing
//#UC END# *491444FB0228_4C99AEBC01B3_impl*
end;//TnsPrimeSettings.StartReplace

procedure TnsPrimeSettings.FinishReplace;
//#UC START# *4914450A01D2_4C99AEBC01B3_var*
//#UC END# *4914450A01D2_4C99AEBC01B3_var*
begin
//#UC START# *4914450A01D2_4C99AEBC01B3_impl*
// Do nothing
//#UC END# *4914450A01D2_4C99AEBC01B3_impl*
end;//TnsPrimeSettings.FinishReplace

function TnsPrimeSettings.pm_GetSettingsNotify: InsSettingsNotify;
//#UC START# *4914451B03BB_4C99AEBC01B3get_var*
//#UC END# *4914451B03BB_4C99AEBC01B3get_var*
begin
//#UC START# *4914451B03BB_4C99AEBC01B3get_impl*
 Result := Self;
//#UC END# *4914451B03BB_4C99AEBC01B3get_impl*
end;//TnsPrimeSettings.pm_GetSettingsNotify

function TnsPrimeSettings.pm_GetData: ISettingsManager;
//#UC START# *49144567028A_4C99AEBC01B3get_var*
//#UC END# *49144567028A_4C99AEBC01B3get_var*
begin
//#UC START# *49144567028A_4C99AEBC01B3get_impl*
 Assert(False);
 Result := nil;
//#UC END# *49144567028A_4C99AEBC01B3get_impl*
end;//TnsPrimeSettings.pm_GetData

procedure TnsPrimeSettings.pm_SetData(const aValue: ISettingsManager);
//#UC START# *49144567028A_4C99AEBC01B3set_var*
//#UC END# *49144567028A_4C99AEBC01B3set_var*
begin
//#UC START# *49144567028A_4C99AEBC01B3set_impl*
 Assert(False);
//#UC END# *49144567028A_4C99AEBC01B3set_impl*
end;//TnsPrimeSettings.pm_SetData

function TnsPrimeSettings.LoadDouble(const aSettingId: TafwSettingId;
  aDefault: Double = 0;
  aRestoreDefault: Boolean = False): Double;
//#UC START# *4AB729980069_4C99AEBC01B3_var*
//#UC END# *4AB729980069_4C99AEBC01B3_var*
begin
//#UC START# *4AB729980069_4C99AEBC01B3_impl*
 LoadParam(aSettingId, vtExtended, Result, aDefault, aRestoreDefault);
//#UC END# *4AB729980069_4C99AEBC01B3_impl*
end;//TnsPrimeSettings.LoadDouble

procedure TnsPrimeSettings.SaveDouble(const aSettingId: TafwSettingId;
  aValue: Double;
  aDefault: Double = 0;
  aSetAsDefault: Boolean = False);
//#UC START# *4AB729A702A2_4C99AEBC01B3_var*
//#UC END# *4AB729A702A2_4C99AEBC01B3_var*
begin
//#UC START# *4AB729A702A2_4C99AEBC01B3_impl*
 SaveParam(aSettingId, vtExtended, aValue, aDefault, aSetAsDefault);
//#UC END# *4AB729A702A2_4C99AEBC01B3_impl*
end;//TnsPrimeSettings.SaveDouble

{$IfEnd} //nsWithoutLogin

end.