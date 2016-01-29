unit afwSettingsPrim.imp;

interface

uses
 l3IntfUses
 , l3Interfaces
 , afwInterfaces
;

type
 _afwSettingsPrim_ = class(_nsAbstractSettingsPrim_)
  function IStringTypeToIl3CString(const aStr: _IStringType_): Il3CString;
  function SettingIDtoKeyType(const aSettingID: TafwSettingId): _KeyType_;
  function Il3CStringToAString(const aStr: Il3CString): Il3AString;
  function StringToPChar(const aString: AnsiString): PAnsiChar;
 end;//_afwSettingsPrim_
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , afwAString
 , SysUtils
 , l3VCLStrings
;

end.
