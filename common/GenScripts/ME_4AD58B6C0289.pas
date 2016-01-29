unit nsAbstractSettingsPrim.imp;

interface

uses
 l3IntfUses
 , afwInterfaces
 , l3Interfaces
;

type
 _nsAbstractSettingsPrim_ = class(Ml3Unknown)
  procedure Create(const aSettings: _SettingsClass_);
  procedure NotifySettingChanged(const aSettingID: TafwSettingId);
  function TryToRestore(const aSettingID: TafwSettingId): Boolean;
  procedure DoSaveParam(const aTarget: _SettingsClass_;
   const aSettingId: TafwSettingId;
   aType: byte;
   aValue;
   aDefault;
   aSetAsDefault: Boolean);
  procedure DoSetAsDefault(const aTarget: _SettingsClass_;
   const aSettingId: TafwSettingId);
  function IStringTypeToIl3CString(const aStr: _IStringType_): Il3CString;
  function SettingIDtoKeyType(const aSettingID: TafwSettingId): _KeyType_;
  function Il3CStringToAString(const aStr: Il3CString): Il3AString;
  function StringToPChar(const aString: AnsiString): PAnsiChar;
  function LoadInteger(const aSettingId: TafwSettingId;
   aDefault: Integer;
   aRestoreDefault: Boolean): Integer;
  function LoadParam(const aSettingId: TafwSettingId;
   aType: byte;
   out aValue;
   aDefault;
   aRestoreDefault: Boolean): Boolean;
  function LoadString(const aSettingId: TafwSettingId;
   const aDefault: AnsiString;
   aRestoreDefault: Boolean): IafwCString;
  procedure SaveBoolean(const aSettingId: TafwSettingId;
   aValue: Boolean;
   aDefault: Boolean;
   aSetAsDefault: Boolean);
  procedure SaveInteger(const aSettingId: TafwSettingId;
   aValue: Integer;
   aDefault: Integer;
   aSetAsDefault: Boolean);
   {* aValue - текущее значение, aDefault - значение по умолчанию, устанавливается для восстанвления настроек. }
  procedure SaveParam(const aSettingId: TafwSettingId;
   aType: byte;
   aValue;
   aDefault;
   aSetAsDefault: Boolean);
  procedure SaveString(const aSettingId: TafwSettingId;
   const aValue: IafwCString;
   const aDefault: AnsiString;
   aSetAsDefault: Boolean);
  function LoadBoolean(const aSettingId: TafwSettingId;
   aDefault: Boolean;
   aRestoreDefault: Boolean): Boolean;
  function LoadStrings(const aSettingId: TafwSettingId;
   aRestoreDefault: Boolean): IafwStrings;
  procedure SaveStrings(const aSettingId: TafwSettingId;
   const aValue: IafwStrings;
   aSetAsDefault: Boolean);
 end;//_nsAbstractSettingsPrim_
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3String
 , l3VCLStrings
 , l3Base
;

end.
