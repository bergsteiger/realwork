unit dd_lcXMLReader2;
{$I ddDefine.inc}
{ $Id: dd_lcXMLReader2.pas,v 1.17 2014/08/05 06:29:42 lukyanets Exp $ }

interface
uses
 Classes,

 l3ProtoObject,
 l3StringList,
 l3InterfaceList,
 l3InterfacedStringList,
 l3Interfaces,
 l3Date,

 k2Interfaces,
 k2Prim,
 k2TagGen,
 k2Reader,

 ddXMLParser,

 DT_Types;

type
 TlcXMLDataHandler = (dhStartTag, dhEndTag, dhCharData, dhAttribute);

 IlcParticipantHolder = interface
  ['{B1601E55-962B-4F32-B39A-4C7196EC66BB}']
  function pm_GetName: Il3CString;
  function pm_GetTheType: TlcParticipantType;
  procedure pm_SetName(const Value: Il3CString);
  procedure pm_SetTheType(const Value: TlcParticipantType);
  property Name: Il3CString read pm_GetName write pm_SetName;
  property TheType: TlcParticipantType read pm_GetTheType write pm_SetTheType;
 end;

 TlcParticipantHolder = class(Tl3ProtoObject, IlcParticipantHolder)
 private
  f_Name: Il3CString;
  f_Type: TlcParticipantType;
 private
  function pm_GetName: Il3CString;
  function pm_GetTheType: TlcParticipantType;
  procedure pm_SetName(const Value: Il3CString);
  procedure pm_SetTheType(const Value: TlcParticipantType);
 public
  class function Make: IlcParticipantHolder;
 end;

 TlcBaseXMLReader = class(Tl3ProtoObject)
 private
  f_Generator: Pointer;
  f_Parser: TddXMLParser;
  function pm_GetGenerator: Ik2TagGenerator;
  procedure pm_SetParser(const Value: TddXMLParser);
 protected
  f_Blob: Il3CString;
  f_DocDate: TStDate;
  f_DocNum: Il3CString;
  f_LawCaseNum: Il3CString;
  f_Handlers: set of TlcXMLDataHandler;
  procedure ClearBlob;
  procedure GenerateSource(const aStr: Il3CString);
  procedure FlushBlob;
  procedure ClearDateNums;
  procedure DoOnStartTag(const aStr: Il3CString); virtual;
  procedure DoOnEndTag(const aStr: Il3CString); virtual;
  procedure DoOnData(const aStr: Il3CString); virtual;
  procedure EndDocument;
  procedure FlushDateNums;
  procedure GenerateType(const aStr: Il3CString);
  procedure StartDocument;
  property Parser: TddXMLParser read f_Parser write pm_SetParser;
 public
  constructor Create(const aGenerator: Ik2TagGenerator);
  property Generator: Ik2TagGenerator read pm_GetGenerator;
 end;

 TlcPravoXMLReader = class(TlcBaseXMLReader)
 protected
  procedure DoOnData(const aStr: Il3CString); override;
  procedure DoOnEndTag(const aStr: Il3CString); override;
  procedure DoOnStartTag(const aStr: Il3CString); override;
 end;

 TlcKodeksCaseDocType = (cdtAppealDocs, cdtArisedDocs);

 TlcKodeksXMLReader = class(TlcBaseXMLReader)
 private
  f_CommonDocNum: Il3CString;
  f_InstanceNums: Tl3StringList;
  f_Participants: Tl3InterfaceList;
  f_NewParticipant: IlcParticipantHolder;
  f_CurrentCaseDocType: TlcKodeksCaseDocType;
  procedure ClearAllData;
  procedure FlushParticipants;
 protected
  procedure Cleanup; override;
  procedure DoOnData(const aStr: Il3CString); override;
  procedure DoOnEndTag(const aStr: Il3CString); override;
  procedure DoOnStartTag(const aStr: Il3CString); override;
 public
  constructor Create(const aGenerator: Ik2TagGenerator);
 end;

 IlcKrokDocImageObj = interface
  ['{2BABE4D8-FBC3-441D-90D9-25B9E47FBD22}']
  function pm_GetData: Il3CString;
  function pm_GetDocID: Il3CString;
  procedure pm_SetData(const Value: Il3CString);
  procedure pm_SetDocID(const Value: Il3CString);
  property Data: Il3CString read pm_GetData write pm_SetData;
  property DocID: Il3CString read pm_GetDocID write pm_SetDocID;
 end;

 IlcKrokCaseDocObj = interface
  ['{E6C105DF-3D9F-49EC-AE07-CD048B844455}']
  function pm_GetDate: TStDate;
  function pm_GetTypeID: Il3CString;
  procedure pm_SetDate(const Value: TStDate);
  procedure pm_SetTypeID(const Value: Il3CString);
  property Date: TStDate read pm_GetDate write pm_SetDate;
  property TypeID: Il3CString read pm_GetTypeID write pm_SetTypeID;
 end;

 IlcKrokParticipantObj = interface
  ['{1FF85794-7BDF-49E7-95F4-4685E730898B}']
  function pm_GetName: Il3CString;
  function pm_GetParticipantType: TlcParticipantType;
  procedure pm_SetName(const Value: Il3CString);
  procedure pm_SetParticipantType(const Value: TlcParticipantType);
  property Name: Il3CString read pm_GetName write pm_SetName;
  property ParticipantType: TlcParticipantType read pm_GetParticipantType write pm_SetParticipantType;
 end;

 TlcKrokDocImageObj = class(Tl3ProtoObject, IlcKrokDocImageObj)
 private
  f_Data: Il3CString;
  f_ID  : Il3CString;
  function pm_GetData: Il3CString;
  function pm_GetDocID: Il3CString;
  procedure pm_SetData(const Value: Il3CString);
  procedure pm_SetDocID(const Value: Il3CString);
 protected
 public
  class function Make: IlcKrokDocImageObj;
 end;

 TlcKrokCaseDocObj = class(Tl3ProtoObject, IlcKrokCaseDocObj)
 private
  f_Date: TStDate;
  f_TypeID: Il3CString;
  function pm_GetDate: TStDate;
  function pm_GetTypeID: Il3CString;
  procedure pm_SetDate(const Value: TStDate);
  procedure pm_SetTypeID(const Value: Il3CString);
 public
  class function Make: IlcKrokCaseDocObj;
 end;

 TlcKrokParticipantObj = class(Tl3ProtoObject, IlcKrokParticipantObj)
 private
  f_Name: Il3CString;
  f_ParticipantType: TlcParticipantType;
  function pm_GetName: Il3CString;
  function pm_GetParticipantType: TlcParticipantType;
  procedure pm_SetName(const Value: Il3CString);
  procedure pm_SetParticipantType(const Value: TlcParticipantType);
 public
  class function Make: IlcKrokParticipantObj;
 end;

 TlcKrokXMLReader = class(TlcBaseXMLReader)
 private
  f_CaseDocs: Tl3InterfacedStringList;
  f_CurCaseDoc: IlcKrokCaseDocObj;
  f_CurDocImg: IlcKrokDocImageObj;
  f_CurSubjectName: Il3CString;
  f_CurParticipant: IlcKrokParticipantObj;
  f_CurObjOID: Il3CString;
  f_DocImages: Tl3InterfacedStringList;
  f_Dictionary: Tl3InterfacedStringList;
  f_Participants: Tl3InterfacedStringList;
  f_Source: Il3CString;
  f_Subjects: Tl3InterfacedStringList;
  function FindDocImage(const aDocOID: Il3CString): IlcKrokDocImageObj;
  procedure FlushParticipants;
  procedure GenerateDocuments;
  function GetFromDict(aKey: Il3CString): Il3CString;
  procedure LoadDictionary(const aFileName: AnsiString);
  procedure MatchParticipantNames;
  function pm_GetDictionary(anID: Tl3WString): Il3CString;
 protected
  procedure Cleanup; override;
  procedure DoOnData(const aStr: Il3CString); override;
  procedure DoOnEndTag(const aStr: Il3CString); override;
  procedure DoOnStartTag(const aStr: Il3CString); override;
  property Dictionary[anID: Tl3WString]: Il3CString read pm_GetDictionary;
 public
  constructor Create(const aGenerator: Ik2TagGenerator; const aDictFileName: AnsiString);
 end;

 TlcSimpleXMLReader = class(TlcBaseXMLReader)
 private
  f_DateNumsIsFlushed: Boolean;
  procedure CheckAndFlushDateNums;
 protected
  procedure DoOnData(const aStr: Il3CString); override;
  procedure DoOnEndTag(const aStr: Il3CString); override;
  procedure DoOnStartTag(const aStr: Il3CString); override;
 end;

 TlcXMLStreamReader = class(Tk2CustomFileReader)
 private
  f_CurReader: TlcBaseXMLReader;
  f_KodeksReader: TlcKodeksXMLReader;
  f_PravoReader : TlcPravoXMLReader;
  f_KrokReader  : TlcKrokXMLReader;
  f_SimpleReader: TlcSimpleXMLReader;
  f_Parser: TddXMLParser;
  procedure DoOnStartTag(const aStr: Il3CString);
 protected
  procedure Cleanup; override;
 public
  constructor Create(const aKrokDictFileName: AnsiString; anOwner: Tk2TagGeneratorOwner = nil); reintroduce;
  class function SetTo(var theGenerator: Tk2TagGenerator; const aKrokDictFileName: AnsiString): Pointer; overload;
  procedure Read; override;
 end;

