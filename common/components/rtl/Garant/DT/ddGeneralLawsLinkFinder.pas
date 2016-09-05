unit ddGeneralLawsLinkFinder;

{ $Id: ddGeneralLawsLinkFinder.pas,v 1.5 2016/08/24 09:11:13 fireton Exp $ }

interface

uses
 l3LongintList,
 ddCustomLinkFinder;

{$I DtDefine.inc}

function ddGetGeneralLawsLinkFinder(aAllowedSources: Tl3LongintList; const aDataFileName: AnsiString): TddCustomLinkFinder;
function ddGetGeneralLawsLinkFinderDef: TddCustomLinkFinder;

implementation
uses
 SysUtils,
 l3Interfaces,
 l3InterfaceList,
 l3Types,
 l3Base,
 l3Chars,
 l3String,
 l3Nodes,
 l3RecList,
 l3RegEx,
 l3Tree_TLB,
 l3Date,
 l3ListUtils,
 l3FileUtils,
 daTypes,
 daInterfaces,
 daSchemeConsts,
 dtIntf,
 dt_Types,
 dt_DictIntf,
 dt_Sab,
 dt_Dict,
 dt_LinkServ,
 dt_Serv,
 m4DictTypes,
 m4DictScanner,
 m4PhraseParser,
 ddTypes,
 ddAutolinkTypes,
 ddDocStructBase,
 ddAutolinkConst,
 ddAutolinkDocEntry,
 ddAutolinkUtils,
 ddAutolinkDataLoader,
 ddAutolinkDataSource,
 ddAutolinkInterfaces,
 ddAutolinkArbitraryDocList,
 ddAutolinkDocHistory,
 ddBaseAutolinkDataSource,
 ddEntryCollector;

const
 cMaxLinkInChain = 200;

type
 PFoundCodexRec = ^TFoundCodexRec;
 TFoundCodexRec = record
  rCodexIdx : Integer; // индекс кодекса в списке кодексов
  rDoc      : array [0..cMaxLinkInChain-1] of TddALDocRec; // список возможных ссылок на кодекс
  rBlock    : array [0..cMaxLinkInChain-1] of Integer;
 end;

type
 TddGeneralLawsLinkFinder = class(TddCustomLinkFinder)
 private
  f_ArbCourtNode: Il3Node;
  f_AllowedSources: Tl3LongintList;
  f_ArbitraryDocs: TddAutolinkArbitraryDocList;
  f_CodexData: Tl3InterfaceList;
  f_DefaultAbbr: AnsiString;
  f_DefaultAbbrCodex: Integer;
  f_DefaultCodex: Integer;
  f_EntryCollector: TddEntryCollector;
  f_FoundCodex: Tl3RecList;
  f_FoundSources: Tl3LongintList;
  f_CodexType: TDictID;
  f_ConstitutionDocID: TddALDocRec;
  f_GostType : TDictID;
  f_CourtRootNode: Il3Node;
  f_DataFileName: AnsiString;
  f_KonsType: TDictID;
  f_LastFoundCodex: TDocID;
  f_LastFoundSources: Tl3LongintList;
  f_LoneTypes: Tl3LongintList;
  f_PossibleLinks: Tl3RecList;
  f_ResolutionType: TDictID;
  f_SPChainConnector: Tl3RegularSearch;
  f_SPRusFed: Tl3RegularSearch;
  f_DataSource: TddBaseAutolinkDataSource;
  f_DocHistory: TddAutolinkDocHistory;
  procedure LoadSkippies;
  function pm_GetFoundSources: Tl3LongintList;
  function pm_GetSPChainConnector: Tl3RegularSearch;
  function pm_GetSPRusFed: Tl3RegularSearch;
  function AddFoundCodex(const aCodexIdx: Integer): Integer;
  procedure LoadStopWords;
  function pm_GetFoundCodex(aIndex: Integer): PFoundCodexRec;
  property FoundCodex[aIndex: Integer]: PFoundCodexRec read pm_GetFoundCodex;
 protected
  procedure Cleanup; override;
  procedure pm_SetOnError(const Value: TddErrorEvent); override;
  property FoundSources: Tl3LongintList read pm_GetFoundSources;
  property SPChainConnector: Tl3RegularSearch read pm_GetSPChainConnector;
  property SPRusFed: Tl3RegularSearch read pm_GetSPRusFed;
 public
  constructor Create(aAllowedSources: Tl3LongintList; const aDataFileName: AnsiString);
  procedure Done; override;
  procedure DoOnNewDocument; override;
  procedure FindLinks(const aText     : AnsiString;  // text from master doc
                      aDocID          : TDocID;  // master doc id
                      aDocDate        : TStDate; // master doc date
                      const aCaseCode : Il3CString;
                      aLinkProc       : TddLinkSetRoutine); override;
  procedure Init; override;
  property AllowedSources: Tl3LongintList read f_AllowedSources;
 end;

const
 cAbbrWordDelims: set of Char = [' ', '.', ',', '(', ')', '!', '?', ':', ';', cc_SoftSpace]; 

type
 TddGeneralLawsLinkFinderBox = class(Tl3Base, Il3ItemNotifyRecipient)
 private
  f_Finder: TddGeneralLawsLinkFinder;
  procedure KillFinder;
 protected
  procedure Cleanup; override;
  procedure Notify(const aNotifier: Il3ChangeNotifier; aOperation: Integer; aIndex: Integer);
 public
  constructor Create;
  function GetFinder(aAllowedSources: Tl3LongintList; const aDataFileName: AnsiString): TddGeneralLawsLinkFinder;
 end;

var
 g_GeneralLawsLinkFinderBox: TddGeneralLawsLinkFinderBox = nil;

