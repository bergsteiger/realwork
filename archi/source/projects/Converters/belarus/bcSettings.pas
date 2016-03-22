unit bcSettings;

interface
uses
 l3StringToStringMap,
 ddCSV;

type
 TbcSettings = class(TddSectionedCSVLoader)
 private
  f_TypesMap: Tl3StringToStringMap;
  f_SkipMap: Tl3StringToStringMap;
  f_SourcesMap: Tl3StringToStringMap;
  procedure LoadMap(const aMap: Tl3StringToStringMap; const aName: AnsiString);
  function pm_GetTypesMap: Tl3StringToStringMap;
  function pm_GetSkipMap: Tl3StringToStringMap;
  function pm_GetSourcesMap: Tl3StringToStringMap;
 protected
  procedure Cleanup; override;
  procedure DispatchSection; override;
 public
  property TypesMap: Tl3StringToStringMap read pm_GetTypesMap;
  property SkipMap: Tl3StringToStringMap read pm_GetSkipMap;
  property SourcesMap: Tl3StringToStringMap read pm_GetSourcesMap;
 end;

implementation
uses
 SysUtils,
 l3Base,
 l3Interfaces,
 l3Except,
 l3String;

procedure TbcSettings.Cleanup;
begin
 FreeAndNil(f_TypesMap);
 FreeAndNil(f_SourcesMap);
 FreeAndNil(f_SkipMap);
 inherited;
end;

procedure TbcSettings.DispatchSection;
begin
 if l3Same(SectName, 'types') then
  LoadMap(TypesMap, 'типы')
 else
 if l3Same(SectName, 'sources') then
  LoadMap(SourcesMap, 'источники')
 else
 if l3Same(SectName, 'skip') then
  LoadMap(SkipMap, 'пропускаемые документы')
 else
  SkipSection;
end;

procedure TbcSettings.LoadMap(const aMap: Tl3StringToStringMap; const aName: AnsiString);
var
 l_Key: Il3CString;
begin
 while NextLine do
 begin
  if ValuesCount >= 2 then
  begin
   l_Key := l3Upper(l3Trim(ValuesW[0]));
   if not l3IsNil(l_Key) then
   begin
    if not aMap.Has(l_Key) then
     aMap.Add(l_Key, l3CStr(l3Trim(ValuesW[1])))
    else
     l3System.Msg2Log('Повторяются %s в настройках: %s', [aName, l3Str(l3Trim(ValuesW[0]))]);
   end;
  end;
 end;
end;

function TbcSettings.pm_GetTypesMap: Tl3StringToStringMap;
begin
 if f_TypesMap = nil then
  f_TypesMap := Tl3StringToStringMap.Create;
 Result := f_TypesMap;
end;

function TbcSettings.pm_GetSkipMap: Tl3StringToStringMap;
begin
 if f_SkipMap = nil then
  f_SkipMap := Tl3StringToStringMap.Create;
 Result := f_SkipMap;
end;

function TbcSettings.pm_GetSourcesMap: Tl3StringToStringMap;
begin
 if f_SourcesMap = nil then
  f_SourcesMap := Tl3StringToStringMap.Create;
 Result := f_SourcesMap;
end;

end.
