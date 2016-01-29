unit dd_lcAttributeParser;

{ $Id: dd_lcAttributeParser.pas,v 1.2 2015/07/02 11:41:28 lukyanets Exp $ }

interface

uses
 l3Types,
 l3Interfaces,
 l3RegEx,
 l3Date,
 k2Types,
 k2TagGen,
 evdBufferedFilter,

 DT_Types,
 DT_Dict,
 k2TagTerminator, k2Prim;

type
 Tdd_lcAttributeParser = class(TevdBufferedFilter)
 private
  f_NeedMoreData: Boolean;
  f_Source: Il3CString;
  f_SourceRoot: TDictRootNode;
  function CheckForSuccess: Boolean;
  procedure CheckForTerminate(const aStr: Tl3WString);
  procedure ClearParameters;
  procedure FindData(const aStr: Tl3WString);
  procedure FindSource(const aStr: Tl3WString);
  procedure FlushAttributes;
 protected
  function NeedStartBuffering(aID : Integer): Boolean; override;
 public
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
  procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
 end;

type
 Tdd_lcScanReaction = procedure (const aString: AnsiString) of object;

 Tdd_lcAttributeScaner = class(Tk2TagTerminator)
 private
  f_CurFile: AnsiString;
  f_NeedMoreData: Boolean;
  f_OnCannotScan: Tdd_lcScanReaction;
  f_OnSuccessScan: Tdd_lcScanReaction;
  f_Date: TStDate;
  f_Source: TDictID;
  f_Type: TDictID;
  f_LawCase: Il3CString;
  f_PrevStr: Il3CString;
  f_REDate: Tl3RegularSearch;
  f_REFilename: Tl3RegularSearch;
  f_RELawCase: Tl3RegularSearch;
  f_SourceRoot: TDictRootNode;
  f_RETerminate: Tl3RegularSearch;
  f_TypeRoot: TDictRootNode;
  f_UseFilename: Boolean;
  function CheckForSuccess: Boolean;
  procedure CheckForTerminate(const aStr: Tl3WString);
  procedure ClearParameters;
  procedure FindData(const aStr: Tl3WString);
  procedure FindDate(const aStr: Tl3WString);
  procedure FindLawCase(const aStr: Tl3WString);
  procedure FindSource(const aStr: Tl3WString);
  procedure FindType(const aStr: Tl3WString);
  procedure FlushAttributes;
 protected
  procedure Cleanup; override;
 public
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
  procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
  procedure StartChild(TypeID : Tk2TypePrim); override;
  procedure CloseStructure(aNeedUndo: Boolean); override;
  property CurFile: AnsiString read f_CurFile write f_CurFile;
  property UseFilename: Boolean read f_UseFilename write f_UseFilename;
  property OnSuccessScan: Tdd_lcScanReaction read f_OnSuccessScan write f_OnSuccessScan;
  property OnCannotScan: Tdd_lcScanReaction read f_OnCannotScan write f_OnCannotScan;
 end;

implementation
uses
 SysUtils,

 l3Base,
 l3Const,
 l3String,
 l3Chars,
 l3TreeInterfaces,

 k2Base,
 k2Tags,
 Document_Const,
 LeafPara_Const,
 TextPara_Const,
 l3PrimString,

 daTypes,

 DT_Const,
 DT_DictConst,
 DT_AttrSchema,
 dt_DictIntf,

 ddAutolinkUtils,

 l3Tree_TLB,
 l3Nodes, l3_String, StrUtils, l3StringList;

function FindInDict(const aRootNode : Il3Node; const aTextStr  : Tl3WString): TDictID;
  {-}

 function IterHandler(const CurNode: Il3Node): Boolean;
 var
  l_Str: Il3CString;
 begin
  l_Str := l3Upper(CurNode.Text);
  Result := l3Pos(aTextStr, l_Str.AsWStr, False) <> l3NotFound;
 end;

var
 l_Node: Il3Node;
begin
 Result := cUndefDictID;
 l_Node := l3IterateSubTreeF(aRootNode, l3L2NA(@IterHandler), imCheckResult);
 if l_Node <> nil then
  Result := (l_Node as IDictItem).Handle;