function IsReallySeparated(const aText: AnsiString; aStart, aFinish: Integer): Boolean;
begin
 Result := ((aStart = 1) or (aText[aStart-1] in cAbbrWordDelims)) and
        ((aFinish = Length(aText)) or (aText[aFinish+1] in cAbbrWordDelims));
end;

constructor TddGeneralLawsLinkFinder.Create(aAllowedSources: Tl3LongintList; const aDataFileName: AnsiString);
var
 l_TempID: TDictID;
 l_Sab: ISab;
 l_DataLoader : TddAutolinkDataLoader;
 l_FZType: TDictID;
 l_ZType: TDictID;
begin
 inherited Create;
 f_LoneTypes := Tl3LongintList.MakeSorted;
 f_CodexData := Tl3InterfaceList.Make;
 f_ArbitraryDocs := TddAutolinkArbitraryDocList.Make;
 if FileExists(aDataFileName) then
 begin
  l_DataLoader := TddAutolinkDataLoader.Create(aDataFileName, f_CodexData, f_LoneTypes, f_ArbitraryDocs);
  try
   l_DataLoader.Process;
   f_ConstitutionDocID.rExtDocID := l_DataLoader.Misc.rConstitutionDocID;
   f_DataFileName := aDataFileName;
  finally
   FreeAndNil(l_DataLoader);
  end;
 end
 else
  l3System.Msg2Log('WARNING: Не найден файл %s! Возможно, будут проставлены не все ссылки.', [aDataFileName]);

 if f_ConstitutionDocID.rExtDocID > 0 then
 begin
  f_ConstitutionDocID.rIntDocID := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(f_ConstitutionDocID.rExtDocID);
  if f_ConstitutionDocID.rIntDocID = cUndefDocID then
   l3FillChar(f_ConstitutionDocID, SizeOf(f_ConstitutionDocID));
 end;

 LoadSkippies;
 LoadStopWords;
 f_EntryCollector := TddEntryCollector.Create;
 f_PossibleLinks := Tl3RecList.Create(SizeOf(TLinkPrimRec));
 f_AllowedSources := Tl3LongintList.MakeSorted;
 if aAllowedSources <> nil then
 begin
  f_AllowedSources.Assign(aAllowedSources);
  l_Sab := GetExpandDictIDValueSab(da_dlSources, f_AllowedSources);
  f_AllowedSources.Clear;
  dtCopyValuesSabToList(l_Sab, f_AllowedSources);
  l_Sab := nil;
 end;
 f_FoundCodex := Tl3RecList.Create(SizeOf(TFoundCodexRec));
 f_LastFoundSources := Tl3LongintList.Make;
 with DictServer(CurrentFamily).Dict[da_dlSources] do
 begin
  f_CourtRootNode := FindNodeByFullPath(l3PCharLen('Органы судебной власти РФ и СССР'));
  f_ArbCourtNode := FindNodeByFullPath(l3PCharLen('Органы судебной власти РФ и СССР\Арбитражные апелляционные суды'));
 end;

 with DictServer(CurrentFamily).Dict[da_dlTypes] do
 begin
  f_KonsType := FindIDByFullPath(l3PCharLen('Конституция'));
  f_CodexType := FindIDByFullPath(l3PCharLen('Кодекс'));
  f_ResolutionType := FindIDByFullPath(l3PCharLen('Постановление'));
  f_GostType := FindIDByFullPath(l3PCharLen('Нормативно-техническая документация\ГОСТ (Государственный стандарт)'));

  l_TempID := FindIDByFullPath(l3PCharLen('Письмо'));
  l_ZType  := FindIDByFullPath(l3PCharLen('Закон'));
  l_FZType := FindIDByFullPath(l3PCharLen('Федеральный закон'));
 end;

 f_DocHistory := TddAutolinkDocHistory.Create(l_FZType, l_ZType);

 if l_TempID >= 0 then
 begin
  DictServer(CurrentFamily).DictScanner.AddToDict(l3PCharLen('информационное письмо'), l_TempID, Ord(da_dlTypes));
  DictServer(CurrentFamily).DictScanner.AddComplete;
 end;
end;

function TddGeneralLawsLinkFinder.AddFoundCodex(const aCodexIdx: Integer): Integer;
var
 l_CodexRec: TFoundCodexRec;
begin
 l3FillChar(l_CodexRec, SizeOf(TFoundCodexRec));
 l_CodexRec.rCodexIdx := aCodexIdx;
 Result := f_FoundCodex.Add(l_CodexRec);
end;

procedure TddGeneralLawsLinkFinder.Cleanup;
begin
 FreeAndNil(f_EntryCollector);
 FreeAndNil(f_PossibleLinks);
 FreeAndNil(f_FoundSources);
 FreeAndNil(f_FoundCodex);
 FreeAndNil(f_SPRusFed);
 FreeAndNil(f_SPChainConnector);
 FreeAndNil(f_AllowedSources);
 FreeAndNil(f_LastFoundSources);
 FreeAndNil(f_LoneTypes);
 FreeAndNil(f_CodexData);
 FreeAndNil(f_DataSource);
 FreeAndNil(f_DocHistory);
 FreeAndNil(f_ArbitraryDocs);
 inherited;
end;

procedure TddGeneralLawsLinkFinder.Done;
begin
 FreeAndNil(f_DataSource);
end;

procedure TddGeneralLawsLinkFinder.DoOnNewDocument;
begin
 f_DefaultCodex := -1;
 f_DefaultAbbr := '';
 f_DefaultAbbrCodex := -1;
 f_LastFoundCodex := -1;
 f_DocHistory.Clear;
end;

