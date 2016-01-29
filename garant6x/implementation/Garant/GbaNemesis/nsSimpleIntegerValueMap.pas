unit nsSimpleIntegerValueMap;
{* реализация мапы "строка"-"число" }

{$Include nsDefine.inc }

interface

uses
  Classes,

  l3Interfaces,
  l3BaseWithID,
  l3ValueMap,
  l3Types,

  vcmExternalInterfaces,
  vcmInterfaces,

  L10nInterfaces
  ;

type
 TnsSimpleIntegerValueMapRecord = record
  rN: Il3CString;
  rV: Integer;
 end;//TnsIntegerValueMapRecord

 TnsSimpleIntegerValueMapItem = class(Tl3BaseWithID)
 private
  f_Data: TnsSimpleIntegerValueMapRecord;
 public
  constructor Create(const aValue: TnsSimpleIntegerValueMapRecord);
   reintroduce;
  property StringData: Il3CString
   read f_Data.rN;
  property Value: Integer
   read f_Data.rV;
 end;//TnsIntegerValueMapItem

 TnsSimpleIntegerValueMap = class(Tl3ValueMap, InsIntegerValueMap, InsStringsSource)
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
  constructor Create(const aID: TnsValueMapID; const aValues: array of TnsSimpleIntegerValueMapRecord);
   reintroduce;
  class function Make(const aID: TnsValueMapID; const aValues: array of TnsSimpleIntegerValueMapRecord): InsIntegerValueMap;
   reintroduce;
 end;//TnsIntegerValueMap

function nsSimpleIntegerValueMapRecord(const aName: Il3CString; aValue: Integer): TnsSimpleIntegerValueMapRecord;

implementation

uses
  l3Base,
  l3String,

  vcmBase,
  vcmUtils,

  nsTypes
  ;

function nsSimpleIntegerValueMapRecord(const aName: Il3CString; aValue: Integer): TnsSimpleIntegerValueMapRecord;
begin
 Result.rN := aName;
 Result.rV := aValue;
end;

{ TnsSimpleIntegerValueMapItem }

constructor TnsSimpleIntegerValueMapItem.Create(const aValue: TnsSimpleIntegerValueMapRecord);
begin
 inherited Create(aValue.rV);
 f_Data := aValue;
end;

{ TnsSimpleIntegerValueMap }

constructor TnsSimpleIntegerValueMap.Create(const aID: TnsValueMapID;
  const aValues: array of TnsSimpleIntegerValueMapRecord);
var
 l_Index: Integer;
 l_Item: TnsSimpleIntegerValueMapItem;
begin
 inherited Create(aID);
 for l_index := Low(aValues) to High(aValues) do
 begin
  l_Item := TnsSimpleIntegerValueMapItem.Create(aValues[l_Index]);
  try
   Add(l_Item);
  finally
   l3Free(l_Item);
  end;
 end;
end;

function TnsSimpleIntegerValueMap.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
  {-}
var
 l_Index : Integer;
begin
 for l_Index := 0 to Count - 1 do
  if l3Same(aDisplayName, TnsSimpleIntegerValueMapItem(Items[l_Index]).StringData)  then
  begin
   Result := TnsSimpleIntegerValueMapItem(Items[l_Index]).Value;
   exit;
  end;//l3Same(aDisplayName,
 raise El3ValueMapValueNotFound.CreateFmt('Display name %s not found in Map %s', [nsEStr(aDisplayName),rMapID.rName]);
end;

procedure TnsSimpleIntegerValueMap.FillStrings(const aStrings: IvcmStrings);
var
 l_Index: Integer;
begin
 aStrings.Clear;
 for l_Index := 0 To Count-1 Do
  aStrings.Add(TnsSimpleIntegerValueMapItem(Items[l_Index]).StringData);
end;

procedure TnsSimpleIntegerValueMap.DoGetDisplayNames(const aList: Il3StringsEx);
var
 l_Index: Integer;
begin
 inherited;
 for l_Index := 0 To Count-1 Do
  aList.Add(TnsSimpleIntegerValueMapItem(Items[l_Index]).StringData);
end;

class function TnsSimpleIntegerValueMap.Make(const aID: TnsValueMapID;
  const aValues: array of TnsSimpleIntegerValueMapRecord): InsIntegerValueMap;
var
 l_Map: TnsSimpleIntegerValueMap;
begin
 l_Map := Create(aID, aValues);
 try
  Result := l_Map;
 finally
  vcmFree(l_Map);
 end;
end;

function TnsSimpleIntegerValueMap.GetMapSize: Integer;
begin
 Result := Count;
end;

function TnsSimpleIntegerValueMap.ValueToDisplayName(aValue: Integer): Il3CString;
var
 l_Index: Integer;
begin
 if FindData(aValue,l_Index,l3_siNative) then
  Result := TnsSimpleIntegerValueMapItem(Items[l_Index]).StringData
 else
  raise El3ValueMapValueNotFound.CreateFmt('Value %d not found in Map %s',[aValue,rMapID.rName]);
end;

end.