end;

constructor Tdd_lcAttributeParser.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited;
 f_SourceRoot := DictServer(CurrentFamily).DictRootNode[da_dlSources];
end;

procedure Tdd_lcAttributeParser.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
var
 l_WStr: Tl3WString;
 l_Str : Tl3String;
begin
 if f_NeedMoreData and CurrentType.IsKindOf(k2_typLeafPara) and (AtomIndex = k2_tiText) and (Value.Kind = k2_vkString) then
 begin
  l_Str := Tl3String.Make(Value.AsString.AsWStr);
  try
   l_Str.CodePage := CP_ANSI; // потому что с unicode не работает regexp
   FindData(l_Str.AsWStr);
  finally
   FreeAndNil(l_Str);
  end;
 end;
 inherited;
end;

function Tdd_lcAttributeParser.CheckForSuccess: Boolean;
begin
 f_NeedMoreData := l3IsNil(f_Source);
 Result := not f_NeedMoreData;
 if Result then
  FlushAttributes;
end;

procedure Tdd_lcAttributeParser.CheckForTerminate(const aStr: Tl3WString);
begin
 
end;

procedure Tdd_lcAttributeParser.ClearParameters;
begin
 f_NeedMoreData := True;
 f_Source := nil;
end;

procedure Tdd_lcAttributeParser.FindData(const aStr: Tl3WString);
begin
 if l3IsNil(f_Source) then
  FindSource(aStr);
 if not CheckForSuccess then // проверка на то, что все данные найдены и сброс атрибутов в трубу
  CheckForTerminate(aStr); // граничное условие дл€ прекращени€ поиска атрибутов
 if not f_NeedMoreData then
  StopBufferingAndFlush(False, TopObject[0], False); 
end;

procedure Tdd_lcAttributeParser.FindSource(const aStr: Tl3WString);
var
 l_Node: Il3Node;
 l_Str: Tl3WString;
begin
 l_Str := l3Trim(aStr, cc_WhiteSpaceExt);
 l_Node := l3SearchByName(f_SourceRoot, l_Str);
 if l_Node <> nil then
  f_Source := l3GetFullPathCStr(f_SourceRoot, l_Node);
end;

procedure Tdd_lcAttributeParser.FlushAttributes;
begin

end;

function Tdd_lcAttributeParser.NeedStartBuffering(aID : Integer): Boolean;
var
 l_Type: Tk2Type;
begin
 Result:= False;
 if aID < 0 then
 begin
  l_Type := TypeTable.TypeByHandle[-aID];
  Result := l_Type.IsKindOf(k2_typDocument);
  if Result then
   ClearParameters;
 end;
end;