procedure TddGeneralLawsLinkFinder.FindLinks(const aText     : AnsiString;  // text from master doc
                                             aDocID          : TDocID;  // master doc id
                                             aDocDate        : TStDate; // master doc date
                                             const aCaseCode : Il3CString;
                                             aLinkProc       : TddLinkSetRoutine);
var
 l_ChainCursor : Integer;
 l_ChainEndPos : Integer;
 l_FoundType: Integer;
 l_LastFoundType: Integer;
 l_FoundDate: TStDate;
 l_FoundNum      : Il3CString;
 l_FoundCasecode : Il3CString;
 l_FoundShort: TddALDocRec;
 l_TypePos : Tm4Segment;
 l_StopPos : Tm4Segment;
 l_DatePos : Tm4Segment;
 l_NumPos  : Tm4Segment;
 l_DocStartPos: Integer;
 l_LastChainEndPos: Integer;
 l_DocLen     : Integer;
 l_LeftMostPos: Integer;
 l_LastFoundCodexInPara: Integer;
 lFDIProcStub : Tm4FoundDictItemProc;
 l_TextLen: Integer;
 l_FurtherSeg: Tm4Segment;
 l_HistoryIdx: Integer;

 procedure ResetChain;
 begin
  l_ChainCursor := -1;
  l_ChainEndPos := -1;
  l_DocStartPos := 0;
  l_DocLen      := 0;
  FoundSources.Clear;
  l_FoundType := -1;
  l_FoundDate := 0;
  l3FillChar(l_FoundShort, SizeOf(l_FoundShort));
  l_FoundNum := nil;
  l_FoundCasecode := nil;
  l3FillChar(l_FurtherSeg, SizeOf(l_FurtherSeg));
  l3FillChar(l_StopPos, SizeOf(l_StopPos));
  l_HistoryIdx := -1;
 end;

 procedure OutWarning(const aStr: AnsiString);
 begin
  if Assigned(f_OnError) then
   f_OnError(Format('%d: %s', [aDocID, aStr]), 1);
 end;

 procedure FindDocAndBlockToLink(const aDocument        : TddALDocRec;
                                 const anAddress        : TddDocStructElementRec;
                                 var   theContemporalDoc: TddALDocRec;
                                 out   theDocToLink     : TddALDocRec;
                                 out   theBlockID       : Integer);
 begin
  theBlockID := f_DataSource.FindBlock(aDocument.rExtDocID, anAddress);
  theDocToLink := aDocument;
  if theBlockID < 0 then // в актуальной редакции не нашли, ищем в современной
  begin
   if theContemporalDoc.rIntDocID = 0 then // если современную редакцию ещё не вычисляли...
   begin
    theContemporalDoc := f_DataSource.GetContemporalEdition(aDocument.rExtDocID, aDocDate);
    if theContemporalDoc.rExtDocID = aDocument.rExtDocID then
     theContemporalDoc.rIntDocID := -1; // если современная = актуальная, то искать в ней не имеет смысла
   end;
   if theContemporalDoc.rExtDocID > 0 then
   begin
    theBlockID := f_DataSource.FindBlock(theContemporalDoc.rExtDocID, anAddress);
    theDocToLink := theContemporalDoc;
   end;
  end;
 end;

 procedure FilterCodexByKeywords;
 var
  I: Integer;
  l_KeywordsCount: array[0..cMaxCodex-1] of Integer;
  l_MaxKeywords: Integer;
  l_Stub: Tm4FoundDictItemProc;

  function l_FoundOneKeyword(aDictItemID : Tm4DictItemAddr; aSegment : Tm4Segment) : boolean;
  var
   I: Integer;
  begin
   Result := True;
   if aDictItemID.rDictionaryID = cCodexKeywordsDictID then
   begin
    for I := 0 to f_FoundCodex.Count-1 do
     if FoundCodex[I].rCodexIdx = aDictItemID.rID then
     begin
      l_KeywordsCount[I] := l_KeywordsCount[I] + 1;
      if l_MaxKeywords < l_KeywordsCount[I] then
       l_MaxKeywords := l_KeywordsCount[I];
      Break;
     end;
   end;
  end;

 begin
  if f_FoundCodex.Count < 2 then
   Exit;
  l3FillChar(l_KeywordsCount, SizeOf(l_KeywordsCount));
  l_MaxKeywords := 0;
  l_Stub := L2FoundDictItemProc(@l_FoundOneKeyword);
  try
   DoParsePhrase(l3PCharLen(aText), DictServer(CurrentFamily).DictScanner, l_Stub);
  finally
   FreeFoundDictItemProc(l_Stub);
  end;
  if l_MaxKeywords > 0 then
   for I := f_FoundCodex.Count-1 downto 0 do
    if l_KeywordsCount[I] < l_MaxKeywords then
     f_FoundCodex.Delete(I);
 end;

 procedure WorkoutCodexPrim(const aOffset, aLen: Integer; const aIsAbbr: Boolean);
 var
  I, J : Integer;
  l_FoundLinkChain : Boolean;
  l_LinksIsSet : Boolean;
  l_FoundLinksPerCodex: array[0..cMaxCodex-1] of Integer;
  l_PLinkItem: PLinkPrimRec;
  l_DocToLink: TddALDocRec;
  l_ContemporalDoc: TddALDocRec;
  l_BlockID : Integer;
  l_MaxLinksFound: Integer;
  l_LinkMsg: AnsiString;
  l_FTempPos: Tl3MatchPosition;
  l_DocID: TddALDocRec;
  l_CD: ICodexDataHolder;
 begin
  l_FoundLinkChain := False;
  if f_FoundCodex.Count > 0 then
  begin
   l_LinksIsSet := False;

   l_FoundLinkChain := f_EntryCollector.CollectEntries(PAnsiChar(aText), l_LeftMostPos, aOffset-1, f_PossibleLinks);
   if f_PossibleLinks.Count > 0 then
   begin
    while f_PossibleLinks.Count > cMaxLinkInChain do  // подстраховка, на случай если цепочка слишком длинная
     f_PossibleLinks.Delete(f_PossibleLinks.Count-1); // хотя трудно представить цепочку >200 элементов...
     
    // Ищем в блокнеймах каждого найденного кодекса
    f_DataSource.DocumentAlreadyDefined; // говорим источнику данных, что документ искать не будем, он уже найден
    l3FillChar(l_FoundLinksPerCodex, SizeOf(l_FoundLinksPerCodex));
    for I := 0 to f_FoundCodex.Count - 1 do
    begin
     l_CD := ICodexDataHolder(f_CodexData[FoundCodex[I].rCodexIdx]);
     l3FillChar(l_ContemporalDoc, SizeOf(l_ContemporalDoc));
     for J := 0 to f_PossibleLinks.Count-1 do
     begin
      l_PLinkItem  := PLinkPrimRec(f_PossibleLinks.ItemSlot(J));
      // ищем нужный документ и блокнейм
      FindDocAndBlockToLink(l_CD.ActualEdition, l_PLinkItem^.rAddress, l_ContemporalDoc, l_DocToLink, l_BlockID);
      FoundCodex[I].rDoc[J]   := l_DocToLink;
      FoundCodex[I].rBlock[J] := l_BlockID;
      if l_BlockID >= 0 then // Если в хотя бы одной редакции блокнейм нашелся, то
       Inc(l_FoundLinksPerCodex[I]); // увеличиваем список найденных ссылок для этого кодекса
     end;
    end;

    // выясняем, для какое количество найденных ссылок - максимальное
    l_MaxLinksFound := 0;
    for I := 0 to f_FoundCodex.Count - 1 do
     if l_FoundLinksPerCodex[I] > l_MaxLinksFound then
      l_MaxLinksFound := l_FoundLinksPerCodex[I];

    if l_MaxLinksFound > 0 then // если вообще что-то нашлось
    begin
     // выкидываем из списка все кодексы с немаксимальным количеством ссылок
     for I := f_FoundCodex.Count - 1 downto 0 do
      if l_FoundLinksPerCodex[I] < l_MaxLinksFound then
       f_FoundCodex.Delete(I);

     // если и после всех манипуляций в списке больше одного кодекса - фильтруем список по ключевым словам в абзаце
     if f_FoundCodex.Count > 1 then
      FilterCodexByKeywords;

     // Проставляем ссылки на первый в списке кодекс, если он там не один - ну что ж, мы старались...
     for I := 0 to f_PossibleLinks.Count-1 do
     begin
      with PLinkPrimRec(f_PossibleLinks.ItemSlot(I))^, FoundCodex[0]^ do
      begin
       if rBlock[I] >= 0 then
       begin
        // ставим ссылку на нужную редакцию нужного кодекса
        aLinkProc(rStart, rEnd, rDoc[I].rIntDocID, rBlock[I], l_LinkMsg);
        l_LinkMsg := '';
        l_LinksIsSet := True;
       end;
      end
     end;
     l_LastFoundCodexInPara := FoundCodex[0].rCodexIdx;
     f_LastFoundCodex := l_LastFoundCodexInPara;
    end;
   end; // f_PossibleLinks.Count > 0

   if (not l_LinksIsSet) then // если не нашли цепочку или в цепочке не нашли ссылок, то
   begin
    if ((not aIsAbbr) and (not l_FoundLinkChain)) or
       (aIsAbbr and SPRusFed.SearchInString(PAnsiChar(aText)+ aOffset + aLen + 1, 0, l_TextLen - aOffset - aLen, l_FTempPos)) then
    begin
     // ставим ссылку на сам кодекс
     // если найдено несколько, пытаемся отфильтровать по ключевым словам
     if f_FoundCodex.Count > 1 then
      FilterCodexByKeywords;

     // ставим на первый в списке, если их несколько - что ж, мы старались
     I := 0;
     while I < f_FoundCodex.Count do // перебираем, на случай если данные из autolink.dat неверны
     begin
      l_CD := ICodexDataHolder(f_CodexData[FoundCodex[I].rCodexIdx]);
      l_DocID := l_CD.ActualEdition;
      if l_DocID.rIntDocID <> c_NoEdition then // вот на этот случай как раз
      begin
       l_LastFoundCodexInPara := FoundCodex[I].rCodexIdx;
       f_LastFoundCodex := l_LastFoundCodexInPara;
       if f_FoundCodex.Count > 1 then
        l_LinkMsg := 'Не удалось различить кодексы, ставим ссылку на первый валидный в списке';
       aLinkProc(aOffset, aOffset + aLen, l_DocID.rIntDocID, 0, l_LinkMsg);
       l_LinkMsg := '';
       Break;
      end;
      Inc(I);
     end; // while I < f_FoundCodex.Count do
    end;
   end;
  end; // f_FoundCodex.Count > 0
  l_LeftMostPos := l_DocStartPos + l_DocLen + 1;
  ResetChain;
 end;

 procedure WorkOutCodex(aCodexNo: Integer; const aOffset, aLen: Integer);
 begin
  f_FoundCodex.Clear;
  if (aCodexNo > f_CodexData.Count-1) then
  begin
   if (f_LastFoundCodex >= 0) then
    AddFoundCodex(f_LastFoundCodex)
   else
   begin
    ResetChain;
    Exit;
   end;
  end
  else
   AddFoundCodex(aCodexNo);
  WorkoutCodexPrim(aOffset, aLen, False);
 end;

 function CheckSources: Boolean;
 var
  I: Integer;
 begin
  if f_AllowedSources.Empty then
   Result := True
  else
  begin
   Result := False;
   if not FoundSources.Empty then
    for I := 0 to FoundSources.Count - 1 do
     if f_AllowedSources.IndexOf(FoundSources[I]) >= 0 then
     begin
      Result := True;
      Break;
     end;
  end;
 end;

 function l3CStr2WStr(const aCStr: Il3CString): Tl3WString;
 begin
  if l3IsNil(aCStr) then
   Result := cc_EmptyStr
  else
   Result := aCStr.AsWStr;
 end;

 procedure WorkoutChain;
 var
  l_DocStr: AnsiString;
  l_DocID: TddALDocRec;
  l_PLinkRec: PLinkPrimRec;
  l_BlockID: Longint;
  I: Integer;
  l_LinkIsSet: Boolean;
  l_SNode: Il3Node;
  l_TheDocLinkPos: Tm4Segment;
  l_RP: Tl3MatchPosition;
  l_ContemporalDoc: TddALDocRec;
  l_DocForLink: TddALDocRec;
 begin
  l3FillChar(l_DocID, SizeOf(TddALDocRec));
  l_TheDocLinkPos := l_TypePos;
  // надо проверить, не "наследуем" ли мы атрибуты прошлой цепочки
  // если уже были цепочки с типом документа и тип не найден, но найдена дата или номер...
  if (l_LastChainEndPos > 0) and (l_LastFoundType >= 0) and (l_FoundType < 0) and
     ((l_FoundDate > 0) or (not l3IsNil(l_FoundNum))) then
  begin
   if SPChainConnector.SearchInString(PAnsiChar(aText)+l_LastChainEndPos, 0, l_DocStartPos - l_LastChainEndPos, l_RP) then
   begin
    l_FoundType := l_LastFoundType;
    if f_FoundSources.Empty then
     f_FoundSources.Assign(f_LastFoundSources);
    if not l3IsNil(l_FoundNum) then
     l_TheDocLinkPos := l_NumPos
    else
     l_TheDocLinkPos := l_DatePos;
   end;
  end;

  if CheckSources then
  begin
   if (l_FoundShort.rIntDocID > 0) then // если мы нашли документ по короткому имени, то больше ничего не надо
   begin
    l_DocID := l_FoundShort;
    f_DataSource.DocumentAlreadyDefined;
   end
   else
   if (l_FoundType >= 0) and
      ((l_FoundType = f_KonsType) or (l_FoundDate > 0) or not l3IsNil(l_FoundNum) or not l3IsNil(l_FoundCasecode)) then
   begin
    if (FoundSources.Count > 0) or (f_LoneTypes.IndexOf(l_FoundType) >= 0) then
    begin
     if (l_FoundType = f_KonsType) and (f_ConstitutionDocID.rIntDocID <> 0) then
      l_DocID := f_ConstitutionDocID
     else
     begin
      if (l_FoundType = f_KonsType) or (l_FoundDate > 0) or not l3IsNil(l_FoundNum) or not l3IsNil(l_FoundCasecode) then
      begin
       // данных достаточно для поиска, строим запрос
       f_DataSource.StartDocQuery;
       try
        // тип документа
        f_DataSource.FilterByDocType(l_FoundType);

        // дата и номер
        if (l_FoundDate > 0) or (not l3IsNil(l_FoundNum)) then
        begin
         // если документ - постановление арбитражного суда, то надо отпилить у него суффикс "-ГК" или "-АК"
         if (not l3IsNil(l_FoundNum)) and (l_FoundType = f_ResolutionType) and
            (f_ArbCourtNode <> nil) and (FoundSources.Count = 1) then
         begin
          l_SNode := DictServer(CurrentFamily).Dict[da_dlSources].FindNodeByID(FoundSources.Items[0]);
          if (l_SNode <> nil) and (l_SNode.ParentNode = f_ArbCourtNode) then
          begin
           if l3Ends(l3PCharLen('-ГК'), l_FoundNum.AsWStr, True) or l3Ends(l3PCharLen('-АК'), l_FoundNum.AsWStr, True) then
            l3Delete(l_FoundNum, l_FoundNum.AsWStr.SLen - 3, 3);
          end;
         end;

         // если не указан номер, но есть дата и есть casecode текущего документа, то ищем по нему...
         if l3IsNil(l_FoundNum) and l3IsNil(l_FoundCasecode) and (not l3IsNil(aCaseCode)) and
            (FoundSources.Count = 1) then
         begin
          l_SNode := DictServer(CurrentFamily).Dict[da_dlSources].FindNodeByID(FoundSources.Items[0]);
          // убедиться, что документ, на который мы ссылаемся, принадлежит к документам судебной власти
          if (l_SNode <> nil) and (l3SearchByNode(f_CourtRootNode, l_SNode) <> nil) then
           f_DataSource.FilterByCasecode(Tl3PCharLen(aCaseCode.AsWStr));
         end;

         f_DataSource.FilterByDateNum(l_FoundDate, Tl3PCharLen(l3CStr2WStr(l_FoundNum)));
        end;

        if not l3IsNil(l_FoundCasecode) then
         f_DataSource.FilterByCasecode(Tl3PcharLen(l_FoundCasecode.AsWStr));

        // источники
        if FoundSources.Count > 0 then
         f_DataSource.FilterBySources(f_FoundSources);

        // оставляем только актуальные редакции
        f_DataSource.FilterByActualEditions;

        //l_DocStr := Copy(aText, l_DocStartPos + 1, l_DocLen); // отладочный код
        l_DocID := f_DataSource.ExecuteDocQuery;

        // если документ не определился или неоднозначно определился,
        // и у него есть какие-нибудь реквизиты, кроме типа документа,
        // и перед ним нет "далее",
        // то пробуем поискать в хистори (ранее найденных документах, на которые ссылки уже ставились)
        if ((l_DocID.rIntDocID = TDocID(cUndefDocID)) or (l_DocID.rIntDocID = TDocID(cUndefDocID))) and
           ((FoundSources.Count > 0) or (l_FoundDate > 0) or (not l3IsNil(l_FoundNum))) and
           (l_FurtherSeg.rOffs = 0) then
        begin
         l_HistoryIdx := f_DocHistory.FindBySubEntry(TddAutolinkDocEntry.Make(l_FoundType, l_FoundDate, Tl3PCharLen(l3CStr2WStr(l_FoundNum)),
             f_FoundSources, l_DocID));
         if l_HistoryIdx >= 0 then
          l_DocID := f_DocHistory.Entry[l_HistoryIdx].DocID;
        end;

        { выключим выдачу в лог, всё равно никто не читает (Маша С.)
        if l_DocID.rIntDocID = TDocID(cUndefDocID) then
         OutWarning(Format('неоднозначно определен закон (%s)', [l_DocStr]));
        if l_DocID.rIntDocID = 0 then
         OutWarning(Format('не найден закон (%s)', [l_DocStr]));
        }
       finally
        f_DataSource.CleanupDocQuery;
       end;
      end;
     end;
    end; // if найдены источники или тип входит в список типов, которые могут использоваться без источников
   end; // if достаточно данных для поиска
  end; // CheckSources

  if l_DocID.rIntDocID > 0 then // мы определились, что это за документ
  begin
   l3FillChar(l_ContemporalDoc, SizeOf(l_ContemporalDoc));
   l_LinkIsSet := False;
   if l_DocStartPos > 0 then
   begin
    f_EntryCollector.CollectEntries(PAnsiChar(aText), l_LeftMostPos, l_DocStartPos - 1, f_PossibleLinks);
    if f_PossibleLinks.Count > 0 then
    begin
     for I := 0 to f_PossibleLinks.Count - 1 do
     begin
      l_PLinkRec := PLinkPrimRec(f_PossibleLinks.ItemSlot(I));
      FindDocAndBlockToLink(l_DocID, l_PLinkRec^.rAddress, l_ContemporalDoc, l_DocForLink, l_BlockID);
      if l_BlockID >= 0 then
      begin
       aLinkProc(l_PLinkRec^.rStart, l_PLinkRec^.rEnd, l_DocForLink.rIntDocID, l_BlockID, '');
       l_LinkIsSet := True;
      end;
     end;
    end;
   end;
   if not l_LinkIsSet then
   begin
    aLinkProc(l_TheDocLinkPos.rOffs, l_TheDocLinkPos.rOffs + l_TheDocLinkPos.rLen, l_DocID.rIntDocID, 0, '');
   end;

   // добавляем документ в history
   if l_HistoryIdx < 0 then // мы нашли этот документ не в хистори
    // добавляем его туда
    f_DocHistory.AddEntry(TddAutolinkDocEntry.Make(l_FoundType, l_FoundDate, Tl3PCharLen(l3CStr2WStr(l_FoundNum)), f_FoundSources, l_DocID))
   else
    // передвигаем найденный в хистори документ на вершину списка
    f_DocHistory.MoveToTop(l_HistoryIdx);

   l_LeftMostPos := l_DocStartPos + l_DocLen + 1;
   l_LastFoundType := l_FoundType;
   f_LastFoundSources.Assign(f_FoundSources);
   l_LastChainEndPos := l_ChainEndPos;
  end; // if l_DocID > 0

  ResetChain;
 end;

 procedure WorkOutCodexAbbr(aAbbrSeg: Tm4Segment);
 var
  l_AbbrCStr: Il3CString;
  I : Integer;
  l_Idx: Integer;
 begin
  if IsReallySeparated(aText, aAbbrSeg.rOffs+1, aAbbrSeg.rOffs + aAbbrSeg.rLen) then
  begin
   if (l_LastFoundCodexInPara >= 0) and (l_FurtherSeg.rOffs > 0) and
      (aAbbrSeg.rWOffs = l_FurtherSeg.rWOffs + 1) then
   begin
    f_DefaultAbbr := Copy(aText, aAbbrSeg.rOffs+1, aAbbrSeg.rLen);
    f_DefaultAbbrCodex := l_LastFoundCodexInPara;
   end
   else
   begin
    l_AbbrCStr := l3CStr(l3PCharLen(PAnsiChar(aText) + aAbbrSeg.rOffs, aAbbrSeg.rLen));
    if l3Same(f_DefaultAbbr, l_AbbrCStr, True) then
     WorkOutCodex(f_DefaultAbbrCodex, aAbbrSeg.rOffs, aAbbrSeg.rLen)
    else
    begin
     f_FoundCodex.Clear;
     for I := 0 to f_CodexData.Count - 1 do
      if ICodexDataHolder(f_CodexData[I]).Abbreviations.FindData(l_AbbrCStr.AsWStr, l_Idx, l3_siCaseUnsensitive) then
       AddFoundCodex(I);
     WorkOutCodexPrim(aAbbrSeg.rOffs, aAbbrSeg.rLen, True);
    end;
   end;
  end;
  ResetChain;
 end;

 function StoppedByStopWord(const aCurSegment: Tm4Segment): Boolean;
 begin
  Result := (l_StopPos.rLen > 0) and (l_StopPos.rWOffs = aCurSegment.rWOffs - 1);
 end;

 function lFoundDictItem(aDictItemID : Tm4DictItemAddr; aSegment : Tm4Segment) : boolean;
 var
  l_ArbitraryDoc: IddAutolinkArbitraryDocEntry;
  //l_FoundStr: AnsiString;

  procedure lp_UpdateChain;
  begin
   // устанавливаем курсор на следующий предполагаемый элемент цепочки
   if l_ChainCursor < 0 then
    l_DocStartPos := aSegment.rOffs;
   l_DocLen := aSegment.rOffs + aSegment.rLen - l_DocStartPos;
   l_ChainCursor := aSegment.rWOffs + aSegment.rWLen;
   l_ChainEndPos := aSegment.rOffs + aSegment.rLen;
  end;

 begin
  Result := True;
  //l_FoundStr := Copy(aText, aSegment.rOffs + 1, aSegment.rLen); // отладочный код
  if (l_ChainCursor >= 0) and (aSegment.rWOffs <> l_ChainCursor) then
   WorkoutChain; // цепочка прервана, смотрим, чего мы уже накопили...
  // приехал первый или очередной элемент цепочки
  case aDictItemID.rDictionaryID of
   cDateDictID :
    begin
     if l_FoundDate <> 0 then
      WorkoutChain;
     l_FoundDate := aDictItemID.rID;
     l_DatePos := aSegment;
    end;

   cNumDictID :
    begin
     if not l3IsNil(l_FoundNum) then
      WorkoutChain;
     l_FoundNum := l3Upper(l3CStr(l3PcharLen(PAnsiChar(aText) + aSegment.rOffs, aSegment.rLen)));
     l_NumPos := aSegment;
    end;

   cLawcaseNumDictID :
    begin
     if not l3IsNil(l_FoundCasecode) then
      WorkoutChain;
     l_FoundCasecode := NormalizeCasecode(l3CStr(l3PcharLen(PAnsiChar(aText) + aSegment.rOffs, aSegment.rLen)));
     //l_NumPos := aSegment; // пока непонятно, нужна ли нам позиция кейскода
    end;

   cGostDictID :
    begin
     // это - совсем отдельный тип документа, поэтому и обрабатывать его надо по-особому
     // для начала, обработаем уже накопленное (если что-то было накоплено)
     WorkoutChain;
     if f_GostType > 0 then
     begin
      l_FoundType := f_GostType; // тип строго определён
      l_TypePos := aSegment; // ссылка будет ставиться на всю строку
      l_FoundNum := l3Upper(l3CStr(l3PcharLen(PAnsiChar(aText) + aSegment.rOffs, aSegment.rLen))); // и она же используется как номер документа
      lp_UpdateChain;
      WorkoutChain; // дальше там ничего нет, обрабатываем цепочку
     end;
    end;

   cShortNameDictID :
    if l_FoundShort.rIntDocID = 0 then
    begin
     l_ArbitraryDoc := f_ArbitraryDocs.Items[aDictItemID.rID];
     // Если список разрешённых типов пуст и никакого типа не найдено ИЛИ найденный тип в списке разрешённых
     if ((l_ArbitraryDoc.TypesList = nil) and (l_FoundType < 0)) or
        ((l_ArbitraryDoc.TypesList <> nil) and (l_ArbitraryDoc.TypesList.IndexOf(l_FoundType) >= 0)) then
     begin
      l_FoundShort := ddFillALDocRecFromExtDocID(l_ArbitraryDoc.DocID);
      lp_UpdateChain;
      // если тип не определён, то надо скорректировать сегмент, на который будет ставиться ссылка
      if (l_FoundType < 0) then
       l_TypePos := aSegment;
     end;
     // если нашли короткое имя, то дальше будет какой-то мусор (даже если это дата или номер)
     // поэтому завершаем цепочку
     WorkoutChain;
     Exit;
    end;

   cSkippiesDictID     : ; // пропускаем, не разрывая цепочку
   //cCodexKeywordsDictID: ; // пропускаем, не разрывая цепочку -- наверное, так не надо делать

   cStopWordsDictID:
    begin
     // это стоп-слово = запоминаем позицию и рвём цепочку
     WorkoutChain;
     l_StopPos := aSegment;
     Exit;
    end;

   cCodexDictID    :
    begin
     lp_UpdateChain;
     WorkOutCodex(aDictItemID.rID, aSegment.rOffs, aSegment.rLen);
    end;
   cCodexAbbrDictID:
    begin
     lp_UpdateChain;
     WorkOutCodexAbbr(aSegment);
    end;
   cCodexSpecials  :
    case aDictItemID.rID of
     cs_Further:
      begin
       lp_UpdateChain;
       WorkoutChain;
       l_FurtherSeg := aSegment;
      end;
    end;
  else
   case TdaDictionaryType(aDictItemID.rDictionaryID) of
     da_dlSources: FoundSources.Add(aDictItemID.rID);
     da_dlTypes  :
      begin
       if not StoppedByStopWord(aSegment) then
       begin
        if l_FoundType >= 0 then //
         WorkoutChain;
        l_FoundDate := 0;

        if aDictItemID.rID = f_CodexType then
        begin
         if (l_FurtherSeg.rOffs > 0) and (aSegment.rWOffs = l_FurtherSeg.rWOffs + 1) then
          f_DefaultCodex := f_LastFoundCodex
         else
          if f_DefaultCodex >= 0 then
           WorkoutCodex(f_DefaultCodex, aSegment.rOffs, aSegment.rLen)
          else
           if l_LastFoundCodexInPara >= 0 then
            WorkoutCodex(l_LastFoundCodexInPara, aSegment.rOffs, aSegment.rLen);
        end
        else
        begin
         l_FoundType := aDictItemID.rID;
         l_TypePos := aSegment;
        end;
       end
       else // if not StoppedByStopWord
       begin
        // тип предварён стоп-словом = невалиден
        WorkoutChain;
        Exit;
       end;
      end;
   else
    // какой=то левый элемент, проверяем и сбрасываем цепочку
    WorkoutChain;
    Exit;
   end;
  end;
  lp_UpdateChain;
 end;

