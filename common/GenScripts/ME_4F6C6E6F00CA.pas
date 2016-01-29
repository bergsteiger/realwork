unit afwSettingsPrimPrim;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , afwInterfaces
 , afwSettingsImplPrimPrim
;

type
 TafwSettingsPrimPrim = class(Tl3ProtoObject, IafwSettingsPrim)
  procedure Create(const aSettingsImpl: IafwSettingsImpl);
  function Make(const aSettingsImpl: IafwSettingsImpl): IafwSettingsPrim;
 end;//TafwSettingsPrimPrim
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , afwAString
 , SysUtils
 , l3Interfaces
 , l3VCLStrings
;

end.
