unit afwSettingsImpl;

interface

uses
 l3IntfUses
 , afwSettingsImplPrim
 , afwSettingsImplPrimPrim
 , afwInterfaces
 , l3Interfaces
 , l3Types
;

type
 TafwSettingsImpl = class(_l3Searcher_, IafwSettingsImpl)
  function GetString(const aSettingId: TafwSettingId;
   out theValue: Il3CString): Boolean;
  function GetLong(const aSettingId: TafwSettingId;
   out theValue: Integer): Boolean;
  function GetBool(const aSettingId: TafwSettingId;
   out theValue: Boolean): Boolean;
  procedure SetString(const aSettingId: TafwSettingId;
   aValue: PAnsiChar);
  procedure SetLong(const aSettingId: TafwSettingId;
   aValue: Integer);
  procedure SetBool(const aSettingId: TafwSettingId;
   aValue: Boolean);
 end;//TafwSettingsImpl
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , SysUtils
;

end.