begin
 ResetChain;
 l_LastFoundType := -1;
 l_TextLen := Length(aText);
 l_LeftMostPos := 0;
 l_LastFoundCodexInPara := -1;
 l_LastChainEndPos := -1;
 // собственно, парсим строку
 lFDIProcStub := L2FoundDictItemProc(@lFoundDictItem);
 try
  DoParsePhrase(l3PCharLen(aText), DictServer(CurrentFamily).DictScanner, lFDIProcStub);
  WorkoutChain;
 finally
  FreeFoundDictItemProc(lFDIProcStub);
 end;
end;

procedure TddGeneralLawsLinkFinder.Init;
begin
 f_DataSource := TddDualAutolinkDataSource.Create(f_OnError); {TddCacheAutolinkDataSource.Create;} {TddDBAutolinkDataSource.Create;}
end;

procedure TddGeneralLawsLinkFinder.LoadSkippies;
begin
 DictServer(CurrentFamily).DictScanner.AddToDict(l3PCharLen('РФ'), 0, cSkippiesDictID);
 DictServer(CurrentFamily).DictScanner.AddToDict(l3PCharLen('Российская Федерация'), 0, cSkippiesDictID);
 DictServer(CurrentFamily).DictScanner.AddToDict(l3PCharLen('и'), 0, cSkippiesDictID);
 DictServer(CurrentFamily).DictScanner.AddComplete;
