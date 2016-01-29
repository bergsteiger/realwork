unit ddDictCorrector;

{ $Id: ddDictCorrector.pas,v 1.4 2015/07/02 11:41:28 lukyanets Exp $ }

interface
uses
 l3Interfaces,
 l3Except,
 daTypes,
 DT_Types,
 DT_AttrSchema;

type
 EddDictCorrectError = class(El3Error); 

procedure ddCorrectDictionary(const aDict: TdaDictionaryType; const aFilenameRus, aFilenameEng: AnsiString);

implementation
uses
 SysUtils,

 l3Types,
 l3Base,
 l3LongintList,
 l3Nodes,
 l3TreeInterfaces,
 l3InterfacesMisc,
 l3Tree_TLB,
 l3Filer,
 l3String,
 l3StringList,
 l3Chars,

 DT_Const,
 DT_Dict,
 DT_DictConst,
 l3StringListPrim, l3LongintListPrim, l3_String, l3PrimString;

const
 csUnsyncLists    = '–ассинхронизаци€ русского и английского списков (строка %d)';
 csUnsyncListsStr = '–ассинхронизаци€ русского и английского списков (строка %d: "%s" и "%s")';

procedure PathToSubpaths(const aPath: Tl3WString; const aList: Tl3StringList);
var
 l_CurLen: Integer;
 l_Found: PAnsiChar;
