Unit dd_lcSourceConverter;

interface

uses k2TagFilter, Classes, l3Types, k2Types, k2TagGen;

type
 Tdd_lcSourceConverterFilter = class(Tk2TagFilter)
 private
  f_Sources: TStrings;
  f_SourcesFile: AnsiString;
  function ConvertSource(aSource: AnsiString): AnsiString;
  procedure pm_SetSourcesFile(const Value: AnsiString);
 protected
        {-}
  procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
        {-}
  procedure Cleanup; override;
 public
    // public methods
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
        {-}
  class function SetTo(var theGenerator: Tk2TagGenerator; const aSourceFileName: AnsiString): Pointer;
      reintroduce; overload;
  property SourcesFile: AnsiString read f_SourcesFile write pm_SetSourcesFile;
 end;

implementation

uses StrUtils, DictItem_Const, k2Tags, l3Base, SysUtils,
  l3Variant
  ;

constructor Tdd_lcSourceConverterFilter.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited;
 f_Sources:= TStringList.Create;
 f_Sources.NameValueSeparator:= ';';
end;

procedure Tdd_lcSourceConverterFilter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
var
 l_V: Tk2Variant;
begin
 if CurrentType.IsKindOf(k2_typDictItem) and (TopObject[1].isProp) then
  if (TopObject[1].AsProp.TagIndex = k2_tiSources) and (Value.Kind = k2_vkString) then
   Value.AsString.AsString:= ConvertSource(Value.AsString.AsString);
 inherited;
end;

procedure Tdd_lcSourceConverterFilter.Cleanup;
begin
 l3Free(f_Sources);
 inherited;
end;

function Tdd_lcSourceConverterFilter.ConvertSource(aSource: AnsiString): AnsiString;
begin
 Result := Trim(f_Sources.Values[aSource]);
 Result:= IfThen(Result = '', aSource, Result);
end;

procedure Tdd_lcSourceConverterFilter.pm_SetSourcesFile(const Value: AnsiString);
begin
 f_SourcesFile := Value;
 f_Sources.LoadFromFile(Value);
end;

class function Tdd_lcSourceConverterFilter.SetTo(var theGenerator: Tk2TagGenerator; const
    aSourceFileName: AnsiString): Pointer;
  {-}
begin
 Result:= inherited SetTo(theGenerator);
 Tdd_lcSourceConverterFilter(Result).SourcesFile:= aSourceFileName;
end;

end.