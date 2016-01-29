unit afwSettings;

interface

uses
 l3IntfUses
 , afwSettingsPrimPrim
 , afwInterfaces
 , afwSettingsImplPrimPrim
;

type
 TafwSettings = class(TafwSettingsPrimPrim, IafwSettings)
  function Make(const aSettingsImpl: IafwSettingsImpl): IafwSettings;
  function State: TafwSettingsState;
   {* - состояние компонента. }
  function LoadDouble(const aSettingId: TafwSettingId;
   aDefault: Double;
   aRestoreDefault: Boolean): Double;
  procedure SaveDouble(const aSettingId: TafwSettingId;
   aValue: Double;
   aDefault: Double;
   aSetAsDefault: Boolean);
 end;//TafwSettings
 
implementation

uses
 l3ImplUses
 , SysUtils
 , afwSettingsChangePublisher
;

end.