constructor Tdd_lcAttributeScaner.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited;
 f_SourceRoot := DictServer(CurrentFamily).DictRootNode[da_dlSources];
 f_TypeRoot := DictServer(CurrentFamily).DictRootNode[da_dlTypes];
 f_RETerminate := Tl3RegularSearch.Create;
 f_RETerminate.IgnoreCase := True;
 f_RETerminate.SearchPattern := '(установил)|(у с т а н о в и л)';
 f_RELawCase := Tl3RegularSearch.Create;
 f_RELawCase.IgnoreCase := True;
 f_RELawCase.SearchPattern := {'дел\w+ [Nє]\s?}'{[јA]\s?\d\d?\d?\s?[\Ц\-]\s?[\w\/\\\Ц\-_\(\)]+}';
 f_REDate := Tl3RegularSearch.Create;
 f_REDate.IgnoreCase := True;
 f_REDate.SearchPattern := '>[\"\Ђ]?{\d\d?}[\"\ї]?\s+{(€нвар[ь€])|(феврал[ь€])|(марта?)|(апрел[ь€])|(ма[й€])|(июн[ь€])|(июл[ь€])|(августа?)|(сент€бр[ь€])|(окт€бр[ь€])|(но€бр[ь€])|(декабр[ь€])}\s+{\d\d\d\d}(\s?{(года)|(г\.?)})?<';
 f_REFilename := Tl3RegularSearch.Create;
 f_REFilename.IgnoreCase := True;
 f_REFilename.SearchPattern := '[јA]\d+\-\d+\-\d+_+{\d\d\d\d}{\d\d}{\d\d}\.html?';
end;

procedure Tdd_lcAttributeScaner.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
var
 l_Str: Tl3String;
begin
 if f_NeedMoreData and CurrentType.IsKindOf(k2_typTextPara) and (AtomIndex = k2_tiText) and (Value.Kind = k2_vkString) then
 begin
  l_Str := Tl3String.Make(Value.AsString.AsWStr);
  try
   l_Str.CodePage := CP_ANSI;
   FindData(l_Str.AsWStr); // потому что regexp не работает с Unicode
  finally
   FreeAndNil(l_Str);
  end;
 end;
 inherited;
end;

function Tdd_lcAttributeScaner.CheckForSuccess: Boolean;
begin
 f_NeedMoreData := (f_Source = cUndefDictID) or (f_Type = cUndefDictID) or l3IsNil(f_LawCase) or (f_Date = BadDate);
 Result := not f_NeedMoreData;
end;

procedure Tdd_lcAttributeScaner.CheckForTerminate(const aStr: Tl3WString);
begin
 if f_RETerminate.SearchInString(aStr) then
  f_NeedMoreData := False;
end;

procedure Tdd_lcAttributeScaner.Cleanup;
begin
 FreeAndNil(f_RETerminate);
 FreeAndNil(f_RELawcase);
 FreeAndNil(f_REDate);
 FreeAndNil(f_REFilename);
 inherited;
end;

procedure Tdd_lcAttributeScaner.CloseStructure(aNeedUndo: Boolean);
var
 l_Str: AnsiString;

 procedure AddMissing(const aStr: AnsiString);
 begin
  if l_Str <> '' then
   l_Str := l_Str + ', ';
  l_Str := l_Str + aStr;
 end;

begin
 if TopType[0].IsKindOf(k2_typDocument) and (not CheckForSuccess) and Assigned(f_OnCannotScan) then
 begin
  l_Str := '';
  if f_Source = cUndefDictID then
   AddMissing('источник');
  if f_Type = cUndefDictID then
   AddMissing('тип');
  if f_Date = 0 then
   AddMissing('дата');
  if l3IsNil(f_LawCase) then
   AddMissing('номер дела');
  f_OnCannotScan(Format('%s не обработан, не хватает данных (%s)', [f_CurFile, l_Str]));
 end;
 inherited;
end;

procedure Tdd_lcAttributeScaner.ClearParameters;
var
 l_Y, l_M, l_D : Integer;
begin
 f_NeedMoreData := True;
 f_Source := cUndefDictID;
 f_Type := cUndefDictID;
 f_LawCase := nil;
 f_PrevStr := nil;
 if f_UseFilename and f_REFilename.SearchInString(f_CurFile) then
 begin
  l_Y := l3StrToInt(f_REFilename.TagParts.ItemW[0]);
  l_M := l3StrToInt(f_REFilename.TagParts.ItemW[1]);
  l_D := l3StrToInt(f_REFilename.TagParts.ItemW[2]);
  f_Date := DMYtoStDate(l_D, l_M, l_Y);
 end
 else
  f_Date := BadDate;
end;

procedure Tdd_lcAttributeScaner.FindData(const aStr: Tl3WString);
begin
 if f_Source = cUndefDictID then
  FindSource(aStr);
 if f_Type = cUndefDictID then
  FindType(aStr);
 if l3IsNil(f_LawCase) then
  FindLawCase(aStr);
 if f_Date = BadDate then
  FindDate(aStr);
 if CheckForSuccess then // проверка на то, что все данные найдены
  FlushAttributes // сброс атрибутов в трубу
 else
  CheckForTerminate(aStr); // граничное условие дл€ прекращени€ поиска атрибутов
end;

procedure Tdd_lcAttributeScaner.FindDate(const aStr: Tl3WString);
var
 l_Day, l_Month, l_Year: Integer;
 l_MS: Tl3WString;
begin
 if f_REDate.SearchInString(aStr) then
 begin
  l_Day := l3StrToInt(f_REDate.TagParts.ItemW[0]);

  l_MS := f_REDate.TagParts.ItemW[1];
  if l3Starts('€нвар', l_MS, True) then
   l_Month := 1
  else
  if l3Starts('феврал', l_MS, True) then
   l_Month := 2
  else
  if l3Starts('март', l_MS, True) then
   l_Month := 3
  else
  if l3Starts('апрел', l_MS, True) then
   l_Month := 4
  else
  if l3Starts('ма', l_MS, True) then
   l_Month := 5
  else
  if l3Starts('июн', l_MS, True) then
   l_Month := 6
  else
  if l3Starts('июл', l_MS, True) then
   l_Month := 7
  else
  if l3Starts('август', l_MS, True) then
   l_Month := 8
  else
  if l3Starts('сент€бр', l_MS, True) then
   l_Month := 9
  else
  if l3Starts('окт€бр', l_MS, True) then
   l_Month := 10
  else
  if l3Starts('но€бр', l_MS, True) then
   l_Month := 11
  else
  if l3Starts('декабр', l_MS, True) then
   l_Month := 12
  else
   Assert(False);

  l_Year := l3StrToInt(f_REDate.TagParts.ItemW[2]);

  f_Date := DMYtoStDate(l_Day, l_Month, l_Year);
 end;
end;

procedure Tdd_lcAttributeScaner.FindLawCase(const aStr: Tl3WString);
begin
 if f_RELawCase.SearchInString(aStr) then
 begin
  f_LawCase := l3CStr(f_RELawCase.TagParts[0]);
  l3Replace(f_LawCase, ['Ц', 'Ч'], '-');
  l3DeleteChars(f_LawCase, cc_WhiteSpaceExt);
  f_LawCase := NormalizeCasecode(f_LawCase);
 end;
end;

procedure Tdd_lcAttributeScaner.FindSource(const aStr: Tl3WString);
var
 l_Str, l_CollectedStr: Il3CString;
begin
 l_Str := l3CStr(aStr);
 l3Replace(l_Str, [cc_Tab, cc_SoftSpace], ' ');
 l_Str := l3Trim(l_Str);
 l_Str := l3DeleteDoubleSpace(l_Str);
 if not l3IsNil(l_Str) then
 begin
  f_Source := FindInDict(f_SourceRoot, l_Str.AsWStr);
  if f_Source = cUndefDictID then
  begin
   if not l3IsNil(f_PrevStr) then
   begin
    l_CollectedStr := l3Cat([f_PrevStr, l3CStr(' '), l_Str]);
    f_Source := FindInDict(f_SourceRoot, l_CollectedStr.AsWStr);
    if f_Source = cUndefDictID then
     f_PrevStr := l_Str;
   end
   else
    f_PrevStr := l_Str;
  end;
 end;
end;

procedure Tdd_lcAttributeScaner.FindType(const aStr: Tl3WString);
var
 l_WStr: Tl3WString;
 l_Node: Il3Node;
 l_IStr: Il3CString;
begin
 l_WStr := l3Trim(aStr, cc_WhiteSpaceExt);
 l_Node := l3SearchByName(f_TypeRoot, l_WStr);
 if l_Node = nil then
 begin
  l_IStr := l3CStr(l_WStr);
  l3DeleteChars(l_IStr, cc_WhiteSpaceExt);
  l_Node := l3SearchByName(f_TypeRoot, l_IStr);
 end;
 if l_Node <> nil then
  f_Type := (l_Node as IDictItem).Handle;
end;

procedure Tdd_lcAttributeScaner.FlushAttributes;
var
 l_Str: AnsiString;
begin
 if Assigned(f_OnSuccessScan) then
 begin
  l_Str := Format('%s;%d;%d;%s;%d', [f_CurFile, f_Source, f_Type, l3Str(f_LawCase), f_Date]);
  f_OnSuccessScan(l_Str);
 end;
end;

procedure Tdd_lcAttributeScaner.StartChild(TypeID : Tk2TypePrim);
var
 l_Type: Tk2Type;
begin
 if TypeID.IsKindOf(k2_typDocument) then
  ClearParameters;
 inherited;
end;

end.
