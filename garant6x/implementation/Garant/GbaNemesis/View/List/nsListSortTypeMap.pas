unit nsListSortTypeMap;
{* реализация мапы "внутри системная строка языка"-"число - ID языка на адаптере"}

{$Include nsDefine.inc }

interface

uses
  Classes,

  l3Interfaces,
  l3BaseWithID,
  l3ValueMap,
  l3Types,

  bsTypes,
  BaseTypesUnit,

  vcmExternalInterfaces,
  vcmInterfaces,

  L10nInterfaces
  ;

const cDefaultListSortTypes = [ST_PRIORITY, ST_CREATE_DATE, ST_LAST_EDIT_DATE];

type
 TnsListSortTypeMap = class(Tl3ValueMap, InsIntegerValueMap, InsStringsSource)
 private
  f_ValidSortTypes: TbsValidSortTypes;
 private
  // Il3IntegerValueMap
  function DisplayNameToValue(const aDisplayName: Il3CString): Integer;
  function ValueToDisplayName(aValue: Integer): Il3CString;
  // InsStringsSource
  procedure FillStrings(const aStrings: IvcmStrings);
 protected
  procedure DoGetDisplayNames(const aList: Il3StringsEx);
   override;
  function GetMapSize: Integer;
   override;
 public
  constructor Create(aValidValues: TbsValidSortTypes = cDefaultListSortTypes);
   reintroduce;
  class function Make(aValidValues: TbsValidSortTypes = cDefaultListSortTypes): InsIntegerValueMap;
   reintroduce;
 end;//TnsListSortTypeMap

implementation

uses
  l3String,

  vcmBase,

  nsTypes,
  nsValueMapsIDs,

  StdRes
  ;

Const
 c_ListSortTypeMap: array [TbsSortType] of PvcmStringID = (
	@str_list_sort_type_JurPower, //	ST_PRIORITY
  @str_list_sort_type_PublishDate, // ST_CREATE_DATE
  @str_list_sort_type_ChangeDate, // ST_LAST_EDIT_DATE
  @str_list_sort_type_NotSorted, // ST_NOT_SORTED
  @str_list_sort_type_Relevance // ST_RELEVANCE
 );


{ TnsListSortTypeMap }

constructor TnsListSortTypeMap.Create(aValidValues: TbsValidSortTypes);
begin
 inherited Create(imap_pi_List_SortType);
 f_ValidSortTypes := aValidValues;
end;

function TnsListSortTypeMap.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
  {-}
var
 l_Index: TbsSortType;
begin
 for l_Index := Low(TbsSortType) to High(TbsSortType) do
  if (l_Index in f_ValidSortTypes) and
     l3Same(aDisplayName, vcmCStr(c_ListSortTypeMap[l_Index]^)) then
  begin
   Result := Ord(l_Index);
   exit;
  end;//l_Index in f_ValidSortTypes
 if f_ValidSortTypes = [] then
  Result := Ord(ST_NOT_SORTED);
 raise El3ValueMapValueNotFound.CreateFmt('Display name %s not found in Map %d', [nsEStr(aDisplayName),rMapID.rID]);
end;

procedure TnsListSortTypeMap.FillStrings(const aStrings: IvcmStrings);
var
 l_Index: TbsSortType;
begin
 aStrings.Clear;
 for l_Index := Low(TbsSortType) To High(TbsSortType) Do
  if l_Index in f_ValidSortTypes then
   aStrings.Add(vcmCStr(c_ListSortTypeMap[l_Index]^));
end;

procedure TnsListSortTypeMap.DoGetDisplayNames(const aList: Il3StringsEx);
var
 l_Index: TbsSortType;
begin
 inherited;
 for l_Index := Low(TbsSortType) To High(TbsSortType) Do
  if l_Index in f_ValidSortTypes then
   aList.Add(vcmCStr(c_ListSortTypeMap[l_Index]^));
end;

class function TnsListSortTypeMap.Make(
  aValidValues: TbsValidSortTypes): InsIntegerValueMap;
var
 l_Map: TnsListSortTypeMap;
begin
 l_Map := Create(aValidValues);
 try
  Result := l_Map;
 finally
  vcmFree(l_Map);
 end;
end;

function TnsListSortTypeMap.GetMapSize: Integer;
var
 l_Index: TbsSortType;
begin
 Result := 0;
 for l_Index := Low(TbsSortType) To High(TbsSortType) Do
  if l_Index in f_ValidSortTypes then
   Inc(Result);
end;

function TnsListSortTypeMap.ValueToDisplayName(aValue: Integer): Il3CString;
begin
 if (f_ValidSortTypes = []) and (aValue = Ord(ST_NOT_SORTED)) then
  Result := nil
 else
 begin
  if (aValue<ord(Low(TbsSortType))) or (aValue>ord(High(TbsSortType))) or
   (not (TbsSortType(aValue) in f_ValidSortTypes)) then
   raise El3ValueMapValueNotFound.CreateFmt('Value %d not found in Map %s',[aValue,rMapID.rName]);
  Result := vcmCStr(c_ListSortTypeMap[TbsSortType(aValue)]^);
 end;
end;

end.

