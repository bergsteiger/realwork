unit tfwValueTypes;

interface

uses
 l3IntfUses
 , tfwTypeInfoList
 , l3Interfaces
 , tfwTypeInfo
 , TypInfo
;

type
 TtfwValueTypesAccepts = (
  tfw_vtaNo
  , tfw_vtaYes
  , tfw_vtaMaybe
 );//TtfwValueTypesAccepts
 
 TtfwValueTypes = class(TtfwTypeInfoList)
  function Has(const aType: TtfwTypeInfo): Boolean; overload;
  procedure Create(anOther: TtfwTypeInfoList;
   const aType: TtfwTypeInfo;
   const aCustomName: Il3CString);
  function Add(const aType: TtfwTypeInfo): TtfwValueTypes; overload;
  function Make(const aType: TtfwTypeInfo): TtfwValueTypes; overload;
  function Name: Il3CString;
  function AcceptsValue(const aValue: TtfwStackValue): Boolean;
  function Add(anOther: TtfwValueTypes): TtfwValueTypes; overload;
  function Make(aType: PTypeInfo): TtfwValueTypes; overload;
  function Has(aType: TtfwValueType): Boolean; overload;
  function EQ(anOther: TtfwValueTypes): Boolean; overload;
  function DefaultValue: TtfwStackValue;
  function EQ(aType: PTypeInfo): Boolean; overload;
  function Compare(const anOther: TtfwTypeInfo): Integer; overload;
  function MakeCustomName(const aName: Il3CString): TtfwValueTypes;
  function Accepts(anOther: TtfwValueTypes): TtfwValueTypesAccepts;
  function Compare(anOther: TtfwValueTypes): Integer; overload;
  function AcceptableBy(const aType: TtfwTypeInfo): TtfwValueTypesAccepts;
 end;//TtfwValueTypes
 
implementation

uses
 l3ImplUses
 , tfwValueTypesCache
 , tfwScriptingInterfaces
 , tfwScriptingTypes
 , tfwValueTypesWordsPack
 , SysUtils
 , l3String
 , tfwCStringFactory
;

end.
