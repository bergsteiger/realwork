unit nsUserListFilterTypesMap;

{$Include nsDefine.inc }

interface

uses
  Classes,

  l3Interfaces,
  l3BaseWithID,
  l3ValueMap,
  l3Types,

  afwInterfaces,

  vcmInterfaces,
  vcmExternalInterfaces,

  L10nInterfaces
  ;

type
 _afwApplicationDataUpdate_Parent_ = Tl3ValueMap;
 {$Include afwApplicationDataUpdate.imp.pas}
 TnsUserListFilterTypesMap = class(_afwApplicationDataUpdate_,
                                   InsIntegerValueMap,
                                   InsStringsSource)
 protected
   procedure FinishDataUpdate;
     override;
     {* вызывает по окончании обновления }
 protected
  // Il3IntegerValueMap
  function DisplayNameToValue(const aDisplayName: Il3CString): Integer;
  function ValueToDisplayName(aValue: Integer): Il3CString;
  // InsStringsSource
  procedure FillStrings(const aStrings: IvcmStrings);
 private
  f_AllowPermanent: Boolean;
 protected
  procedure DoGetDisplayNames(const aList: Il3StringsEx);
   override;
  function GetMapSize: Integer;
   override;
 public
  constructor Create;
   reintroduce;
  class function Make: InsIntegerValueMap;
   reintroduce;
 end;//TnsUserListFilterTypesMap

implementation

uses
  l3String,

  afwFacade,

  vcmBase,

  nsTypes,
  nsValueMapsIDs,

  StdRes,
  DataAdapter,

  AdminInterfaces
  ;

{$Include afwApplicationDataUpdate.imp.pas}

Const
 map_UserListFilterTypes: array [TUserListFilterTypes] of PvcmStringID = (
  @str_culfAllUsers1, // ulftNone,
  @str_culfActiveUsers1, // ulftActive,
  @str_culfRegularUsers, // ulftUsual,
  @str_culfSystemUsers, // ulftSystem,
  @str_culfConsultingEnabled, // ulftConsultingEnabled,
  @str_culfConsultingDisabled, // ulftConsultingDisabled
  @str_culfPrivileged, // ulftPrivileged,
  @str_culfNonPrivileged, // ulftNonPrivileged
  @str_culfWithoutGroup // ulftWithoutGroup
 );

 c_AlwaysAccessible = [ulftNone, ulftActive, ulftUsual, ulftSystem,
  ulftConsultingEnabled, ulftConsultingDisabled, ulftWithoutGroup];

{ TnsUserListFilterTypesMap }

constructor TnsUserListFilterTypesMap.Create;
begin
 inherited Create(imap_UserListFilterTypes);
 f_AllowPermanent := defDataAdapter.PrivelegedUsersAllowed;
end;

function TnsUserListFilterTypesMap.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
  {-}
var
 l_Index: TUserListFilterTypes;
begin
 for l_Index := Low(TUserListFilterTypes) to High(TUserListFilterTypes) do
  if ((l_Index in c_AlwaysAccessible) or f_AllowPermanent) and
     l3Same(aDisplayName, vcmCStr(map_UserListFilterTypes[l_Index]^)) then
  begin
   Result := Ord(l_Index);
   exit;
  end;//l_Index in f_ValidSortTypes
 raise El3ValueMapValueNotFound.CreateFmt('Display name %s not found in Map %d', [nsEStr(aDisplayName),rMapID.rID]);
end;

procedure TnsUserListFilterTypesMap.FillStrings(const aStrings: IvcmStrings);
var
 l_Index: TUserListFilterTypes;
begin
 aStrings.Clear;
 for l_Index := Low(TUserListFilterTypes) To High(TUserListFilterTypes) Do
  if ((l_Index in c_AlwaysAccessible) or f_AllowPermanent) then
   aStrings.Add(vcmCStr(map_UserListFilterTypes[l_Index]^));
end;

procedure TnsUserListFilterTypesMap.FinishDataUpdate;
begin
 inherited;
 f_AllowPermanent := f_AllowPermanent or defDataAdapter.PrivelegedUsersAllowed;
end;

procedure TnsUserListFilterTypesMap.DoGetDisplayNames(const aList: Il3StringsEx);
var
 l_Index: TUserListFilterTypes;
begin
 inherited;
 for l_Index := Low(TUserListFilterTypes) To High(TUserListFilterTypes) Do
  if ((l_Index in c_AlwaysAccessible) or f_AllowPermanent) then
   aList.Add(vcmCStr(map_UserListFilterTypes[l_Index]^));
end;

class function TnsUserListFilterTypesMap.Make: InsIntegerValueMap;
var
 l_Map: TnsUserListFilterTypesMap;
begin
 l_Map := Create;
 try
  Result := l_Map;
 finally
  vcmFree(l_Map);
 end;
end;

function TnsUserListFilterTypesMap.GetMapSize: Integer;
var
 l_Index: TUserListFilterTypes;
begin
 Result := 0;
 for l_Index := Low(TUserListFilterTypes) To High(TUserListFilterTypes) Do
//  if l_Index in f_ValidSortTypes then
   Inc(Result);
end;

function TnsUserListFilterTypesMap.ValueToDisplayName(aValue: Integer): Il3CString;
begin
 if (aValue<ord(Low(TUserListFilterTypes))) or (aValue>ord(High(TUserListFilterTypes))) or
  (not ((TUserListFilterTypes(aValue) in c_AlwaysAccessible) or f_AllowPermanent)) then
  raise El3ValueMapValueNotFound.CreateFmt('Value %d not found in Map %s',[aValue,rMapID.rName]);
 Result := vcmCStr(map_UserListFilterTypes[TUserListFilterTypes(aValue)]^);
end;

end.

