unit ddAutolinkDataLoader;

{ $Id: ddAutolinkDataLoader.pas,v 1.2 2016/07/18 10:49:49 fireton Exp $ }

interface
uses
  dt_Types,
  ddAutolinkArbitraryDocList,
  ddCustomAutolinkDataLoader,
  l3InterfaceList, l3LongintList;

type
 TALMiscSettingsRec = record
  rConstitutionDocID: TDocID;
 end;

type
 TddAutolinkDataLoader = class(TddCustomAutolinkDataLoader)
 private
  f_ArbitraryDocList: TddAutolinkArbitraryDocList;
  f_Misc: TALMiscSettingsRec;
 protected
  procedure LoadCodexes; override;
  procedure LoadFedLaws; override;
  procedure LoadArbitrary(aIsFedlaw: Boolean = False);
  procedure LoadLoneTypes; override;
  procedure LoadTypeSyns; override;
  procedure LoadMisc;
 protected
  procedure DispatchSection; override;
 public
  constructor Create(const aFileName: string; aCodexData: Tl3InterfaceList; aLoneTypeList: Tl3LongintList;
                     aArbitraryDocList: TddAutolinkArbitraryDocList);
  property Misc: TALMiscSettingsRec read f_Misc write f_Misc;
 end;

implementation
uses
 SysUtils,
 l3Interfaces,
 l3Types,
 l3Base,
 l3String,
 daTypes,
 daSchemeConsts,
 daInterfaces,
 dtIntf,
 dt_DictIntf,
 dt_Dict,
 dt_Query,
 dt_SrchQueries,
 dt_Doc,
 dt_LinkServ,
 ddAutolinkConst,
 ddAutolinkInterfaces,
 ddCodexDataHolder,
 ddAutolinkArbitraryDocEntry;

constructor TddAutolinkDataLoader.Create(const aFileName: string; aCodexData: Tl3InterfaceList;
    aLoneTypeList: Tl3LongintList; aArbitraryDocList: TddAutolinkArbitraryDocList);
begin
 inherited Create(aFileName, aCodexData, aLoneTypeList);
 f_ArbitraryDocList := aArbitraryDocList;
end;

procedure TddAutolinkDataLoader.DispatchSection;
begin
 if l3Same(SectName, 'arbitrary', True) then
  LoadArbitrary
 else
 if l3Same(SectName, 'misc', True) then
  LoadMisc
 else
  inherited;
end;

procedure TddAutolinkDataLoader.LoadCodexes;
var
 l_CDocID: TDocID;
 l_Keywords: string;

 function AddOnePhrase(const aStr: Tl3PCharLen; IsLast: Bool): Bool;
 begin
  Result := True;
  DictServer(CurrentFamily).DictScanner.AddToDict(aStr, f_CodexData.Count-1, cCodexDictID);
 end;

 function AddOneKeyword(const aStr: Tl3PCharLen; IsLast: Bool): Bool;
 begin
  Result := True;
  DictServer(CurrentFamily).DictScanner.AddToDict(aStr, f_CodexData.Count-1, cCodexKeywordsDictID);
 end;

 function AddOneAbbr(const aStr: Tl3PCharLen; IsLast: Bool): Bool;
 var
  l_Str: Tl3WString;
 begin
  Result := True;
  l_Str := l3Trim(aStr);
  if l3IsNil(l_Str) then
   Exit;
  ICodexDataHolder(f_CodexData[f_CodexData.Count-1]).Abbreviations.Add(l_Str);
  DictServer(CurrentFamily).DictScanner.AddToDict(l_Str, cDummyID, cCodexAbbrDictID);
 end;

begin
 f_CodexData.Clear;
 while NextLine do
 begin
  if ValuesCount >= 3 then
  begin
   l_CDocID := l3StrToIntDef(ValuesW[ctc_DocumentID], cUndefDocID);
   Assert((l_CDocID <> cUndefDocID) and (l_CDocID <> 0), '�������� ����� ��������� '+ValuesW[ctc_DocumentID].S);
   if (l_CDocID <> cUndefDocID) and (l_CDocID <> 0) then
   begin
    l_Keywords := Trim(l3PCharLen2String(ValuesW[ctc_Keywords]));
    f_CodexData.Add(TCodexDataHolder.Make(l_CDocID));
    l3ParseWordsExF(ValuesW[ctc_CodexName], l3L2WA(@AddOnePhrase), ['|']);
    l3ParseWordsExF(ValuesW[ctc_Abbreviation], l3L2WA(@AddOneAbbr), [',']);
    if ValuesCount > 3 then
     l3ParseWordsExF(ValuesW[ctc_Keywords], l3L2WA(@AddOneKeyword), [',']);
   end // (l_CDocID <> cUndefDocID) and (l_CDocID <> 0)
   else
    l3System.Msg2Log('�������� ����� ��������� %s', [ValuesW[ctc_DocumentID].S]);
  end;
 end; // while
 DictServer(CurrentFamily).DictScanner.AddToDict(l3PCharLen('��������� ������'), cDummyID, cCodexDictID);
 DictServer(CurrentFamily).DictScanner.AddToDict(l3PCharLen('�����'), cs_Further, cCodexSpecials);
 DictServer(CurrentFamily).DictScanner.AddComplete;
