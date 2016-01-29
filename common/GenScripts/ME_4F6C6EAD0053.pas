unit afwSettingsImplPrimPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , afwInterfaces
 , l3Interfaces
;

type
 IafwSettingsImpl = interface
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
 end;//IafwSettingsImpl
 
 TafwKeyValue = object
 end;//TafwKeyValue
 
 TafwSettingsImplPrimPrim = class(Tl3ProtoDataContainer)
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TafwSettingsImplPrimPrim
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
