unit nsPictureScaleMap;
{* реализация мапы "строка"-"процент %" со спец значением "Во все окно"}

{$Include nsDefine.inc }

interface

uses
  Classes,

  l3Interfaces,
  l3BaseWithID,
  l3ValueMap,
  l3Types,
  l3VCLStrings,

  vcmExternalInterfaces,
  vcmInterfaces,

  L10nInterfaces,
  nsStringValueMap
  ;

type
 TnsPictureScaleMap = class(Tl3ValueMap, InsStringValueMap, InsSpecialStringValueMap, InsStringsSource)
 private
  f_SpecialValue : TnsStringValueMapRecord;
  f_Values       : Tl3Strings;
  f_MinValue     : Integer;
  f_MaxValue     : Integer;
 private
  // InsSpecialStringValueMap
  function DisplayNameToValue(const aDisplayName: Il3CString): Il3CString;
  function ValueToDisplayName(const aValue: Il3CString): Il3CString;
  function Get_SpecialDisplayName: Il3CString;
  function Get_SpecialValue: Il3CString;
  function Get_MinValue: Integer;
  function Get_MaxValue: Integer;
  // InsStringsSource
  procedure FillStrings(const aStrings: IvcmStrings);
 private
  procedure CheckValue(aValue: integer);
  procedure ValueError;
 protected
  procedure DoGetDisplayNames(const aList: Il3StringsEx);
   override;
  function GetMapSize: Integer;
   override;
 protected
  procedure Cleanup;
   override;
 public
  constructor Create(aID: TnsValueMapID; const aValues: array of integer; aMinValue: Integer;
   aMaxValue: Integer; const aSpecialValue: TnsStringValueMapRecord);
   reintroduce;
  class function Make(aID: TnsValueMapID; const aValues: array of integer; aMinValue: Integer;
   aMaxValue: Integer; const aSpecialValue: TnsStringValueMapRecord): InsStringValueMap;
   reintroduce;
 end;//TnsPictureScaleMap

implementation

uses
  SysUtils,

  l3Base,
  l3String,

  vcmBase,
  vcmUtils,

  nsTypes
  ;

{ TnsPictureScaleMap }


{ TnsPictureScaleMap }

procedure TnsPictureScaleMap.CheckValue(aValue: integer);
begin
 if (aValue > f_MaxValue) or (aValue < f_MinValue) then
  ValueError;
end;

procedure TnsPictureScaleMap.Cleanup;
begin
 vcmFree(f_Values);
 Finalize(f_SpecialValue);
 inherited Cleanup;
end;

constructor TnsPictureScaleMap.Create(aID: TnsValueMapID;
  const aValues: array of integer; aMinValue, aMaxValue: Integer;
  const aSpecialValue: TnsStringValueMapRecord);
var l_Index: Integer;
begin
 if aMinValue > aMaxValue then
  raise El3ValueMap.Create('Invalid parameter. min greater than max');
 inherited Create(aID);
 f_SpecialValue := aSpecialValue;
 f_MinValue := aMinValue;
 f_MaxValue := aMaxValue;
 f_Values := Tl3Strings.Create;
 for l_index := Low(aValues) to High(aValues) do
 begin
  CheckValue(aValues[l_index]);
  f_Values.Add(l3Fmt('%d %%', [aValues[l_index]]));
 end;//for l_index
 f_Values.Add(vcmCStr(f_SpecialValue.rN));
end;

function TnsPictureScaleMap.DisplayNameToValue(const aDisplayName: Il3CString): Il3CString;
var
 l_Temp: Il3CString;
begin
 if l3Same(Get_SpecialDisplayName, aDisplayName) then
  Result := Get_SpecialValue
 else
 begin
  l_Temp := l3Trim(aDisplayName);
  if l3IsNil(l_Temp) then
   ValueError;
  if l3IsChar(l_Temp, l3Len(l_Temp) - 1, '%') then
   l3SetLen(l_Temp, l3Len(l_Temp) - 1);
  try
   Result := l3Trim(l_Temp);
   CheckValue(StrToInt(l3Str(Result)));
  except
   on EConvertError do
    ValueError;
  end//try..except
 end;//l3Same(aDisplayName, Get_SpecialDisplayName)
end;

procedure TnsPictureScaleMap.FillStrings(const aStrings: IvcmStrings);
begin
 aStrings.Clear;
 aStrings.Assign(f_Values);
end;

procedure TnsPictureScaleMap.DoGetDisplayNames(const aList: Il3StringsEx);
begin
 inherited;
 aList.Assign(f_Values);
end;

class function TnsPictureScaleMap.Make(aID: TnsValueMapID;
  const aValues: array of integer; aMinValue, aMaxValue: Integer;
  const aSpecialValue: TnsStringValueMapRecord): InsStringValueMap;
var
 l_Map: TnsPictureScaleMap;
begin
 l_Map := Create(aID, aValues, aMinValue, aMaxValue, aSpecialValue);
 try
  Result := l_Map;
 finally
  vcmFree(l_Map);
 end;
end;

function TnsPictureScaleMap.GetMapSize: Integer;
begin
 Result := f_Values.Count;
end;

function TnsPictureScaleMap.Get_MaxValue: Integer;
begin
 Result := f_MaxValue;
end;

function TnsPictureScaleMap.Get_MinValue: Integer;
begin
 Result := f_MinValue;
end;

function TnsPictureScaleMap.Get_SpecialDisplayName: Il3CString;
begin
 Result := vcmCStr(f_SpecialValue.rN);
end;

function TnsPictureScaleMap.Get_SpecialValue: Il3CString;
begin
 Result := f_SpecialValue.rV;
end;

procedure TnsPictureScaleMap.ValueError;
begin
 raise El3ValueMapValueNotFound.CreateFmt('Must be integer value between %d-%d', [f_MinValue, f_MaxValue]);
end;

function TnsPictureScaleMap.ValueToDisplayName(const aValue: Il3CString): Il3CString;
begin
 if l3Same(Get_SpecialValue, aValue) then
  Result := Get_SpecialDisplayName
 else
  Result := l3Fmt('%s %%', [aValue]);
end;

end.

