unit afwSettingsImplemented;

interface

uses
 l3IntfUses
 , afwSettings
 , afwInterfaces
;

type
 TafwSettingsImplemented = class(TafwSettings)
  procedure Create;
  function Make: IafwSettings;
 end;//TafwSettingsImplemented
 
implementation

uses
 l3ImplUses
 , afwSettingsImplSing
;

end.