end;

procedure TddAutolinkDataLoader.LoadArbitrary(aIsFedlaw: Boolean = False);
var
 I: Integer;
 l_Q: TdtQuery;
 l_SC: ISabCursor;
 l_DocID: TDocID;
 l_AQ: TdtCustomQuery;
 l_TypeList: Tl3LongintList;
 l_C: Tl3Char;
 l_WStr: Tl3WString;
 l_CurDoc: IddAutolinkArbitraryDocEntry;

 function AddOnePhrase(const aStr: Tl3PCharLen; IsLast: Bool): Bool;
 begin
  Result := True;
  DictServer(CurrentFamily).DictScanner.AddToDict(aStr, f_ArbitraryDocList.Count-1, cShortNameDictID);
 end;

 function AddOneType(const aStr: Tl3PCharLen; IsLast: Bool): Bool;
 var
  l_ID: LongWord;
 begin
  Result := True;
  l_ID := DictServer(CurrentFamily).Dict[da_dlTypes].FindIDByFullPath(l3Trim(aStr));
  if l_ID <> cUndefDictID then
   l_TypeList.Add(l_ID);
 end;

begin
 l_TypeList := nil;
 try
  // ��������� ������� �������
  if aIsFedLaw then
  begin
   l_TypeList := Tl3LongintList.MakeSorted;
   AddOneType(l3PCharLen('�����'), False);
   AddOneType(l3PCharLen('����������� �����'), False);
   AddOneType(l3PCharLen('����������� ��������������� �����'), False);
   if l_TypeList.Count = 0 then
    Exit;
  end;

  while NextLine do
   if ValuesCount >= 2 then
   begin
    l_DocID := 0;
    if ValuesCount > 2 then
     l_DocID := l3StrToIntDef(ValuesW[2], 0);
    if l_DocID = 0 then
    begin
     l_Q := SQText2Query(l3PCharLen2String(ValuesW[0]));
     try
      if l_Q <> nil then
      begin
       l_AQ := TdtActiveQuery.Create([asActive]);
       SQAndF(l_Q, l_AQ);
       if l_Q.FoundList.Count = 1 then
       begin
        l_SC := l_Q.FoundList.MakeSabCursor([fId_Fld], cmForward);
        l_DocID := LinkServer(CurrentFamily).Renum.GetExtDocID(PDocID(l_SC.GetItem(0))^);
        Values[2] := l3CStr(IntToStr(l_DocID));
        l_SC := nil;
       end;
      end;
     finally
      FreeAndNil(l_Q);
     end;
    end;
    if l_DocID <> 0 then
    begin
     l_CurDoc := TddAutolinkArbitraryDocEntry.Make(l_DocID, l_TypeList);
     f_ArbitraryDocList.Add(l_CurDoc);
     l3ParseWordsExF(ValuesW[1], l3L2WA(@AddOnePhrase), ['|']);
    end;
   end
   else
   begin
    if (ValuesCount = 1) and (not aIsFedLaw) then
    begin
     l_C := l3CharEx(ValuesW[0], 0);
     if l_C.rAC = '#' then
     begin
      l_WStr := l3Copy(ValuesW[0], 1);
      FreeAndNil(l_TypeList);
      l_TypeList := Tl3LongintList.MakeSorted;
      l3ParseWordsExF(l_WStr, l3L2WA(@AddOneType), [',']);
      if l_TypeList.Count = 0 then
       FreeAndNil(l_TypeList);
     end;
    end;
   end;
 finally
  FreeAndNil(l_TypeList);
 end;
 DictServer(CurrentFamily).DictScanner.AddComplete;
end;

procedure TddAutolinkDataLoader.LoadFedLaws;
begin
 LoadArbitrary(True);
end;

procedure TddAutolinkDataLoader.LoadLoneTypes;
var
 l_ID: TDictID;
begin
 while NextLine do
  if ValuesCount > 0 then
  begin
   l_ID := DictServer(CurrentFamily).Dict[da_dlTypes].FindIDByFullPath(ValuesW[0]);
   if l_ID <> cUndefDictID then
    f_LoneTypesList.Add(l_ID);
  end;
end;

procedure TddAutolinkDataLoader.LoadMisc;
begin
 while NextLine do
  if ValuesCount = 2 then
  begin
   if l3Same(Values[0], 'ConstitutionDocID', True) then
    f_Misc.rConstitutionDocID := l3StrToIntDef(ValuesW[1], 0);
  end;
end;

procedure TddAutolinkDataLoader.LoadTypeSyns;
var
 l_ID: TDictID;

 function AddOnePhrase(const aStr: Tl3PCharLen; IsLast: Bool): Bool;
 begin
  Result := True;
  DictServer(CurrentFamily).DictScanner.AddToDict(aStr, l_ID, Ord(da_dlTypes));
 end;

begin
 while NextLine do
  if ValuesCount = 2 then
  begin
   l_ID := DictServer(CurrentFamily).Dict[da_dlTypes].FindIDByFullPath(ValuesW[0]);
   if l_ID <> cUndefDictID then
    l3ParseWordsExF(ValuesW[1], l3L2WA(@AddOnePhrase), ['|']);
  end;
 DictServer(CurrentFamily).DictScanner.AddComplete;
end;

end.