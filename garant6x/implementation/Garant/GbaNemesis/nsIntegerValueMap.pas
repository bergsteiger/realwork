unit nsIntegerValueMap;
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
 TnsIntegerValueMapRecord = record
  rN: TvcmStringID;
  rV: Integer;
 end;//TnsIntegerValueMapRecord

 TnsIntegerValueMapItem = class(Tl3BaseWithID)
 private
  f_Data: TnsIntegerValueMapRecord;
 public
  constructor Create(const aValue: TnsIntegerValueMapRecord);
   reintroduce;
  property StringID: TvcmStringID
   read f_Data.rN;
  property Value: Integer
   read f_Data.rV;
 end;//TnsIntegerValueMapItem

 TnsIntegerValueMap = class(Tl3ValueMap, InsIntegerValueMap, InsStringsSource)
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
  constructor Create(const aID: TnsValueMapID; const aValues: array of TnsIntegerValueMapRecord);
   reintroduce;
  class function Make(const aID: TnsValueMapID; const aValues: array of TnsIntegerValueMapRecord): InsIntegerValueMap;
   reintroduce;
 end;//TnsIntegerValueMap

function nsIntegerValueMapRecord(const aName: TvcmStringID; aValue: Integer): TnsIntegerValueMapRecord;

implementation

uses
  l3Base,
  l3String,

  vcmBase,
  vcmUtils,

  nsTypes
  ;

function nsIntegerValueMapRecord(const aName: TvcmStringID; aValue: Integer): TnsIntegerValueMapRecord;
begin
 Result.rN := aName;
 Result.rV := aValue;
end;

{ TnsIntegerValueMapItem }

constructor TnsIntegerValueMapItem.Create(const aValue: TnsIntegerValueMapRecord);
begin
 inherited Create(aValue.rV);
 f_Data := aValue;
end;

{ TnsIntegerValueMap }

constructor TnsIntegerValueMap.Create(const aID: TnsValueMapID;
  const aValues: array of TnsIntegerValueMapRecord);
var
 l_Index: Integer;
 l_Item: TnsIntegerValueMapItem;
begin
 inherited Create(aID);
 for l_index := Low(aValues) to High(aValues) do
 begin
  l_Item := TnsIntegerValueMapItem.Create(aValues[l_Index]);
  try
   Add(l_Item);
  finally
   l3Free(l_Item);
  end;
 end;
end;

function TnsIntegerValueMap.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
  {-}
var
 l_Index : Integer;
begin
 for l_Index := 0 to Count - 1 do
  if l3Same(aDisplayName, vcmCStr(TnsIntegerValueMapItem(Items[l_Index]).StringID))  then
  begin
   Result := TnsIntegerValueMapItem(Items[l_Index]).Value;
   exit;
  end;//l3Same(aDisplayName, 
 raise El3ValueMapValueNotFound.CreateFmt('Display name %s not found in Map %s', [nsEStr(aDisplayName),rMapID.rName]);
end;

procedure TnsIntegerValueMap.FillStrings(const aStrings: IvcmStrings);
var
 l_Index: Integer;
begin
 aStrings.Clear;
 for l_Index := 0 To Count-1 Do
  aStrings.Add(vcmCStr(TnsIntegerValueMapItem(Items[l_Index]).StringID));
end;

procedure TnsIntegerValueMap.DoGetDisplayNames(const aList: Il3StringsEx);
var
 l_Index: Integer;
begin
 inherited;
 for l_Index := 0 To Count-1 Do
  aList.Add(vcmCStr(TnsIntegerValueMapItem(Items[l_Index]).StringID));
end;

class function TnsIntegerValueMap.Make(const aID: TnsValueMapID;
  const aValues: array of TnsIntegerValueMapRecord): InsIntegerValueMap;
var
 l_Map: TnsIntegerValueMap;
begin
 l_Map := Create(aID, aValues);
 try
  Result := l_Map;
 finally
  vcmFree(l_Map);
 end;
end;

function TnsIntegerValueMap.GetMapSize: Integer;
begin
 Result := Count;
end;

function TnsIntegerValueMap.ValueToDisplayName(aValue: Integer): Il3CString;
var
 l_Index: Integer;
begin
 if FindData(aValue,l_Index,l3_siNative) then
  Result := vcmCStr(TnsIntegerValueMapItem(Items[l_Index]).StringID)
 else
  raise El3ValueMapValueNotFound.CreateFmt('Value %d not found in Map %s',[aValue,rMapID.rName]);
end;

end.

