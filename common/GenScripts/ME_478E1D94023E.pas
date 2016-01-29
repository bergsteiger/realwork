unit l3TypedIntegerValueMap;

interface

uses
 l3IntfUses
 , l3ValueMap
 , l3Interfaces
 , TypInfo
;

type
 Tl3IntegerValueMap = class(Tl3ValueMap, Il3IntegerValueMap)
  procedure Create(const aID: Tl3ValueMapID;
   aTypeInfo: PTypeInfo);
  function DoDisplayNameToValue(const aDisplayName: Il3CString): Integer;
  function DoValueToDisplayName(aValue: Integer): Il3CString;
  function DisplayNameToValue(const aDisplayName: Il3CString): Integer;
  function ValueToDisplayName(aValue: Integer): Il3CString;
 end;//Tl3IntegerValueMap
 
 Tl3SimpleTypedIntegerValueMap = class(Tl3IntegerValueMap)
  procedure Create(const aID: Tl3ValueMapID;
   aTypeInfo: PTypeInfo;
   const aValues: array of AnsiString);
  function Make(const aID: Tl3ValueMapID;
   aTypeInfo: PTypeInfo;
   const aValues: array of AnsiString): Il3IntegerValueMap;
  function DoDisplayNameToValue(const aDisplayName: Il3CString): Integer;
  function DoValueToDisplayName(aValue: Integer): Il3CString;
 end;//Tl3SimpleTypedIntegerValueMap
 
 Tl3ResStringArray = array of PResStringRec;
 
 Tl3ResourceTypedIntegerValueMap = class(Tl3IntegerValueMap)
  procedure Create(const aID: Tl3ValueMapID;
   aTypeInfo: PTypeInfo;
   const aValues: array of PResStringRec);
  function Make(const aID: Tl3ValueMapID;
   aTypeInfo: PTypeInfo;
   const aValues: array of PResStringRec): Il3IntegerValueMap;
  function DoDisplayNameToValue(const aDisplayName: Il3CString): Integer;
  function DoValueToDisplayName(aValue: Integer): Il3CString;
 end;//Tl3ResourceTypedIntegerValueMap
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3String
 , l3Base
;

end.
