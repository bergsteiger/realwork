unit nsStringValueMap;
{* реализация мапы "строка"-"строка" }

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
 TnsStringValueMapRecord = record
  rN: TvcmStringID;
  rV: Il3CString;
 end;//TnsStringValueMapRecord

 TnsStringValueMapItem = class(Tl3BaseWithID)
 private
  f_Data: TnsStringValueMapRecord;
 protected
 // internal methods
   procedure Cleanup;
     override;
     {-}
 public
  constructor Create(const aValue: TnsStringValueMapRecord);
   reintroduce;
  property StringID: TvcmStringID
   read f_Data.rN;
  property Value: Il3CString
   read f_Data.rV;
 end;//TnsStringValueMapItem

 _Instance_R_ = Tl3ValueMap;
 _FindDataType_ = Tl3WString;
 _l3Searcher_Parent_ = Tl3ValueMap;
 {$Include l3Searcher.imp.pas}
 TnsStringValueMap = class(_l3Searcher_, InsStringValueMap, InsStringsSource)
 private
  // Il3IntegerValueMap
  function DisplayNameToValue(const aDisplayName: Il3CString): Il3CString;
  function ValueToDisplayName(const aValue: Il3CString): Il3CString;
  // InsStringsSource
  procedure FillStrings(const aStrings: IvcmStrings);
 protected
  procedure DoGetDisplayNames(const aList: Il3StringsEx);
   override;
  function GetMapSize: Integer;
   override;
 public
  constructor Create(aID: TnsValueMapID; const aValues: array of TnsStringValueMapRecord);
   reintroduce;
  class function Make(aID: TnsValueMapID; const aValues: array of TnsStringValueMapRecord): InsStringValueMap;
   reintroduce;
 end;//TnsStringValueMap

function nsStringValueMapRecord(const aName: TvcmStringID; const aValue: String): TnsStringValueMapRecord;

implementation

uses
  l3Base,
  l3String,

  vcmBase,
  vcmUtils,

  nsTypes
  ;

type _ItemType_ = Tl3BaseWithID;

function CompareItemWithData(const anItem: _ItemType_;
  const aData: _FindDataType_;
  aSortIndex: Tl3SortIndex;
  aList: _l3Searcher_): Integer;
begin
 Assert((aSortIndex = l3_siNative) OR (aSortIndex = l3_siCaseUnsensitive));
 Result := l3Compare(l3PCharLen((anItem As TnsStringValueMapItem).Value), aData, aSortIndex);
end;

type _l3Searcher_R_ = TnsStringValueMap;

{$Include l3Searcher.imp.pas}

function nsStringValueMapRecord(const aName: TvcmStringID; const aValue: String): TnsStringValueMapRecord;
begin
 Result.rN := aName;
 Result.rV := nsCStr(aValue);
end;

{ TnsStringValueMapItem }

constructor TnsStringValueMapItem.Create(const aValue: TnsStringValueMapRecord);
begin
 inherited Create(aValue.rN.rS);
 f_Data := aValue;
end;

procedure TnsStringValueMapItem.Cleanup;
  //override;
  {-}
begin
 Finalize(f_Data);
 inherited;
end;

{ TnsStringValueMap }

constructor TnsStringValueMap.Create(aID: TnsValueMapID;
  const aValues: array of TnsStringValueMapRecord);
var
 l_Index: Integer;
 l_Item: TnsStringValueMapItem;
begin
 inherited Create(aID);
 for l_index := Low(aValues) to High(aValues) do
 begin
  l_Item := TnsStringValueMapItem.Create(aValues[l_Index]);
  try
   Add(l_Item);
  finally
   l3Free(l_Item);
  end;
 end;
end;

function TnsStringValueMap.DisplayNameToValue(const aDisplayName: Il3CString): Il3CString;
var
 l_Index: Integer;
begin
 for l_Index := 0 to Count - 1 do
  if l3Same(aDisplayName, vcmCStr(TnsStringValueMapItem(Items[l_Index]).StringID))  then
  begin
   Result := TnsStringValueMapItem(Items[l_Index]).Value;
   exit;
  end;//l3Same(aDisplayName,  
 raise El3ValueMapValueNotFound.CreateFmt('Display name "%s" not found in Map %s', [nsEStr(aDisplayName), rMapID.rName]);
end;

procedure TnsStringValueMap.FillStrings(const aStrings: IvcmStrings);
var
 l_Index: Integer;
begin
 aStrings.Clear;
 for l_Index := 0 To Count-1 Do
  aStrings.Add(vcmCStr(TnsStringValueMapItem(Items[l_Index]).StringID));
end;

procedure TnsStringValueMap.DoGetDisplayNames(const aList: Il3StringsEx);
var
 l_Index: Integer;
begin
 inherited;
 for l_Index := 0 To Count-1 Do
  aList.Add(vcmCStr(TnsStringValueMapItem(Items[l_Index]).StringID));
end;

class function TnsStringValueMap.Make(aID: TnsValueMapID;
  const aValues: array of TnsStringValueMapRecord): InsStringValueMap;
var
 l_Map: TnsStringValueMap;
begin
 l_Map := Create(aID, aValues);
 try
  Result := l_Map;
 finally
  vcmFree(l_Map);
 end;
end;

function TnsStringValueMap.GetMapSize: Integer;
begin
 Result := Count;
end;

function TnsStringValueMap.ValueToDisplayName(const aValue: Il3CString): Il3CString;
var
 l_Index: Integer;
begin
 if FindData(nsWStr(aValue),l_Index,l3_siNative) then
  Result := vcmCStr(TnsStringValueMapItem(Items[l_Index]).StringID)
 else
  raise El3ValueMapValueNotFound.CreateFmt('Value "%s" not found in Map %s', [nsEStr(aValue), rMapID.rName]);
end;

end.