end;

procedure TddGeneralLawsLinkFinder.LoadStopWords;
begin
 DictServer(CurrentFamily).DictScanner.AddToDict(l3PCharLen('улица'), 0, cStopWordsDictID);
 DictServer(CurrentFamily).DictScanner.AddToDict(l3PCharLen('ул'), 0, cStopWordsDictID);
 DictServer(CurrentFamily).DictScanner.AddComplete;
end;

function TddGeneralLawsLinkFinder.pm_GetFoundCodex(aIndex: Integer): PFoundCodexRec;
begin
 Result := PFoundCodexRec(f_FoundCodex.ItemSlot(aIndex));
end;

function TddGeneralLawsLinkFinder.pm_GetFoundSources: Tl3LongintList;
begin
 if f_FoundSources = nil then
  f_FoundSources := Tl3LongintList.Make;
 Result := f_FoundSources;
end;

function TddGeneralLawsLinkFinder.pm_GetSPChainConnector: Tl3RegularSearch;
begin
 if f_SPChainConnector = nil then
 begin
  f_SPChainConnector := Tl3RegularSearch.Create;
  f_SPChainConnector.IgnoreCase := True;
  f_SPChainConnector.SearchPattern := '^\s*[\,\и]\s*$';
 end;
 Result := f_SPChainConnector;