implementation
uses
 SysUtils,
 l3Base,
 l3Const,
 l3Stream,
 l3Filer,
 l3String,
 l3StringListPrim,
 l3Base64,

 k2Tags,

 Participant_Const,
 DictItem_Const,
 Document_Const,
 NumAndDate_Const,

 ddParticipantsUtils
 ;


constructor TlcBaseXMLReader.Create(const aGenerator: Ik2TagGenerator);
begin
 inherited Create;
 f_Generator := Pointer(aGenerator); // чтобы не было циклических ссылок

 // это нужно, чтобы не задействовать ненужные хэндлеры у парсера и не распредел€ть пам€ть под строки,
 // которые никому не нужны
 f_Handlers := [dhStartTag, dhEndTag, dhCharData];
 
end;

procedure TlcBaseXMLReader.ClearBlob;
begin
 f_Blob := nil;
end;

procedure TlcBaseXMLReader.GenerateSource(const aStr: Il3CString);
begin
 Generator.StartTag(k2_tiSources);
 try
  Generator.StartChild(k2_typDictItem);
  try
   Generator.AddStringAtom(k2_tiName, aStr.AsWStr);
  finally
   Generator.Finish;
  end;
 finally
  Generator.Finish;
 end;
end;

procedure TlcBaseXMLReader.ClearDateNums;
begin
 f_DocDate := 0;
 f_DocNum  := nil;
 f_LawCaseNum := nil;
