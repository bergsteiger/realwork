unit ddSpaceTrimmer;

interface

uses
 k2TagFilter, k2Types,
 l3Types, l3Base, l3Interfaces,
 dt_Types,
 ddTypes,
 l3RegEx;

type
 TddSpaceTrimmerFilter = class(Tk2TagFilter)
 private
  f_RegEx: Tl3RegularSearch;
  procedure BuildRegEx;
  procedure EraseSpacing(aString: Tl3String);
 protected
  procedure Cleanup; override;
  procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
 published
 end;

implementation

uses
 TextPara_Const,
 k2Tags,
 Math, StrUtils, SysUtils, l3Chars, Document_Const, l3String;

const
 cWords : Array[0..5] of String = (
          'постановил', 'установил', 'постановление', 'определение', 'определил', 'решил'
          );

procedure TddSpaceTrimmerFilter.BuildRegEx;
var
 l_Pattern : AnsiString;
 I, J: Integer;
begin
 l_Pattern := '{';
 for I := Low(cWords) to High(cWords) do
 begin
  l_Pattern := l_Pattern + '(';
  for J := 1 to Length(cWords[I]) do
   l_Pattern := l_Pattern + cWords[I][J] + IfThen(J < Length(cWords[I]), '\s+');
  l_Pattern := l_Pattern + ')' + IfThen(I < High(cWords), '|');
 end;
 l_Pattern := l_Pattern + '}(\s+{[\,\:\;\.]})?';
 f_RegEx := Tl3RegularSearch.Create;
 f_RegEx.IgnoreCase := True;
 f_RegEx.SearchPattern := l_Pattern;
end;

procedure TddSpaceTrimmerFilter.Cleanup;
begin
 FreeAndNil(f_RegEx);
 inherited;
end;

procedure TddSpaceTrimmerFilter.DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
var
 l_Value: Tk2Variant;
 l_Pos, l_Start, l_Finish, l_Delta: Integer;
 l_Str: Tl3String;
 l_Len: Integer;
 l_Msg: AnsiString;
begin
 if CurrentType.IsKindOf(k2_typTextPara) and
    (AtomIndex = k2_tiText) and (not Value.AsString.Empty) and
    (Value.AsString.AsWStr.SCodePage <> cp_Unicode) then
 begin
  l_Str:= Value.AsString as Tl3String;
  l3Replace(l_Str.St, cc_NonReadable + [cc_SoftSpace], cc_HardSpace, l_Str.Len);
  l_Len:= l_Str.Len;
  l_Str.LTrim;
  (l_Str).DeleteDoubleSpace;
  if l3AllCharsInCharSet(l_Str.St, l_Str.Len, ['_']) then
   l_Str.Clear
  else
   EraseSpacing(l_Str);
 end;
 inherited DoAddAtomEx(AtomIndex, Value);
end;

procedure TddSpaceTrimmerFilter.EraseSpacing(aString: Tl3String);
var
 l_RP: Tl3MatchPosition;
 l_NewStr: Il3CString;
begin
 if f_RegEx = nil then
  BuildRegEx;
 while f_RegEx.SearchInString(aString.AsWStr, l_RP) do
 begin
  l_NewStr := l3CStr(f_RegEx.TagParts[0]);
  l3DeleteChars(l_NewStr, vtSpacesANSISet);
  if f_Regex.TagParts.Count > 1 then
   l_NewStr := l3Cat(l_NewStr, f_RegEx.TagParts[1].AsWStr);
  aString.Delete(l_RP.StartPos, l_RP.Length);
  aString.Insert(l_NewStr.AsWStr, l_RP.StartPos);
 end;
end;

end.