begin
 aList.Clear;
 aList.Add(aPath);
 l_CurLen := aPath.SLen;
 repeat
  l_Found := ev_lpRScan('\', aPath.S, l_CurLen);
  if l_Found <> nil then
  begin
   l_CurLen := l_Found - aPath.S;
   aList.Insert(0, l3PAnsiCharLen(aPath.S, l_CurLen, aPath.SCodePage));
   Dec(l_CurLen);
  end;
 until l_Found = nil;
end;

function GetNameFromPath(const aPath: Tl3WString): Tl3WString;
var
 l_Found: PAnsiChar;
begin
 l_Found := ev_lpRScan('\', aPath.S, aPath.SLen);
 if l_Found <> nil then
  Result := l3PAnsiCharLen(l_Found + 1, aPath.S + aPath.SLen - l_Found - 1, aPath.SCodePage)
 else
  Result := aPath;
end;

function GetPathFromPath(const aPath: Tl3WString): Tl3WString;
var
 l_Found: PAnsiChar;
begin
 l_Found := ev_lpRScan('\', aPath.S, aPath.SLen);
 if l_Found <> nil then
  Result := l3PAnsiCharLen(aPath.S, l_Found - aPath.S, aPath.SCodePage)
 else
  l3AssignNil(Result);
end;

procedure ddCorrectDictionary(const aDict: TdaDictionaryType; const aFilenameRus, aFilenameEng: AnsiString);
var
 I: Integer;
 l_OldIDList: Tl3LongintList;
 l_Dict: TDictionary;
 l_EngName: Tl3WString;
 l_EngPaths: Tl3StringList;
 l_FileEng: Tl3DOSFiler;
 l_FileRus: Tl3DOSFiler;
 l_LastPaths: Tl3StringList;
 l_LineNo: Integer;
 l_RusName    : Tl3WString;
 l_RusNameStr : Tl3String;
 l_RusPaths: Tl3StringList;

const
 cc_TrimChars: TCharSet = cc_NonReadable + [cc_HardSpace, cc_SoftSpace];

 procedure RaiseError; overload;
 begin
  raise EddDictCorrectError.CreateFmt(csUnsyncLists, [l_LineNo]);
 end;

 procedure RaiseError(const aStrRus, aStrEng: Tl3WString); overload;
 begin
  raise EddDictCorrectError.CreateFmt(csUnsyncListsStr, [l_LineNo, l3Str(aStrRus), l3Str(aStrEng)])
 end;

 procedure DeleteIDFromDeleteList(const anID: TDictID);
 var
  l_Idx: Integer;
 begin
  l_Idx := l_OldIDList.IndexOf(anID);
  if l_Idx >= 0 then
   l_OldIDList.Delete(l_Idx);
 end;

 procedure CorrectOneEntry(const aPathR, aPathE: Tl3WString);
 var
  l_ParentNodePath: Tl3WString;
  l_ParentNode: Il3Node;
  l_RusName: Tl3WString;
  l_EngName: Tl3WString;
  l_OriginalEngName: Il3CString;
  l_ID : TDictID;
 const
  c_EmptyWStr: Tl3WString = (S: nil; SLen: 0; SCodePage: 0);
 begin
  l_ID := l_Dict.FindIDByFullPath(aPathR);
  l_EngName := GetNameFromPath(aPathE);
  if l_ID <> cUndefDictID then
  begin
   DeleteIDFromDeleteList(l_ID);
   l_OriginalEngName := l3CStr(TDictionaryTbl(l_Dict.Tbl).GetNameE(l_ID));
   if not l3Same(l_EngName, l_OriginalEngName) then
    TDictionaryTbl(l_Dict.Tbl).SetNameE(l_ID, l3Str(l_EngName));
  end
  else
  begin
   l_ParentNodePath := GetPathFromPath(aPathR);
   if l3IsNil(l_ParentNodePath) then
    l_ParentNode := nil
   else
   begin
    l_ParentNode := l_Dict.FindNodeByFullPath(l_ParentNodePath);
    if l_ParentNode = nil then
     RaiseError;
   end;
   l_RusName := GetNameFromPath(aPathR);
   l_Dict.AddDictNode(cUndefDictID, l_RusName, l_EngName, c_EmptyWStr, l_ParentNode);
  end;
 end;

 function CollectHandle(const CurNode: Il3Node): Boolean;
 var
  l_HandleNode : Il3HandleNode;
 begin
  Result := False;
  if l3IOk(CurNode.QueryInterface(Il3HandleNode, l_HandleNode)) then
   l_OldIDList.Add(l_HandleNode.Handle);
 end;

 procedure CheckRusName(const aRusName: Tl3WString);
 // если была ошибка, всЄ равно надо пробежатьс€ по русскому имени, чтобы не удалить потом лишнего
 var
  I: Integer;
  l_ID: TDictID;
  l_SubPaths: Tl3StringList;
 begin
  if l3IsNil(aRusName) then
   Exit;
  l_SubPaths := Tl3StringList.Make;
  try
   PathToSubpaths(aRusName, l_SubPaths);
   for I := 0 to l_SubPaths.Count - 1 do
   begin
    l_ID := l_Dict.FindIDByFullPath(l_SubPaths.ItemW[I]);
    if l_ID <> cUndefDictID then
     DeleteIDFromDeleteList(l_ID);
   end;
  finally
   FreeAndNil(l_SubPaths);
  end;
 end;

begin
 l_OldIDList := Tl3LongintList.MakeSorted;
 try
  l_Dict := DictServer(CurrentFamily).Dict[aDict];
  l3IterateSubTreeF(l_Dict.RootNode, l3L2NA(@CollectHandle));

  l_FileRus := Tl3DOSFiler.Make(aFilenameRus);
  try
   l_FileRus.Open;
   l_FileEng := Tl3DOSFiler.Make(aFilenameEng);
   try
    l_FileEng.Open;
    l_LastPaths := Tl3StringList.Make;
    l_RusPaths  := Tl3StringList.Make;
    l_EngPaths  := Tl3StringList.Make;
    try
     l_LineNo := 0;
     while not l_FileRus.EOF do
     begin
      l_RusName := l3Trim(l_FileRus.ReadLn, cc_TrimChars);
      l_RusNameStr := Tl3String.Make(l_RusName);
      try
       l_RusNameStr.CodePage := CP_ANSI;
       l_RusName := l_RusNameStr.AsWStr;
       l_EngName := l3Trim(l_FileEng.ReadLn, cc_TrimChars);
       try
        Inc(l_LineNo);
        if l3IsNil(l_RusName) and l3IsNil(l_EngName) then // это просто пуста€ строка в списке
         Continue;
        if l3IsNil(l_RusName) or l3IsNil(l_EngName) then // а это - уже ошибка
         RaiseError(l_RusName, l_EngName);
        PathToSubpaths(l_RusName, l_RusPaths);
        PathToSubpaths(l_EngName, l_EngPaths);
        if l_RusPaths.Count <> l_EngPaths.Count then
         RaiseError(l_RusName, l_EngName);
        for I := 0 to l_RusPaths.Count-1 do
        begin
         if l_LastPaths.IndexOf(l_RusPaths.ItemW[I]) < 0 then
         begin
          CorrectOneEntry(l_RusPaths.ItemW[I], l_EngPaths.ItemW[I]);
         end;
        end;
        l_LastPaths.Assign(l_RusPaths);
       except
        on E: EddDictCorrectError do
        begin
         CheckRusName(l_RusName);
         l3System.Msg2Log(E.Message);
        end;
       end;
      finally
       FreeAndNil(l_RusNameStr);
      end;
     end; // while
     // теперь надо удалить ненайденные элементы
     for I := 0 to l_OldIDList.Count - 1 do
      l_Dict.DelDictItem(l_OldIDList.Items[I]);
    finally
     FreeAndNil(l_LastPaths);
     FreeAndNil(l_RusPaths);
     FreeAndNil(l_EngPaths);
    end;
   finally
    FreeAndNil(l_FileEng);
   end;
  finally
   FreeAndNil(l_FileRus);
  end;

 finally
  FreeAndNil(l_OldIDList);
 end;
end;

end.