end;

procedure TlcBaseXMLReader.DoOnData(const aStr: Il3CString);
begin
end;

procedure TlcBaseXMLReader.DoOnEndTag(const aStr: Il3CString);
begin
end;

procedure TlcBaseXMLReader.DoOnStartTag(const aStr: Il3CString);
begin
end;

procedure TlcBaseXMLReader.EndDocument;
begin
 Generator.Finish;
end;

procedure TlcBaseXMLReader.FlushDateNums;
begin
 if (f_DocDate <> 0) or (not l3IsNil(f_DocNum)) or (not l3IsNil(f_LawCaseNum)) then
 begin
  Generator.StartTag(k2_tiNumAndDates);
  try
   if not l3IsNil(f_LawCaseNum) then
   begin
    Generator.StartChild(k2_typNumAndDate);
    try
     Generator.AddIntegerAtom(k2_tiType, Ord(dnLawCaseNum));
     Generator.AddStringAtom(k2_tiNumber, f_LawCaseNum.AsWStr);
    finally
     Generator.Finish;
    end;
   end;

   if (f_DocDate <> 0) or (not l3IsNil(f_DocNum)) then
   begin
    Generator.StartChild(k2_typNumAndDate);
    try
     Generator.AddIntegerAtom(k2_tiType, Ord(dnPublish));
     if f_DocDate <> 0 then
      Generator.AddIntegerAtom(k2_tiStart, f_DocDate);
     if not l3IsNil(f_DocNum) then
      Generator.AddStringAtom(k2_tiNumber, f_DocNum.AsWStr);
    finally
     Generator.Finish;
    end;
   end;
  finally
   Generator.Finish;
  end;
 end;
end;

procedure TlcBaseXMLReader.FlushBlob;
var
 l_Stream: Tl3Base64StringStream;
begin
 if f_Blob <> nil then
 begin
  l_Stream := Tl3Base64StringStream.Create(f_Blob);
  try
   Generator.AddStreamAtom(k2_tiData, l_Stream);
  finally
   FreeAndNil(l_Stream);
  end;
 end;
end;

procedure TlcBaseXMLReader.GenerateType(const aStr: Il3CString);
begin
 Generator.StartTag(k2_tiTypes);
 try
  Generator.StartChild(k2_typDictItem);
  try
   Generator.AddStringAtom(k2_tiName, aStr.AsWStr);
  finally
   Generator.Finish;
  end;
 finally
  Generator.Finish;
 end;
end;

function TlcBaseXMLReader.pm_GetGenerator: Ik2TagGenerator;
begin
 Result := Ik2TagGenerator(f_Generator);
end;

procedure TlcBaseXMLReader.pm_SetParser(const Value: TddXMLParser);
begin
 if f_Parser <> nil then
 begin
  f_Parser.OnData := nil;
  f_Parser.OnStartTag := nil;
  f_Parser.OnEndTag := nil;
  f_Parser.NeedAttributes := False;
 end;
 f_Parser := Value;
 if f_Parser <> nil then
 begin
  if dhStartTag in f_Handlers then
   f_Parser.OnStartTag := DoOnStartTag;
  if dhEndTag in f_Handlers then
   f_Parser.OnEndTag := DoOnEndTag;
  if dhCharData in f_Handlers then
   f_Parser.OnData := DoOnData;
  if dhAttribute in f_Handlers then
   f_Parser.NeedAttributes := True;
 end;
end;

procedure TlcBaseXMLReader.StartDocument;
begin
 Generator.StartChild(k2_typDocument);
end;

procedure TlcPravoXMLReader.DoOnData(const aStr: Il3CString);
var
 l_Tmp: AnsiString;
begin
 if l3Same(Parser.CurrentTag, 'Name') and l3Same(Parser.Tags[1], 'Participant') then
  Generator.AddStringAtom(k2_tiName, aStr.AsWStr)
 else
 if l3Same(Parser.CurrentTag, 'Type') and l3Same(Parser.Tags[1], 'Participant') then
  Generator.AddIntegerAtom(k2_tiType, Ord(StrToParticipantType(aStr)))
 else
 if l3Same(Parser.CurrentTag, 'Type') and l3Same(Parser.Tags[1], 'Document') then
  GenerateType(aStr)
 else
 if l3Same(Parser.CurrentTag, 'InstanceNumber') then
  f_DocNum := aStr
 else
 if l3Same(Parser.CurrentTag, 'CaseNumber') then
  f_LawCaseNum := aStr
 else
 if l3Same(Parser.CurrentTag, 'DocDate') then
 begin
  l_Tmp := l3Str(l3Copy(aStr.AsWStr, 0, 10));
  f_DocDate := DateTimeTostDate(StrToDateFmt('yyyy-mm-dd', l_Tmp));
 end
 else
 if l3Same(Parser.CurrentTag, 'CourtName') then
  GenerateSource(aStr)
 else
 if l3Same(Parser.CurrentTag, 'blob') or l3Same(Parser.CurrentTag, 'File') then
  f_Blob := aStr;