end;

function TddGeneralLawsLinkFinder.pm_GetSPRusFed: Tl3RegularSearch;
begin
 if f_SPRusFed = nil then
 begin
  f_SPRusFed := Tl3RegularSearch.Create;
  f_SPRusFed.IgnoreCase := True;
  f_SPRusFed.SearchPattern := '^\s+' + sp_RusFed;
 end;
 Result := f_SPRusFed;
end;

procedure TddGeneralLawsLinkFinder.pm_SetOnError(const Value: TddErrorEvent);
begin
 inherited pm_SetOnError(Value);
 if f_DataSource <> nil then
  f_DataSource.OnError := Value;
end;

constructor TddGeneralLawsLinkFinderBox.Create;
begin
 inherited Create;
 Il3ChangeNotifier(GlobalHtServer).Subscribe(Il3ItemNotifyRecipient(Self));
end;

procedure TddGeneralLawsLinkFinderBox.Cleanup;
begin
 KillFinder;
 inherited;
end;

function TddGeneralLawsLinkFinderBox.GetFinder(aAllowedSources: Tl3LongintList; const aDataFileName: AnsiString):
 TddGeneralLawsLinkFinder;
begin
 if not Assigned(f_Finder) or not l3IsIdenticalLists(aAllowedSources, f_Finder.f_AllowedSources) or
    not AnsiSameText(aDataFileName, f_Finder.f_DataFileName) then
 begin
  KillFinder;
  f_Finder := TddGeneralLawsLinkFinder.Create(aAllowedSources, aDataFileName);
 end;
 Result := f_Finder;
