unit nsTypedIntegerValueMap;
{* реализаци€ мапы "строка"-"число" дл€ чистой замены array [TSomeType] of _string}

{$Include nsDefine.inc }

interface

// <no_string>

uses
  Classes,
  TypInfo,

  l3Interfaces,
  l3BaseWithID,
  l3ValueMap,
  l3Types,

  vcmExternalInterfaces,
  vcmInterfaces,

  L10nInterfaces
  ;

type
 TnsTypedIntegerValueMap = class(Tl3ValueMap, InsIntegerValueMap, InsStringsSource)
 private
  f_Values: array of PvcmStringID;
  f_TypeData: PTypeData;
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
 protected
  procedure Cleanup;
   override;
 public
  constructor Create(aID: TnsValueMapID; aTypeInfo: PTypeInfo; const aValues: array of PvcmStringID);
   reintroduce;
  class function Make(aID: TnsValueMapID; aTypeInfo: PTypeInfo; const aValues: array of PvcmStringID): InsIntegerValueMap;
   reintroduce;
 end;//TnsTypedIntegerValueMap

implementation

uses
  SysUtils,

  l3Base,
  l3String,

  vcmBase,
  vcmUtils,

  nsTypes
  ;

{ TnsTypedIntegerValueMap }

procedure TnsTypedIntegerValueMap.Cleanup;
begin
 f_Values := nil;
 inherited Cleanup;
end;

constructor TnsTypedIntegerValueMap.Create(aID: TnsValueMapID;
  aTypeInfo: PTypeInfo; const aValues: array of PvcmStringID);
var
 l_Index: Integer;
begin
 inherited Create(aID);
 Assert(Assigned(aTypeInfo),Format('Typed map %s - Unspecified typeinfo',[rMapID.rName]));
 Assert(aTypeInfo^.Kind in [tkInteger, tkChar, tkEnumeration, tkWChar],Format('Typed map %s - Unsupported type',[rMapID.rName]));
 f_TypeData := GetTypeData(aTypeInfo);
 Assert(Assigned(f_TypeData),Format('Typed map %s - Can''t find type data',[rMapID.rName]));
 Assert(Length(aValues)=(f_TypeData.MaxValue-f_TypeData.MinValue+1),Format('Typed map %s - Mismatch map size',[rMapID.rName]));
 SetLength(f_Values, f_TypeData.MaxValue-f_TypeData.MinValue+1);
 for l_Index := Low(aValues) to High(aValues) do
  f_Values[l_Index-Low(aValues)+Low(f_Values)] := aValues[l_Index];
 Assert(Length(aValues)=(f_TypeData.MaxValue-f_TypeData.MinValue+1),Format('Typed map %s - Mismatch map size',[rMapID.rName]));
end;

function TnsTypedIntegerValueMap.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
  {-}
var
 l_Index: Integer;
begin
 for l_Index := Low(f_Values) to High(f_Values) do
  if l3Same(aDisplayName, vcmCStr(f_Values[l_Index]^)) then
  begin
   Result := l_Index + f_TypeData.MinValue - Low(f_Values);
   exit;
  end;//l3Same(aDisplayName, 
 raise El3ValueMapValueNotFound.CreateFmt('Display name %s not found in Map %d', [nsEStr(aDisplayName),rMapID.rID]);
end;

procedure TnsTypedIntegerValueMap.FillStrings(const aStrings: IvcmStrings);
var
 l_Index: Integer;
begin
 aStrings.Clear;
 for l_Index := Low(f_Values) To High(f_Values) Do
  aStrings.Add(vcmCStr(f_values[l_Index]^));
end;

procedure TnsTypedIntegerValueMap.DoGetDisplayNames(const aList: Il3StringsEx);
var
 l_Index: Integer;
begin
 inherited;
 for l_Index := Low(f_Values) To High(f_Values) Do
  aList.Add(vcmCStr(f_values[l_Index]^));
end;

class function TnsTypedIntegerValueMap.Make(aID: TnsValueMapID;
  aTypeInfo: PTypeInfo; const aValues: array of PvcmStringID): InsIntegerValueMap;
var
 l_Map: TnsTypedIntegerValueMap;
begin
 l_Map := Create(aID, aTypeInfo, aValues);
 try
  Result := l_Map;
 finally
  vcmFree(l_Map);
 end;
end;

function TnsTypedIntegerValueMap.GetMapSize: Integer;
begin
 Result := Length(f_Values);
end;

function TnsTypedIntegerValueMap.ValueToDisplayName(aValue: Integer): Il3CString;
begin
 if (aValue<f_TypeData.MinValue) or (aValue>f_TypeData.MaxValue) then
  raise El3ValueMapValueNotFound.CreateFmt('Value %d not found in Map %s',[aValue,rMapID.rName]);
 Result := vcmCStr(f_Values[aValue - f_TypeData.MinValue + Low(f_Values)]^);
end;

end.