end;

procedure TlcPravoXMLReader.DoOnEndTag(const aStr: Il3CString);
begin
 if l3Same(aStr, 'Document') then
 begin
  FlushDateNums;
  FlushBlob;
  EndDocument;
 end
 else
 if l3Same(aStr, 'Participants') or l3Same(aStr, 'Participant') then
  Generator.Finish;
end;

procedure TlcPravoXMLReader.DoOnStartTag(const aStr: Il3CString);
begin
 if l3Same(aStr, 'Document') then
 begin
  StartDocument;
  ClearDateNums;
  ClearBlob;
 end
 else
 // Participants
 if l3Same(aStr, 'Participants') then
  Generator.StartTag(k2_tiCaseDocParticipants)
 else
 if l3Same(aStr, 'Participant') then
  Generator.StartChild(k2_typParticipant);
end;

constructor TlcKodeksXMLReader.Create(const aGenerator: Ik2TagGenerator);
begin
 inherited Create(aGenerator);
 f_InstanceNums := Tl3StringList.Make;
 f_Participants := Tl3InterfaceList.Make;
end;

procedure TlcKodeksXMLReader.Cleanup;
begin
 FreeAndNil(f_InstanceNums);
 FreeAndNil(f_Participants);
 inherited;
end;

procedure TlcKodeksXMLReader.ClearAllData;
begin
 f_InstanceNums.Clear;
 f_Participants.Clear;
 f_CommonDocNum := nil;
end;

procedure TlcKodeksXMLReader.DoOnData(const aStr: Il3CString);
var
 l_Idx: Integer;
begin
 if l3Same(Parser.CurrentTag, 'CaseNum') and (Parser.Tags[1] <> nil) then
 begin
  if l3Starts('Instance', Parser.Tags[1].AsWStr) then
   f_InstanceNums.Add(aStr);
 end
 else
 if l3Same(Parser.CurrentTag, 'Name') and l3Same(Parser.Tags[1], 'ParticipantCategory') then
  f_NewParticipant.TheType := StrToParticipantType(aStr)
 else
 if l3Same(Parser.CurrentTag, 'SubjectName') and l3Same(Parser.Tags[1], 'Participant') then
  f_NewParticipant.Name := aStr
 else
 if l3Same(Parser.CurrentTag, 'ProceedingsNumber') and l3Same(Parser.Tags[1], 'Consideration') then
  f_CommonDocNum := aStr
 else
 if l3Same(Parser.CurrentTag, 'InstanceNum') and l3Same(Parser.Tags[1], 'CaseDoc') then
 begin
  if l3IsNil(f_CommonDocNum) then
  begin
   l_Idx := l3StrToIntDef(aStr.AsWStr, 0);
   if (l_Idx > 0) and (l_Idx <= f_InstanceNums.Count) then
    f_DocNum := f_InstanceNums.ItemC[l_Idx-1];
  end;
 end
 else
 if l3Same(Parser.CurrentTag, 'CourtIndex') and l3Same(Parser.Tags[1], 'CaseDoc') then
  GenerateSource(aStr)
 else
 if l3Same(Parser.CurrentTag, 'DocDate') and l3Same(Parser.Tags[1], 'CaseDoc') then
  f_DocDate :=  DateTimeTostDate(StrToDateFmt('yyyy-mm-dd', l3Str(aStr)))
 else
 if l3Same(Parser.Tags[2], 'Type')  and l3Same(Parser.Tags[3], 'CaseDoc') and l3Same(Parser.Tags[1], 'Classif') and l3Same(Parser.CurrentTag, 'Name') and l3Same(Parser.Tags[1], 'Classif') then
  GenerateType(aStr)
 else
 if l3Same(Parser.CurrentTag, 'CaseDocImage') and l3Same(Parser.Tags[1], 'CaseDoc') then
  f_Blob := aStr;
end;

procedure TlcKodeksXMLReader.DoOnEndTag(const aStr: Il3CString);
begin
 if l3Same(aStr, 'Participant') then
 begin
  if not l3IsNil(f_NewParticipant.Name) then
   f_Participants.Add(f_NewParticipant);
  f_NewParticipant := nil;
 end
 else
 if l3Same(aStr, 'CaseDoc') and (
   (Parser.IsInTag('AppealDocs') and (f_CurrentCaseDocType = cdtAppealDocs)) or
   (Parser.IsInTag('ArisedDocs') and (f_CurrentCaseDocType = cdtArisedDocs))
  ) then
 begin
  if f_InstanceNums.Count > 0 then
   f_LawCaseNum := f_InstanceNums.ItemC[0];
  if l3IsNil(f_DocNum) then
   f_DocNum := f_CommonDocNum;
  FlushDateNums;
  FlushParticipants;
  FlushBlob;
  EndDocument;
 end;