end;

procedure TddGeneralLawsLinkFinderBox.KillFinder;
begin
 FreeAndNil(f_Finder);
end;

procedure TddGeneralLawsLinkFinderBox.Notify(const aNotifier: Il3ChangeNotifier; aOperation: Integer; aIndex: Integer);
begin
 if aOperation = sni_Destroy then
  KillFinder;
end;

function ddGetGeneralLawsLinkFinder(aAllowedSources: Tl3LongintList; const aDataFileName: AnsiString): TddCustomLinkFinder;
begin
 if g_GeneralLawsLinkFinderBox = nil then
  g_GeneralLawsLinkFinderBox := TddGeneralLawsLinkFinderBox.Create;
 Result := g_GeneralLawsLinkFinderBox.GetFinder(aAllowedSources, aDataFileName);
end;

function ddGetGeneralLawsLinkFinderDef: TddCustomLinkFinder;
begin
 Result := ddGetGeneralLawsLinkFinder(nil,  ConcatDirName(GlobalHtServer.Family[CurrentFamily].Path, sAutolinkDataFN))
end;

initialization
 {!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\DT\ddGeneralLawsLinkFinder.pas initialization enter'); {$EndIf}
 {!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\DT\ddGeneralLawsLinkFinder.pas initialization leave'); {$EndIf}
finalization
 FreeAndNil(g_GeneralLawsLinkFinderBox);
end.