end;

procedure TlcKodeksXMLReader.DoOnStartTag(const aStr: Il3CString);
begin
 if l3Same(aStr, 'Case') then
  ClearAllData
 else
 if l3Same(aStr, 'Participant') then
  f_NewParticipant := TlcParticipantHolder.Make
 else
 if l3Same(aStr, 'Consideration') then
  f_CommonDocNum := nil
 else
 if l3Same(aStr, 'CaseDoc') and (Parser.IsInTag('AppealDocs') or Parser.IsInTag('ArisedDocs')) then
 begin
  ClearDateNums;
  ClearBlob;
  StartDocument;
  if Parser.IsInTag('AppealDocs') then
   f_CurrentCaseDocType := cdtAppealDocs
  else
   f_CurrentCaseDocType := cdtArisedDocs;
 end
end;

procedure TlcKodeksXMLReader.FlushParticipants;
var
 I: Integer;
 l_Participant: IlcParticipantHolder;
begin
 if f_Participants.Count > 0 then
 begin
  Generator.StartTag(k2_tiCaseDocParticipants);
  try
   for I := 0 to f_Participants.Count - 1 do
   begin
    Generator.StartChild(k2_typParticipant);
    try
     l_Participant := f_Participants.Items[I] as IlcParticipantHolder;
     Generator.AddStringAtom(k2_tiName, l_Participant.Name.AsWStr);
     Generator.AddIntegerAtom(k2_tiType, Ord(l_Participant.TheType));
    finally
     Generator.Finish;
    end;
   end;
  finally
   Generator.Finish;
  end;
 end;
end;

class function TlcParticipantHolder.Make: IlcParticipantHolder;
var
 l_Obj : TlcParticipantHolder;
begin
 l_Obj := TlcParticipantHolder.Create;
 try
  Result := l_Obj;
 finally
  FreeAndNil(l_Obj);
 end;
end;

function TlcParticipantHolder.pm_GetName: Il3CString;
begin
 Result := f_Name;
end;

function TlcParticipantHolder.pm_GetTheType: TlcParticipantType;
begin
 Result := f_Type;
end;

procedure TlcParticipantHolder.pm_SetName(const Value: Il3CString);
begin
 f_Name := Value;
end;

procedure TlcParticipantHolder.pm_SetTheType(const Value: TlcParticipantType);
begin
 f_Type := Value;
end;

constructor TlcXMLStreamReader.Create(const aKrokDictFileName: AnsiString; anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited Create(anOwner);
 f_KodeksReader := TlcKodeksXMLReader.Create(Self);
 f_PravoReader := TlcPravoXMLReader.Create(Self);
 f_KrokReader  := TlcKrokXMLReader.Create(Self, aKrokDictFileName);
 f_SimpleReader := TlcSimpleXMLReader.Create(Self);
 f_Parser := TddXMLParser.Create;
 f_CurReader := f_KodeksReader;
end;

procedure TlcXMLStreamReader.Cleanup;
begin
 FreeAndNil(f_KodeksReader);
 FreeAndNil(f_PravoReader);
 FreeAndNil(f_KrokReader);
 FreeAndNil(f_SimpleReader);
 FreeAndNil(f_Parser);
 inherited;
end;

procedure TlcXMLStreamReader.DoOnStartTag(const aStr: Il3CString);

 procedure SwitchTo(const aReader: TlcBaseXMLReader);
 begin
  aReader.Parser := f_Parser;
  aReader.DoOnStartTag(aStr);
  f_CurReader := aReader;
 end;

begin
 if f_Parser.Tags[1] = nil then // это тег самого первого уровн€
 begin
  if l3Same(aStr, 'Case') then
   SwitchTo(f_KodeksReader)
  else
  if l3Same(aStr, 'Document') then
   SwitchTo(f_PravoReader)
  else
  if l3Same(aStr, 'transfer-data') then
   SwitchTo(f_KrokReader)
  else
  if l3Same(aStr, 'CaseDocInfoExport') then
   SwitchTo(f_SimpleReader);
 end;
end;

procedure TlcXMLStreamReader.Read;
var
 l_S: TStream;
 l_StartLevel: Integer;
begin
 if Filer.Size > MaxInt then
 begin
  l3System.Msg2Log('–аспакованный поток имеет слишком большой размер (невалидный GZIP)');
  Exit;
 end;
 f_Parser.OnData := nil;
 f_Parser.OnEndTag := nil;
 f_Parser.OnStartTag := DoOnStartTag;
 try
  l3IStream2Stream(Filer as IStream, l_S);
  try
   l_StartLevel := CurrentStartLevel;
   try
    f_Parser.ParseStream(l_S);
   finally
    // ≈сли во врем€ чтени€ XML произошла ошибка, некоторые скобки могут оказатьс€ незакрытыми,
    // что повлечЄт за собой кучу проблем дл€ следующих документов, если reader будет тот же.
    // ѕоэтому принудительно закрываем все незакрытые скобки. (K 392697929)
    while CurrentStartLevel > l_StartLevel do
     Finish;
   end;
  finally
   FreeAndNil(l_S);
  end;
 finally
  f_CurReader.Parser := nil;
 end;
end;

{ TlcKrokDocImageObj }

class function TlcKrokDocImageObj.Make: IlcKrokDocImageObj;
var
 l_Obj: TlcKrokDocImageObj;
begin
 l_Obj := TlcKrokDocImageObj.Create;
 try
  Result := l_Obj;
 finally
  FreeAndNil(l_Obj);
 end;
end;

function TlcKrokDocImageObj.pm_GetData: Il3CString;
begin
 Result := f_Data;
end;

function TlcKrokDocImageObj.pm_GetDocID: Il3CString;
begin
 Result := f_ID;
end;

procedure TlcKrokDocImageObj.pm_SetData(const Value: Il3CString);
begin
 f_Data := Value;
end;

procedure TlcKrokDocImageObj.pm_SetDocID(const Value: Il3CString);
begin
 f_ID := Value;
end;

{ TlcKrokXMLReader }

constructor TlcKrokXMLReader.Create(const aGenerator: Ik2TagGenerator; const aDictFileName: AnsiString);
begin
 inherited Create(aGenerator);
 f_Dictionary   := Tl3InterfacedStringList.MakeSorted;
 f_DocImages    := Tl3InterfacedStringList.MakeSorted;
 f_CaseDocs     := Tl3InterfacedStringList.MakeSorted;
 f_Subjects     := Tl3InterfacedStringList.MakeSorted;
 f_Participants := Tl3InterfacedStringList.MakeSorted;
 f_Handlers := [dhStartTag, dhEndTag, dhCharData, dhAttribute];
 LoadDictionary(aDictFileName);
end;

procedure TlcKrokXMLReader.Cleanup;
begin
 FreeAndNil(f_DocImages);
 FreeAndNil(f_CaseDocs);
 FreeAndNil(f_Dictionary);
 FreeAndNil(f_Subjects);
 FreeAndNil(f_Participants);
 inherited;
end;

procedure TlcKrokXMLReader.DoOnData(const aStr: Il3CString);
begin
 // Case
 if f_Parser.TagPathIs(['NumFirst', 'Case', 'objects']) then
  f_LawCaseNum := aStr
 else
 if f_Parser.TagPathIs(['NumAppeal', 'Case', 'objects']) then
 begin
  f_DocNum := aStr;
  f_Source := l3Copy(f_DocNum, 0, 4);
 end
 else
 // CaseDocImage
 if l3Same(f_Parser.Tags[0], 'CaseDocFileData') then
  f_CurDocImg.Data := aStr
 else
 // CaseDoc
 if f_Parser.TagPathIs(['CaseDocDate', 'CaseDoc', 'objects']) then
  f_CurCaseDoc.Date := DateTimeTostDate(StrToDateFmt('yyyy-mm-dd', l3Str(aStr)))
 else
 // Subject
 if f_Parser.TagPathIs(['Name', 'Subject', 'objects']) then
  f_CurSubjectName := aStr;
end;

procedure TlcKrokXMLReader.DoOnEndTag(const aStr: Il3CString);
begin
 if l3Same(aStr, 'objects') then
 begin
  GenerateDocuments;
  Exit;
 end;

 if f_Parser.TagPathIs(['CaseDocImage', 'objects']) then
 begin
  if (f_CurDocImg.DocID <> nil) then
   f_DocImages.Add(f_CurObjOID, f_CurDocImg);
  f_CurDocImg := nil;
 end
 else
 if f_Parser.TagPathIs(['CaseDoc', 'objects']) then
 begin
  f_CaseDocs.Add(f_CurObjOID, f_CurCaseDoc);
  f_CurCaseDoc := nil;
 end
 else
 if f_Parser.TagPathIs(['Subject', 'objects']) then
 begin
  f_Subjects.Add(f_CurObjOID, f_CurSubjectName);
  f_CurSubjectName := nil;
 end
 else
 if f_Parser.TagPathIs(['Participant', 'objects']) then
 begin
  f_Participants.Add(f_CurObjOID, f_CurParticipant);
  f_CurParticipant := nil;
 end
end;

procedure TlcKrokXMLReader.DoOnStartTag(const aStr: Il3CString);
begin
 if l3Same(aStr, 'objects') then
 begin
  ClearBlob;
  ClearDateNums;
  f_CaseDocs.Clear;
  f_Participants.Clear;
  f_Subjects.Clear;
  f_DocImages.Clear;
  Exit;
 end;

 if l3Same(f_Parser.Tags[1], 'objects') then
 begin
  f_CurObjOID := f_Parser.Attributes['oid'];
  if l3Same(aStr, 'CaseDocImage') then
   f_CurDocImg := TlcKrokDocImageObj.Make
  else
  if l3Same(aStr, 'CaseDoc') then
   f_CurCaseDoc := TlcKrokCaseDocObj.Make
  else
  if l3Same(aStr, 'Participant') then
   f_CurParticipant := TlcKrokParticipantObj.Make;
 end
 else

 // CaseDocImage
 if f_Parser.TagPathIs(['CaseDoc', 'CaseDocs', 'CaseDocImage', 'objects']) then
  f_CurDocImg.DocID := f_Parser.Attributes['oid']
 else
 // CaseDoc
 if f_Parser.TagPathIs(['Doc', 'Doc', 'CaseDoc', 'objects']) then
  f_CurCaseDoc.TypeID := f_Parser.Attributes['oid']
 else
 // Participant
 if f_Parser.TagPathIs(['Subject', 'Subject', 'Participant', 'objects']) then
  f_CurParticipant.Name := f_Parser.Attributes['oid']
 else
 if f_Parser.TagPathIs(['ParticipantCategory', 'Category', 'Participant', 'objects']) then
  f_CurParticipant.ParticipantType := StrToParticipantType(GetFromDict(f_Parser.Attributes['oid'])); 
end;

function TlcKrokXMLReader.FindDocImage(const aDocOID: Il3CString): IlcKrokDocImageObj;
var
 I: Integer;
 l_Img: IlcKrokDocImageObj;
begin
 Result := nil;
 for I := 0 to f_DocImages.Count-1 do
 begin
  l_Img := f_DocImages.ObjInterfaces[I] as IlcKrokDocImageObj;
  if l3Same(aDocOID, l_Img.DocID) then
  begin
   Result := l_Img;
   Break;
  end;
 end;
end;

procedure TlcKrokXMLReader.FlushParticipants;
var
 I: Integer;
 l_Participant: IlcKrokParticipantObj;
begin
 if f_Participants.Count > 0 then
 begin
  Generator.StartTag(k2_tiCaseDocParticipants);
  try
   for I := 0 to f_Participants.Count - 1 do
   begin
    Generator.StartChild(k2_typParticipant);
    try
     l_Participant := f_Participants.ObjInterfaces[I] as IlcKrokParticipantObj;
     Generator.AddStringAtom(k2_tiName, l_Participant.Name.AsWStr);
     Generator.AddIntegerAtom(k2_tiType, Ord(l_Participant.ParticipantType));
    finally
     Generator.Finish;
    end;
   end;
  finally
   Generator.Finish;
  end;
 end;
end;

procedure TlcKrokXMLReader.GenerateDocuments;
var
 I: Integer;
 l_Doc : IlcKrokCaseDocObj;
 l_Img : IlcKrokDocImageObj;
 l_Type: Il3CString;
begin
 MatchParticipantNames;
 for I := 0 to f_CaseDocs.Count-1 do
 begin
  l_Doc := f_CaseDocs.ObjInterfaces[I] as IlcKrokCaseDocObj;
  l_Img := FindDocImage(f_CaseDocs.ItemC[I]);
  if (l_Img <> nil) and (l_Img.Data <> nil) then
  begin
   StartDocument;
   try
    f_DocDate := l_Doc.Date;
    f_Blob := l_Img.Data;
    l_Type := GetFromDict(l_Doc.TypeID);
    if l_Type = nil then
     l_Type := l3CStr('ѕостановление');
    GenerateType(l_Type);
    if f_Source <> nil then
     GenerateSource(f_Source);
    FlushDateNums;
    FlushParticipants;
    FlushBlob;
   finally
    EndDocument;
   end;
  end;
 end;
end;

function TlcKrokXMLReader.GetFromDict(aKey: Il3CString): Il3CString;
var
 l_Intf: IUnknown;
begin
 l_Intf := f_Dictionary.FindInterface(aKey.AsWStr);
 Result := Il3CString(l_Intf); 
end;

procedure TlcKrokXMLReader.LoadDictionary(const aFileName: AnsiString);
var
 l_Filer: Tl3DosFiler;
 l_Line : Tl3WString;
 l_ID, l_Value: Il3CString;
 l_Pos: Integer;
begin
 f_Dictionary.Clear;
 if FileExists(aFileName) then
 begin
  l_Filer := Tl3DOSFiler.Make(aFileName);
  try
   l_Filer.Open;
   while not l_Filer.EOF do
   begin
    l_Line := l_Filer.ReadLn;
    l_Pos := ev_lPCharIndex('=', l_Line);
    if l_Pos <> l3NotFound then
    begin
     l_ID := l3CStr(l3Copy(l_Line, 0, l_Pos-1));
     l_Value := l3CStr(l3Copy(l_Line, l_Pos+1));
     f_Dictionary.Add(l_ID, l_Value);
    end;
   end;
  finally
   FreeAndNil(l_Filer);
  end;
 end;
end;

procedure TlcKrokXMLReader.MatchParticipantNames;
var
 I : Integer;
 l_Str: IUnknown;
 l_P: IlcKrokParticipantObj;
begin
 for I := f_Participants.Count-1 downto 0 do
 begin
  l_P := IlcKrokParticipantObj(f_Participants.ObjInterfaces[I]);
  l_Str := f_Subjects.FindInterface(l_P.Name.AsWStr);
  if l_Str <> nil then
   l_P.Name := Il3CString(l_Str)
  else
   f_Participants.Delete(I); 
 end;
end;

function TlcKrokXMLReader.pm_GetDictionary(anID: Tl3WString): Il3CString;
var
 l_Intf : IUnknown;
begin
 l_Intf := f_Dictionary.FindInterface(anID);
 if l_Intf <> nil then
  Result := Il3CString(l_Intf)
 else
  Result := nil; 
end;

class function TlcKrokCaseDocObj.Make: IlcKrokCaseDocObj;
var
 l_Obj: TlcKrokCaseDocObj;
begin
 l_Obj := TlcKrokCaseDocObj.Create;
 try
  Result := l_Obj;
 finally
  FreeAndNil(l_Obj);
 end;
end;

function TlcKrokCaseDocObj.pm_GetDate: TStDate;
begin
 Result := f_Date;
end;

function TlcKrokCaseDocObj.pm_GetTypeID: Il3CString;
begin
 Result := f_TypeID;
end;

procedure TlcKrokCaseDocObj.pm_SetDate(const Value: TStDate);
begin
 f_Date := Value;
end;

procedure TlcKrokCaseDocObj.pm_SetTypeID(const Value: Il3CString);
begin
 f_TypeID := Value;
end;

class function TlcKrokParticipantObj.Make: IlcKrokParticipantObj;
var
 l_Obj: TlcKrokParticipantObj;
begin
 l_Obj := TlcKrokParticipantObj.Create;
 try
  Result := l_Obj;
 finally
  FreeAndNil(l_Obj);
 end;
end;

function TlcKrokParticipantObj.pm_GetName: Il3CString;
begin
 Result := f_Name;
end;

function TlcKrokParticipantObj.pm_GetParticipantType: TlcParticipantType;
begin
 Result := f_ParticipantType;
end;

procedure TlcKrokParticipantObj.pm_SetName(const Value: Il3CString);
begin
 f_Name := Value;
end;

procedure TlcKrokParticipantObj.pm_SetParticipantType(
  const Value: TlcParticipantType);
begin
 f_ParticipantType := Value;
end;

class function TlcXMLStreamReader.SetTo(var theGenerator: Tk2TagGenerator;
  const aKrokDictFileName: AnsiString): Pointer;
var
 l_Reader : TlcXMLStreamReader;
begin
 l_Reader := Create(aKrokDictFileName, nil);
 try
  l_Reader.Generator := theGenerator;
  l3Set(theGenerator, l_Reader);
 finally
  l3Free(l_Reader);
 end;//try..finally
 Result := theGenerator;
end;

{ TlcSimpleXMLReader }

procedure TlcSimpleXMLReader.CheckAndFlushDateNums;
begin
 if not f_DateNumsIsFlushed then
 begin
  FlushDateNums;
  f_DateNumsIsFlushed := True;
 end;
end;

procedure TlcSimpleXMLReader.DoOnData(const aStr: Il3CString);
begin
 if l3Same(f_Parser.CurrentTag, 'ac') then
  GenerateSource(aStr)
 else

 if l3Same(f_Parser.CurrentTag, 'DocDate') then
  f_DocDate := DateTimeTostDate(StrToDateFmt('yyyy-mm-dd', l3Str(l3Copy(aStr, 0, 10))))
 else
 if l3Same(f_Parser.CurrentTag, 'DocNum') then
  f_DocNum := aStr
 else
 if l3Same(f_Parser.CurrentTag, 'Num1st') then
  f_LawCaseNum := aStr
 else

 if l3Same(f_Parser.CurrentTag, 'DocTypeName') then
  GenerateType(aStr)
 else

 if l3Same(f_Parser.CurrentTag, 'PartType') then
  Generator.AddIntegerAtom(k2_tiType, Ord(StrToParticipantType(aStr)))
 else
 if l3Same(f_Parser.CurrentTag, 'PartName') then
  Generator.AddStringAtom(k2_tiName, aStr.AsWStr)
 else

 if l3Same(f_Parser.CurrentTag, 'Blob') then
 begin
  CheckAndFlushDateNums;
  f_Blob := aStr;
  FlushBlob;
 end;
end;

procedure TlcSimpleXMLReader.DoOnEndTag(const aStr: Il3CString);
begin
 if l3Same(aStr, 'CaseDocInfoExport') then
 begin
  CheckAndFlushDateNums;
  EndDocument;
 end
 else
 if l3Same(aStr, 'partCol') or l3Same(aStr, 'Participant') then
  Generator.Finish;
end;

procedure TlcSimpleXMLReader.DoOnStartTag(const aStr: Il3CString);
begin
 if l3Same(aStr, 'CaseDocInfoExport') then
 begin
  ClearBlob;
  ClearDateNums;
  f_DateNumsIsFlushed := False;
  StartDocument;
 end
 else

 if l3Same(aStr, 'partCol') then
 begin
  CheckAndFlushDateNums;
  Generator.StartTag(k2_tiCaseDocParticipants);
 end
 else
 if l3Same(aStr, 'Participant') then
  Generator.StartChild(k2_typParticipant)
end;

end.
