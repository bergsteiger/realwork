unit dd_lcXMLReader;
{$I ddDefine.inc}
{.$DEFINE WRS3DLL}

interface

uses k2Reader, {xmlintf,} jclSimpleXML, k2TagGen, ddRTFReader, l3LongintList, Classes, ddLawCaseXMLReader, ddTypes,
 l3ProtoObject, l3base, k2Prim, l3VCLStrings, l3ValLst;

type
 TlcXMLParser = class(Tl3ProtoObject)
 private
  f_Date: Integer;
  f_Docs: Tl3LongintList;
  f_Field: LongInt;
  f_FileName: AnsiString;
  f_Generator: Ik2TagGenerator;
  f_ImageFolder: AnsiString;
  f_LawCaseNumber: AnsiString;
  f_Number: AnsiString;
  f_OnError: TddErrorEvent;
  f_Participants: Tl3ValueList;
  f_RTFReader: TddRTFReader;
  f_SaveImage: Boolean;
  f_Source: AnsiString;
  f_Sources: TStrings;
  {$IFDEF Threated}
  f_WRSid: Integer;
  {$ENDIF}
  procedure DoError(const aMsg: AnsiString);
  function GetExt(const aFileName: AnsiString): AnsiString;
  procedure LoadConverter;
  function pm_GetParticipantName(Index: Integer): AnsiString;
  function pm_GetParticipantsCount: Integer;
  function pm_GetParticipantType(Index: Integer): AnsiString;
  procedure SaveDocImage(const aImageFileName: AnsiString);
  procedure UnloadConverter;
 protected
  f_XMLDoc: TjclSimpleXML;
  procedure AddDateNumbers;
  procedure Cleanup; override;
  procedure ClearParams; virtual;
  function ConvertCourt2Source(aName: AnsiString): AnsiString;
  procedure DoParse; virtual;
  procedure TranslateDocImageToGenerator(aNode: TJclSimpleXMLElem);
 public
  constructor Create;
  function AddParticipant(const aType, aName: AnsiString): Boolean;
  procedure Parse(aXML: TjclSimpleXML; const aFileName: AnsiString);
  property FileName: AnsiString read f_FileName write f_FileName;
  property Generator: Ik2TagGenerator read f_Generator write f_Generator;
  property OnError: TddErrorEvent read f_OnError write f_OnError;
  property ImageFolder: AnsiString read f_ImageFolder write f_ImageFolder;
  property ParticipantName[Index: Integer]: AnsiString read pm_GetParticipantName;
  property ParticipantsCount: Integer read pm_GetParticipantsCount;
  property ParticipantType[Index: Integer]: AnsiString read pm_GetParticipantType;
  property Sources: TStrings read f_Sources write f_Sources;
 published
  property SaveImage: Boolean read f_SaveImage write f_SaveImage;
 end;

 TlcKodeksXMLParser = class(TlcXMLParser)
 private
  procedure AnalyzeConsiderations(aNode: TJclSimpleXMLElem);
  function GetParamName(aNode: TJclSimpleXMLElem): AnsiString;
  procedure ParseArisedDocs(aNode: TJclSimpleXMLElem);
  procedure ParseCaseDoc(aNode: TJclSimpleXMLElem);
  procedure ParseConsideration(aNode: TJclSimpleXMLElem);
  procedure ParseConsiderations(aNode: TJclSimpleXMLElem; aIndex: Integer);
  procedure ParseDocImage(aNode: TJclSimpleXMLElem);
  procedure ParseInstance(aNode: TJclSimpleXMLElem);
  procedure ParseParticipant(aNode: TJclSimpleXMLElem);
  procedure ParseParticipants(aNode: TJclSimpleXMLElem);
 protected
  procedure DoParse; override;
 public
 end;

 TlcKrokXMLParser = class(TlcXMLParser)
 private
  f_CaseDocID: AnsiString;
  f_Dictionary: TStrings;
  f_File: TjclSimpleXMLElem;
  f_Type: AnsiString;
  procedure AddSource;
  procedure AddType;
  procedure AddVasNumber;
  procedure ExtractParticipants(aNode: TJclSimpleXMLElem);
  function FindDocImage(aObjects: TjclSimpleXMLElem; const aDocImageID: AnsiString): TjclSimpleXMLElem;
  function FindSubject(aObjects: TjclSimpleXMLElem; const aSubjectID: AnsiString): TjclSimpleXMLElem;
  function GetParamName(aNode: TJclSimpleXMLElem): AnsiString;
  function IsVAS: Boolean;
  function oid2String(const aOid: AnsiString): AnsiString;
  procedure ParseCase(aNode:TJclSimpleXMLElem);
  procedure ParseCaseDoc(aNode:TJclSimpleXMLElem);
  procedure ParseCaseDocImage(aNode:TJclSimpleXMLElem);
  procedure ParseParticipant(aNode:TJclSimpleXMLElem);
  procedure pm_SetDictionary(const Value: TStrings);
 protected
  procedure AddDocument;
  procedure AddParticipants;
  procedure Cleanup; override;
  procedure ClearParams; override;
  procedure DoParse; override;
 public
  property Dictionary: TStrings read f_Dictionary write pm_SetDictionary;
 end;

 TlcSimpleXMLParser = class(TlcKrokXMLParser)
 private
  procedure ParseAC(aNode: TJclSimpleXMLElem);
  procedure ParseBlob(aNode: TJclSimpleXMLElem);
  procedure ParseDocDate(aNode: TJclSimpleXMLElem);
  procedure ParseDocNum(aNode: TJclSimpleXMLElem);
  procedure ParseDocTypeName(aNode: TJclSimpleXMLElem);
  procedure ParseNum1st(aNode: TJclSimpleXMLElem);
  procedure ParsePartCol(aNode: TJclSimpleXMLElem);
 protected
  procedure DoParse; override;
 end;

 TlcPravoXMLParser = class;
 TlcXMLReader = class(Tk2CustomFileReader)
 private
  f_Date: Integer;
  f_Docs: Tl3LongintList;
  f_FileName: AnsiString;
  f_KodeksReader: TlcXMLParser;
  f_KrokReader: TlcXMLParser;
  f_LawCaseNumber: AnsiString;
  f_Number: AnsiString;
  f_OldKodexReader: TlcSimpleXMLParser;
  f_PravoReader: TlcPravoXMLParser;
  f_RTFReader: TddRTFReader;
  f_XMLDoc: TjclSimpleXML;
  procedure ParseProgress(Sender: TObject; const Position, Total: Integer);
  function pm_GetDictionary: TStrings;
  procedure pm_SetDictionary(const Value: TStrings);
  procedure pm_SetFileName(const Value: AnsiString);
 protected
  procedure Cleanup; override;
  procedure InternalSetReaderParams(aParser: TlcXMLParser; aSources: TStrings; const aImageFolder:
      String; aOnError: TddErrorEvent; aSaveImage: Boolean);
 public
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
  procedure Read; override;
  procedure SetReaderParams(aSources: TStrings; const aImageFolder: AnsiString; aOnError: TddErrorEvent;
      aSaveImage: Boolean);
  property Dictionary: TStrings read pm_GetDictionary write pm_SetDictionary;
  property FileName: AnsiString read f_FileName write pm_SetFileName;
 end;

 TlcPravoXMLParser = class(TlcKrokXMLParser)
 private
  f_CourtTag: AnsiString;
  procedure ParseCourtName(aNode: TJclSimpleXMLElem);
  procedure ParseFile(aNode: TJclSimpleXMLElem);
  procedure ParseDocDate(aNode: TJclSimpleXMLElem);
  procedure ParseInstanceNumber(aNode: TJclSimpleXMLElem);
  procedure ParseType(aNode: TJclSimpleXMLElem);
  procedure ParseCaseNumber(aNode: TJclSimpleXMLElem);
  procedure ParseParticipants(aNode: TJclSimpleXMLElem);
  procedure ParseCourtTag(aNode: TJclSimpleXMLElem);
 protected
  procedure DoParse; override;
 end;




implementation

uses {XMLDoc,} Document_Const, ddParticipantsUtils, k2Tags, Participant_Const,
     l3Base64, l3Stream, l3Filer, L3Memory,
     L3FileUtils, ddUtils, L3Types, SysUtils,
  StrUtils, DictItem_Const, NumAndDate_Const, DT_Types, L3Date, JclStreams,
  l3LongintListPrim, l3DictionaryPrim, l3Dict, l3PrimString, JclStringConversions, l3ShellUtils;

{$IFDEF WRS3DLL}
// Внешний конвертер
{$I wrs.pas Include the constant and type declarations}
{$I wrs_prot.pas Include the RCG function declarations}
const
 gWRSid : Integer = 0;
{$ENDIF}

constructor TlcXMLReader.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited Create(anOwner);
 f_XMLDoc:= TJclSimpleXML.Create;
 f_XMLDoc.OnLoadProgress:= ParseProgress;
 f_KodeksReader:= TlcKodeksXMLParser.Create;
 f_KrokReader:= TlcKrokXMLParser.Create;
 f_OldKodexReader:= TlcSimpleXMLParser.Create;
 f_PravoReader := TlcPravoXMLParser.Create();
end;

procedure TlcXMLReader.Cleanup;
begin
 inherited Cleanup;
 FreeAndNil(f_XMLDoc);
 FreeAndNil(f_KodeksReader);
 FreeAndNil(f_KrokReader);
 FreeAndNil(f_OldKodexReader);
 FreeAndNil(f_PravoReader);
end;

procedure TlcXMLReader.ParseProgress(Sender: TObject; const Position, Total: Integer);
begin
 // TODO -cMM: TlcXMLParser.ParseProgress необходимо написать реализацию
end;

function TlcXMLReader.pm_GetDictionary: TStrings;
begin
 Result := TlcKrokXMLParser(f_KrokReader).Dictionary;
end;

procedure TlcXMLReader.pm_SetDictionary(const Value: TStrings);
begin
 TlcKrokXMLParser(f_KrokReader).Dictionary:= Value;
end;

procedure TlcXMLReader.pm_SetFileName(const Value: AnsiString);
begin
 if f_FileName <> Value then
 begin
  f_FileName := Value;
  f_XMLDoc.Root.Clear;
 end;
end;

procedure TlcXMLReader.Read;
begin
 Filer.Stream.Seek(0, soBeginning);
 f_XMLDoc.LoadFromStream(Filer.Stream, seAnsi);
 if AnsiSameText(f_XMLDoc.Root.Name, 'Case') then // Это кодекс
  f_KodeksReader.Parse(f_XMLDoc, FileName)
 else
 if AnsiSameText(f_XMLDoc.Root.Name, 'transfer-data') then // Это Крок
  f_KrokReader.Parse(f_XMLDoc, FileName)
 else
 if AnsiSameText(f_XMLDoc.Root.Name, 'CaseDocInfoExport') then // Это Старый кодекс
  f_OldKodexReader.Parse(f_XMLDoc, FileName)
 else
 if AnsiSameText(f_XMLDoc.Root.Name, 'Document') then // Это документы Право.ру
  f_PravoReader.Parse(f_XMLDoc, FileName);
end;

procedure TlcXMLReader.InternalSetReaderParams(aParser: TlcXMLParser; aSources: TStrings; const
    aImageFolder: AnsiString; aOnError: TddErrorEvent; aSaveImage: Boolean);
begin
 with aParser do
 begin
  Sources:= aSources;
  ImageFolder:= aImageFolder;
  OnError:= aOnError;
  SaveImage:= aSaveImage;
 end;
 aParser.Generator:= Generator;
end;

procedure TlcXMLReader.SetReaderParams(aSources: TStrings; const aImageFolder: AnsiString; aOnError:
    TddErrorEvent; aSaveImage: Boolean);
begin
 InternalSetReaderParams(f_KodeksReader, aSources, aImageFolder, aOnError, aSaveImage);
 InternalSetReaderParams(f_KrokReader, aSources, aImageFolder, aOnError, aSaveImage);
 InternalSetReaderParams(f_OldKodexReader, aSources, aImageFolder, aOnError, aSaveImage);
 InternalSetReaderParams(f_PravoReader, aSources, aImageFolder, aOnError, aSaveImage);
end;

procedure TlcKodeksXMLParser.AnalyzeConsiderations(aNode: TJclSimpleXMLElem);
var
 i, j: Integer;
 l_N, l_N2: TJclSimpleXMLElem;
 l_Type: AnsiString;
begin
 if aNode <> nil then
 begin
  for i:= 0 to Pred(aNode.Items.Count) do // <Consideration>
  begin
   l_N:= aNode.Items[i].Items.ItemNamed['ArisedDocs'];
   if l_N <> nil then
   begin
    for j:= 0 to l_N.Items.Count-1 do // <CaseDoc>
    begin
     l_N2:= l_N.Items[j].Items.ItemNamed['Type'];
     if l_N2 <> nil then
     begin
      l_Type:= GetParamName(l_N2.Items.ItemNamed['Classif']);
      if AnsiSameText('Постановление апелляционной инстанции', l_Type) and
        (l_N.Items[j].Items.ItemNamed['CaseDocImage'] <> nil) then
       f_Docs.Add(i); // j тоже имеет смысл запомнить...
     end
    end
   end;
  end;
 end; // aNode <> nil
end;

function TlcKodeksXMLParser.GetParamName(aNode: TJclSimpleXMLElem): AnsiString;
begin
 Result := '';
 if (aNode <> nil) then
   if aNode.Items.ItemNamed['Name'] <> nil then
    Result:= aNode.Items.ItemNamed['Name'].Value;
end;

procedure TlcKodeksXMLParser.ParseArisedDocs(aNode: TJclSimpleXMLElem);
var
 i: Integer;
begin
 if aNode <> nil then
  for i:= 0 to aNode.Items.Count-1 do
   ParseCaseDoc(aNode.Items[i]);
end;

procedure TlcKodeksXMLParser.ParseCaseDoc(aNode: TJclSimpleXMLElem);
var
 l_N: TJclSimpleXMLElem;
 l_Node: TJclSimpleXMLElem;
 l_Type: AnsiString;
begin
 if aNode <> nil then
 begin
  l_N:= aNode.Items.ItemNamed['Type'];
  if l_N <> nil then
  begin
   l_Type:= GetParamName(l_N.Items.ItemNamed['Classif']);
   if AnsiSameText('Постановление апелляционной инстанции', l_Type) and (aNode.Items.ItemNamed['CaseDocImage'] <> nil) then
   begin
    l_Node:= f_XMLDoc.Root;
    Generator.StartChild(k2_typDocument);
    try
     ParseInstance(l_Node.Items.ItemNamed['Instance1']);
     ParseParticipants(l_Node.Items.ItemNamed['Participants']);
     Generator.StartTag(k2_tiTypes);
     try
      Generator.StartChild(k2_typDictItem);
      try
       Generator.AddStringAtom(k2_tiName, 'Постановление');
      finally
       Generator.Finish;
      end;
     finally
      Generator.Finish;
     end;
     f_Date:= DateTimeTostDate(StrToDateFmt('yyyy-mm-dd', aNode.Items.ItemNamed['DocDate'].Value));
     f_Source:= aNode.Items.ItemNamed['CourtIndex'].Value;
     AddDateNumbers;
     Generator.StartTag(k2_tiSources);
     try
      Generator.StartChild(k2_typDictItem);
      try
       Generator.AddStringAtom(k2_tiName, ConvertCourt2Source(f_Source));
      finally
       Generator.Finish;
      end;
     finally
      Generator.Finish;
     end;
     ParseDocImage(aNode.Items.ItemNamed['CaseDocImage'])
    finally
     Generator.Finish;
    end;
   end;
  end;
 end;
end;

procedure TlcKodeksXMLParser.ParseConsideration(aNode: TJclSimpleXMLElem);
begin
 if aNode <> nil then
 begin
  if aNode.Items.ItemNamed['ProceedingsNumber'] <> nil then
   f_Number:= aNode.Items.ItemNamed['ProceedingsNumber'].Value
  else
  begin
   f_Number:= '';
   DoError('Потерялся номер дела!');
  end;
  ParseArisedDocs(aNode.Items.ItemNamed['ArisedDocs']);
 end;
end;

procedure TlcKodeksXMLParser.ParseConsiderations(aNode: TJclSimpleXMLElem; aIndex: Integer);
begin
 if aNode <> nil then
   ParseConsideration(aNode.Items[aIndex]);
end;

procedure TlcKodeksXMLParser.ParseDocImage(aNode: TJclSimpleXMLElem);
begin
 if aNode <> nil then
  TranslateDocImageToGenerator(aNode);
end;

procedure TlcKodeksXMLParser.ParseInstance(aNode: TJclSimpleXMLElem);
begin
 if aNode <> nil then
  f_LawCaseNumber := aNode.Items.ItemNamed['CaseNum'].Value;
end;

procedure TlcKodeksXMLParser.ParseParticipant(aNode: TJclSimpleXMLElem);
var
 l_S: AnsiString;
 l_Type: Integer;
begin
 if aNode <> nil then
 begin
  l_S:= GetParamName(aNode.Items.ItemNamed['ParticipantCategory']);
  if l_S <> '' then
  begin
   l_Type:= Ord(StrToParticipantType(l_S));
   if AddParticipant(IntToStr(l_Type), aNode.Items.ItemNamed['SubjectName'].Value) then
   begin
    Generator.StartChild(k2_typParticipant);
    try
     Generator.AddStringAtom(k2_tiName, aNode.Items.ItemNamed['SubjectName'].Value);
     Generator.AddIntegerAtom(k2_tiType, l_Type);
    finally
     Generator.Finish;
    end;
   end; // if AddParticipant
  end; // l_S <> ''
 end; // aNode <> nil
end;

procedure TlcKodeksXMLParser.ParseParticipants(aNode: TJclSimpleXMLElem);
var
 i: Integer;
begin
 if aNode <> nil then
 begin
  Generator.StartTag(k2_tiCaseDocParticipants);
  try
   for i:= 0 to aNode.Items.Count-1 do
    ParseParticipant(aNode.Items[i]);
  finally
   Generator.Finish;
  end;
 end;
end;

procedure TlcKodeksXMLParser.DoParse;
var
 l_Node: TJclSimpleXMLElem;
 i: Integer;
begin
 l_Node:= f_XMLDoc.Root;
 if l_Node <> nil then
 begin
  AnalyzeConsiderations(l_Node.Items.ItemNamed['Considerations']);
  if f_Docs.Empty then
  begin
   Generator.StartChild(k2_typDocument);
   Generator.Finish;
  end
  else
   for i:= 0 to f_Docs.Hi do
    ParseConsiderations(l_Node.Items.ItemNamed['Considerations'], f_Docs[i]);
 end; // l_Node <> nil
end;

procedure TlcKrokXMLParser.AddDocument;
begin
 Generator.StartChild(k2_typDocument);
 try
  AddType;
  AddSource;
  AddDateNumbers;
  if IsVAS then
   AddVasNumber;
  AddParticipants;
  TranslateDocImageToGenerator(f_File);
 finally
  Generator.Finish;
 end;
end;

procedure TlcKrokXMLParser.AddParticipants;
var
 i: Integer;
begin
 f_Generator.StartTag(k2_tiCaseDocParticipants);
 try
  for i:= 0 to Pred(ParticipantsCount) do
  begin
   f_Generator.StartChild(k2_typParticipant);
   try
    f_Generator.AddStringAtom(k2_tiName, ParticipantName[i]);
    f_Generator.AddIntegerAtom(k2_tiType, StrToIntDef(ParticipantType[i], 0));
   finally
    f_Generator.Finish;
   end;
  end;
 finally
  f_Generator.Finish;
 end;

end;

procedure TlcKrokXMLParser.AddSource;
begin
 Generator.StartTag(k2_tiSources);
 try
  Generator.StartChild(k2_typDictItem);
  try
   Generator.AddStringAtom(k2_tiName, ConvertCourt2Source(f_Source));
  finally
   Generator.Finish;
  end;
 finally
  Generator.Finish;
 end;
end;

procedure TlcKrokXMLParser.AddType;
begin
 Generator.StartTag(k2_tiTypes);
 try
  Generator.StartChild(k2_typDictItem);
  try
   Generator.AddStringAtom(k2_tiName, f_Type);
  finally
   Generator.Finish;
  end;
 finally
  Generator.Finish;
 end;
end;

procedure TlcKrokXMLParser.AddVasNumber;
begin
 if (f_Number <> '') and not AnsiStartsText('ВАС', f_Number) then
 begin
  f_Generator.StartTag(k2_tiNumAndDates);
  try
    f_Generator.StartChild(k2_typNumAndDate);
    try
     f_Generator.AddIntegerAtom(k2_tiType, ord(dnPublish));
     if f_Date <> 0 then
      f_Generator.AddIntegerAtom(k2_tiStart, f_Date);
     f_Generator.AddStringAtom(k2_tiNumber, 'ВАС-'+f_Number);
    finally
     f_Generator.Finish;
    end;
  finally
   f_Generator.Finish;
  end;
 end;
end;

procedure TlcKrokXMLParser.Cleanup;
begin
 inherited;
 FreeAndNil(f_Participants);
end;

procedure TlcKrokXMLParser.ClearParams;
begin
 inherited;
 f_Participants.Clear;
 f_Type:= 'Постановление';
end;

procedure TlcKrokXMLParser.DoParse;
var
 l_N, l_Objects: TJclSimpleXMLElem;
 i: Integer;
begin
 l_Objects:= f_XMLDoc.Root.Items.ItemNamed['Objects'];
  if l_Objects <> nil then
  for i:= 0 to l_Objects.Items.Count-1 do
  begin
   l_N:= l_Objects.Items[i];
   if AnsiSameText(l_N.Name, 'case') then
    ParseCase(l_N)
   else
   if AnsiSameText(l_N.Name, 'participant') then
    ParseParticipant(l_N)
   else
   if AnsiSameText(l_N.Name, 'casedoc') then
    ParseCaseDoc(l_N)
  end;
end;

procedure TlcKrokXMLParser.ExtractParticipants(aNode: TJclSimpleXMLElem);
var
 l_N, l_N2: TJclSimpleXMLElem;
 l_S, l_name: AnsiString;
 l_Type: Integer;
begin
 // В документе несколько узлов с именем Participant
 Generator.StartTag(k2_tiCaseDocParticipants);
 try
  l_N:= aNode.Items.ItemNamed['Participant'];
  while l_N <> nil do
  begin
   l_N2:= l_N.Items.ItemNamed['Category'];
   if l_N2 <> nil then
   begin
    l_S:= GetParamName(l_N2.Items.ItemNamed['ParticipantCategory']);
    if l_S <> '' then
    begin
     l_Type:= Ord(StrToParticipantType(l_S));
     l_Name:= aNode.Items.ItemNamed['SubjectName'].Value;
     if AddParticipant(IntToStr(l_Type), l_Name) then
     begin
      Generator.StartChild(k2_typParticipant);
      try
       Generator.AddStringAtom(k2_tiName, l_Name);
       Generator.AddIntegerAtom(k2_tiType, l_Type);
      finally
       Generator.Finish;
      end;
     end; // AddParticipant(IntToStr(l_Type), l_Name)
    end; // l_S <> ''
   end;
   if aNode.GetChildIndex(l_N)+1 < aNode.Items.Count then
   begin
    l_N:= aNode.Items[aNode.GetChildIndex(l_N)+1];
    if l_N <> nil then
     if l_N.Name <> 'Participant' then
      l_N:= nil;
   end
   else
    l_N:= nil;
  end;
 finally
  Generator.Finish;
 end;
end;

function TlcKrokXMLParser.FindDocImage(aObjects: TjclSimpleXMLElem; const aDocImageID: AnsiString):
    TjclSimpleXMLElem;
var
 i: Integer;
 l_Node, l_Image: TjclSimpleXMLElem;
begin
 Result := nil;
 if aDocImageID <> '' then
 begin
  for i:= 0 to aObjects.Items.Count-1 do
  begin
   l_Image:= aObjects.Items[i];
   if ansiSameText(l_Image.Name, 'CaseDocImage') then
   begin
    l_Node:= l_Image.Items.ItemNamed['CaseDocs'];
    if l_Node <> nil then
    begin
     l_Node:= l_Node.Items.ItemNamed['CaseDoc'];
     if l_Node <> nil then
      if l_Node.Properties.Value('oid', '') = aDocImageID then
      begin
       Result:= l_Image;
       break;
      end; // l_Node.Properties.Value('oid', '') = aDocImageID
    end; // l_Node <> nil
   end; // ansiSameText(l_Node.Name, 'CaseDocImage')
  end; // for i
 end; // aDocImage <> ''
end;

function TlcKrokXMLParser.FindSubject(aObjects: TjclSimpleXMLElem; const aSubjectID: AnsiString):
    TjclSimpleXMLElem;
var
 i: Integer;
 l_Subj: TjclSimpleXMLElem;
begin
 Result := nil;
 if aSubjectID <> '' then
 begin
  for i:= 0 to aObjects.Items.Count-1 do
  begin
   l_Subj:= aObjects.Items[i];
   if ansiSameText(l_Subj.Name, 'Subject') and (l_Subj.Properties.Value('oid', '') = aSubjectID) then
   begin
    Result:= l_Subj;
    break;
   end; // ansiSameText(l_Node.Name, 'CaseDocImage')
  end; // for i
 end; // aDocImage <> ''
end;

function TlcKrokXMLParser.GetParamName(aNode: TJclSimpleXMLElem): AnsiString;
begin
 if (aNode <> nil) then
  Result:= Dictionary.Values[aNode.Properties.Value('oid', '')];
end;

function TlcKrokXMLParser.IsVAS: Boolean;
begin
 Result := AnsiContainsText(f_Source, 'ВАС');
end;

function TlcKrokXMLParser.oid2String(const aOid: AnsiString): AnsiString;
begin
 Result := aOID;
 if f_Dictionary.Values[aoid] <> '' then
  Result:= f_Dictionary.Values[aoid];
end;

procedure TlcKrokXMLParser.ParseCase(aNode:TJclSimpleXMLElem);
var
 l_Node: TjclSimpleXMLElem;
begin
 l_Node:= aNode.Items.ItemNamed['NumFirst'];
 if l_Node <> nil then
  f_LawCaseNumber:= l_Node.Value;
 l_Node:= aNode.Items.ItemNamed['NumAppeal'];
 if l_Node <> nil then
 begin
  f_Number:= l_Node.Value;
  f_Source:= Copy(f_Number, 1, 4);
 end;
end;

procedure TlcKrokXMLParser.ParseCaseDoc(aNode:TJclSimpleXMLElem);
var
 l_Node: TjclSimpleXMLElem;
 l_ValidDocImage: Boolean;
 l_OID: AnsiString;
begin
 l_ValidDocImage:= False;
 l_Node:= aNode.Items.ItemNamed['CaseDocDate'];
 if l_Node <> nil then
  f_Date:= DateTimeTostDate(StrToDateFmt('yyyy-mm-dd', l_Node.Value));
 l_Node:= aNode.Items.ItemNamed['Doc'];
 if l_Node <> nil then
 begin
  l_Node:= l_Node.Items.ItemNamed['Doc'];
  if l_Node <> nil then
  begin
   l_OID:= oid2String(l_Node.Properties.Value('oid', ''));
   l_ValidDocImage:= AnsiStartsText('постановление', l_OID);
  end; 
 end;
 if l_ValidDocImage then
  ParseCaseDocImage(FindDocImage(aNode.Parent, aNode.Properties.Value('oid', '')))
end;

procedure TlcKrokXMLParser.ParseCaseDocImage(aNode:TJclSimpleXMLElem);
begin
 if aNode <> nil then
 begin
  f_File:= aNode;
  AddDocument;
 end;
end;

procedure TlcKrokXMLParser.ParseParticipant(aNode:TJclSimpleXMLElem);
var
 l_Subj, l_Category: TjclSimpleXMLElem;
 l_Name, l_Type: AnsiString;
begin
 l_Subj:= aNode.Items.ItemNamed['Subject'];
 if l_Subj <> nil then
 begin
  l_Subj:= l_Subj.Items.ItemNamed['Subject'];
  if l_Subj <> nil then
  begin
   l_Subj:= FindSubject(aNode.Parent, l_Subj.Properties.Value('oid', ''));
   if l_Subj <> nil then
   begin // Добавляем участиника в список
    l_Name:= l_Subj.Items.ItemNamed['Name'].Value;
    l_Category:= aNode.Items.ItemNamed['Category'].Items.ItemNamed['ParticipantCategory'];
    l_Type:= Oid2String(l_Category.Properties.Value('oid', ''));
    l_Type:= IntToStr(Ord(StrToParticipantType(l_Type)));
    AddParticipant(l_Type, l_Name);
   end;
  end;
 end;
end;

procedure TlcKrokXMLParser.pm_SetDictionary(const Value: TStrings);
begin
 f_Dictionary := Value;
end;

constructor TlcXMLParser.Create;
begin
 inherited;
 f_RTFReader:= TddRTFReader.Create(nil);
 f_RTFReader.LiteVersion:= true;
 f_Docs:= Tl3LongintList.Make;
 f_Participants := Tl3ValueList.MakeSorted(l3_dupAccept); // потому что хранятся как тип=имя
 f_SaveImage:= False;
 LoadConverter;
end;

procedure TlcXMLParser.AddDateNumbers;
begin
 if (f_Date <> 0) or (f_Number <> '') or (f_LawCaseNumber <> '') then
 begin
  Generator.StartTag(k2_tiNumAndDates);
  try
   Generator.StartChild(k2_typNumAndDate);
   try
    Generator.AddIntegerAtom(k2_tiType, ord(dnLawCaseNum));
    if f_LawCaseNumber <> '' then
     Generator.AddStringAtom(k2_tiNumber, f_LawCaseNumber);
   finally
    Generator.Finish;
   end;
   Generator.StartChild(k2_typNumAndDate);
   try
    Generator.AddIntegerAtom(k2_tiType, ord(dnPublish));
    if f_Date <> 0 then
     Generator.AddIntegerAtom(k2_tiStart, f_Date);
    if f_Number <> '' then
     Generator.AddStringAtom(k2_tiNumber, f_Number);
   finally
    Generator.Finish;
   end;
  finally
   Generator.Finish;
  end;
 end;
end;

function TlcXMLParser.AddParticipant(const aType, aName: AnsiString): Boolean;
var
 l_Index: Integer;
 l_NS : Tl3NamedString;
begin
 // Добавляет пару Type=Name
 Result:= False;
 for l_Index:= 0 to f_Participants.Hi do
  if SimilarParticipant(Tl3NamedString(f_Participants.Items[l_Index]).Value, aName) and
     AnsiSameText(Tl3NamedString(f_Participants.Items[l_Index]).AsString, aType)then
   exit;
 l_NS := Tl3NamedString.Create;
 try
  l_NS.AsString := aType;
  l_NS.Value := aName;
  f_Participants.Add(l_NS);
 finally
  l3Free(l_NS);
 end; //try..finally
 Result:= True;
end;

procedure TlcXMLParser.Cleanup;
begin
 inherited;
 FreeAndNil(f_Participants);
 FreeAndNil(f_RTFReader);
 FreeAndNil(f_Docs);
 UnloadConverter;
end;

procedure TlcXMLParser.ClearParams;
begin
 f_Date:= 0;
 f_Docs.Clear;
 f_LawCaseNumber:= '';
 f_Number:= '';
 f_Source:= '';
 f_Participants.Clear;
end;

function TlcXMLParser.ConvertCourt2Source(aName: AnsiString): AnsiString;
begin
 // Преобразование внешнего имени источника в арчевое
 Result:= '';
 if f_Sources <> nil then
  Result:= Trim(f_Sources.Values[aName]);
 if Result = '' then
  Result:= aName;
end;

procedure TlcXMLParser.DoError(const aMsg: AnsiString);
begin
 if Assigned(f_OnError) then
  f_OnError(aMsg)
 else
  l3System.Msg2Log(aMsg);
end;

procedure TlcXMLParser.DoParse;
begin
end;

function TlcXMLParser.GetExt(const aFileName: AnsiString): AnsiString;
var
 l_Header: LongWord;
 l_Count: Longint;
begin
 Result := '.image';
 with Tl3FileStream.Create(aFileName, l3_fmRead) do
 try
  Seek(0, 0);
  l_Count:= Read(l_Header, SizeOf(l_Header));
  if l_Count = 4 then
  begin
   if l_Header = $74725C7B then
    Result:= '.rtf'
   else
   if l_Header = $E011CFD0 then
    Result:= '.doc'
   else
   if l_Header = $46445025 then
    Result:= '.pdf';
  end; // l_Count = 4
 finally
  Free;
 end;
end;

procedure TlcXMLParser.LoadConverter;
begin
 {$IFDEF WRS3DLL}
 // Внешний конвертер
 {$IFDEF Threated}
 if f_WRSid = 0 then
 begin
  //l3System.Msg2Log('Загрузка WRS3.DLL');
  f_WRSid := WrsNewSession();   // start a new conversion session
  if f_WRSid <> 0 then
   WrsSetFlags(f_WRSid, True, WRFLAG_RETURN_WRMSG_ID)
  else
   l3System.Msg2Log('Не удалось загрузить WRS3.DLL');  // гасим сообщения об ошибках
 end; // g_WRSid = 0
 {$ELSE}
 if gWRSid = 0 then
 begin
  //l3System.Msg2Log('%s: загрузка WRS3.DLL', [ClassName]);
  gWRSid := WrsNewSession();   // start a new conversion session
  if gWRSid <> 0 then
   WrsSetFlags(gWRSid, True, WRFLAG_RETURN_WRMSG_ID)
  else
   l3System.Msg2Log('Не удалось загрузить WRS3.DLL');  // гасим сообщения об ошибках
 end; // gWRSid = 0
 {$ENDIF}
 {$ENDIF};
end;

procedure TlcXMLParser.Parse(aXML: TjclSimpleXML; const aFileName: AnsiString);
begin
 f_FileName:= aFileName;
 f_XMLDoc:= aXML;
 ClearParams;
 DoParse;
end;

function TlcXMLParser.pm_GetParticipantName(Index: Integer): AnsiString;
begin
 //type=name
 Result := Tl3NamedString(f_Participants.Items[Index]).Value;
end;

function TlcXMLParser.pm_GetParticipantsCount: Integer;
begin
 Result := f_Participants.Count;
end;

function TlcXMLParser.pm_GetParticipantType(Index: Integer): AnsiString;
begin
 // type=name
 Result := f_Participants.Items[Index].AsString;
end;

procedure TlcXMLParser.SaveDocImage(const aImageFileName: AnsiString);
var
 l_Ext: AnsiString;
begin
 ForceDirectories(ImageFolder);
 l_Ext:= GetExt(aImageFileName);
 CopyFile(aImageFileName, ConcatDirName(ImageFolder, ChangeFileExt(ExtractFileName(FileName), l_Ext)));
end;

procedure TlcXMLParser.TranslateDocImageToGenerator(aNode: TJclSimpleXMLElem);
var
 l_Base64: Tl3Base64Stream;
 l_Stream: Tl3StringStream;
 l_String: Tl3String;
 l_DOSFiler: Tl3DOSFiler;
 l_FileStream: Tl3FileStream;
 l_FileName: AnsiString;
 l_RTFFileName: AnsiString;
 l_Ext: AnsiString;
 l_Msg, l_DebugMsg: PAnsiChar;
 l_PDocFileName, l_PRTFFileName: array[1..256] of AnsiChar;
begin
 l_String:= Tl3String.Create;
 try
  l_String.AsString:= aNode.Value;
  l_Stream:= Tl3StringStream.Create(l_String);
  try
   l_Base64:= Tl3Base64Stream.Create(l_Stream);
   try
    // Из-за того, что внутри данных может лежать вордовый документ, нужно вылить его в файл
    l_FileName:= l3GetTempFileName('gz');
    l_FileStream:= Tl3FileStream.Create(l_FileName, l3_fmReadWrite);
    try
     l_Base64.Seek(0, 0);
     l_FileStream.CopyFrom(l_Base64, l_Base64.Size);
    finally
     l3Free(l_FileStream);
    end;
   finally
    l3Free(l_Base64);
   end;
  finally
   l3Free(l_Stream);
  end;
 finally
  l3Free(l_String);
 end;

 l_Ext:= GetExt(l_FileName);
 if RenameFile(l_FileName, ChangeFileExt(l_FileName, l_Ext)) then
  l_FileName:= ChangeFileExt(l_FileName, l_Ext);

 if AnsiSameText(l_Ext, '.doc') or AnsiSameText(l_Ext, '.rtf') then
 begin
  if SaveImage then
   SaveDocImage(l_FileName);// Нужно скопировать образ в отдельную папку
  {$IFDEF WRS3DLL}
  //=== Для тестов
  if AnsiSameText(l_Ext, '.doc'){$IFDEF Threated} and (f_WRSid <> 0){$ENDIF} then
  begin
   {$IFDEF Threated}
   //LoadConverter;
   {$ENDIF}
   WrsResetLastMessage({$IFDEF Threated}f_WRSid{$ELSE}gWRSId{$ENDIF});
   //l_PDocFileName:= PAnsiChar(l_FileName);
   System.FillChar(l_PDocFileName, 255, 0);
   System.FillChar(l_PRTFFileName, 255, 0);
   StrPCopy(addr(l_PDocFileName), l_FileName);
   l_RTFFileName:= ChangeFileExt(l_FileName, '.rtf');
   StrPCopy(addr(l_PRTFFileName), l_RTFFileName);
   //l_PRTFFileName:= PAnsiChar(l_RTFFileName);
   { TODO : Можно переделать на преобразование буфера }
   if WrsConvertFile({$IFDEF Threated}f_WRSid{$ELSE}gWRSId{$ENDIF}, Addr(l_PDocFileName), addr(l_PRTFFileName)) <> 0 then
   begin
    DeleteFile(l_FileName);
    l_FileName:= ChangeFileExt(l_FileName, '.rtf');
   end
   else
   begin
    //WrsGetLastMessage({$IFDEF Threated}f_WRSid{$ELSE}gWRSId{$ENDIF}, l_Msg, PAnsiChar(l_DebugMsg));
    DoError(Format('Ошибка преобразования файла %s'{: %s %s'}, [l_FileName{, String(l_Msg), l_DebugMsg}]));
   end;
   {$IFDEF Threated}
   //UnloadConverter;
   {$ENDIF}
  end; // AnsiSameText(l_Ext, '.doc') and (gWRSid <> 0)
  //=== Для тестов
  {$ENDIF}

  l_DOSFiler:= Tl3DOSFiler.Create;
  try
   l_DOSFiler.FileName:= l_FileName;
   f_RTFReader.Filer:= l_DOSFiler;
   f_RTFReader.Generator:= Generator;
   try
    f_RTFReader.Execute;
   except
    on E: Exception do
     l3System.Exception2Log(E);
   end;
  finally
   l3Free(l_DOSFiler);
  end;
 end //  AnsiSameText(l_Ext, '.doc') or AnsiSameText(l_Ext, '.rtf')
 else
  DoError(Format('Неподдерживаемый формат документа %s', [l_Ext]));
 if not DeleteFile(l_FileName) then
  DoError(Format('Не удалось удалить %s', [l_FileName]));
end;

procedure TlcXMLParser.UnloadConverter;
begin
 // Внешний конвертер
 {$IFDEF WRS3DLL}
 {$IFDEF Threated}
 if f_WRSid <> 0 then
 begin
  //l3System.Msg2Log('Выгрузка WRS3.DLL');
  // end conversion session
  WrsEndSession(f_WRSid);
  f_WRSid:= 0;
 end; // gWRSid <> 0
 {$ELSE}
 if gWRSid <> 0 then
 begin
  //l3System.Msg2Log('%s: выгрузка WRS3.DLL', [ClassName]);
  // end conversion session
  WrsEndSession(gWRSid);
  gWRSid:= 0;
 end; // gWRSid <> 0
 {$ENDIF}
 {$ENDIF};
end;

procedure TlcSimpleXMLParser.DoParse;
var
 l_N, l_Objects: TJclSimpleXMLElem;
 i: Integer;
begin
  for i:= 0 to f_XMLDoc.Root.Items.Count-1 do
  begin
   l_N:= f_XMLDoc.Root.Items[i];
   if AnsiSameText(l_N.Name, 'ac') then
    ParseAC(l_N)
   else
   if AnsiSameText(l_N.Name, 'DocDate') then
    ParseDocDate(l_N)
   else
   if AnsiSameText(l_N.Name, 'DocNum') then
    ParseDocNum(l_N)
   else
   if AnsiSameText(l_N.Name, 'DocTypeName') then
    ParseDocTypeName(l_N)
   else
   if AnsiSameText(l_N.Name, 'Num1st') then
    ParseNum1st(l_N)
   else
   if AnsiSameText(l_N.Name, 'PartCol') then
    ParsePartCol(l_N)
   else
   if AnsiSameText(l_N.Name, 'Blob') then
    ParseBlob(l_N)
  end;
end;

procedure TlcSimpleXMLParser.ParseAC(aNode: TJclSimpleXMLElem);
begin
 f_Source:= UTF8ToAnsiString(aNode.Value);
end;

procedure TlcSimpleXMLParser.ParseBlob(aNode: TJclSimpleXMLElem);
begin
 f_File:= aNode;
 AddDocument;
end;

procedure TlcSimpleXMLParser.ParseDocDate(aNode: TJclSimpleXMLElem);
begin
 f_Date:= DateTimeTostDate(StrToDateFmt('yyyy-mm-dd', Copy(aNode.Value, 1, 10)));
end;

procedure TlcSimpleXMLParser.ParseDocNum(aNode: TJclSimpleXMLElem);
begin
 f_Number:= UTF8ToAnsiString(aNode.Value);
end;

procedure TlcSimpleXMLParser.ParseDocTypeName(aNode: TJclSimpleXMLElem);
begin
 f_Type:= UTF8ToAnsiString(aNode.Value);
end;

procedure TlcSimpleXMLParser.ParseNum1st(aNode: TJclSimpleXMLElem);
begin
 f_LawCaseNumber:= UTF8ToAnsiString(aNode.Value);
end;

procedure TlcSimpleXMLParser.ParsePartCol(aNode: TJclSimpleXMLElem);
var
 i: Integer;
 l_Type, l_Name: AnsiString;
begin
 for i:= 0 to Pred(aNode.Items.Count) do
 begin
  l_Type:= UTF8ToAnsiString(aNode.Items[i].Items.ItemNamed['PartType'].Value);
  l_Name:= UTF8ToAnsiString(aNode.Items[i].Items.ItemNamed['PartName'].Value);
  AddParticipant(IntToStr(Ord(StrToParticipantType(l_Type))), l_Name);
 end;
end;

procedure TlcPravoXMLParser.DoParse;
var
 l_N, l_Objects: TJclSimpleXMLElem;
 i: Integer;
begin
  for i:= 0 to Pred(f_XMLDoc.Root.Items.Count) do
  begin
   l_N:= f_XMLDoc.Root.Items[i];

   if AnsiSameText(l_N.Name, 'CaseNumber') then
    ParseCaseNumber(l_N)
   else
   if AnsiSameText(l_N.Name, 'CourtName') then
    ParseCourtName(l_N)
   else
   if AnsiSameText(l_N.Name, 'CourtTag') then
    ParseCourtTag(l_N)
   else
   if AnsiSameText(l_N.Name, 'DocDate') then
    ParseDocDate(l_N)
   else
   if AnsiSameText(l_N.Name, 'InstanceNumber') then
    ParseInstanceNumber(l_N)
   else
   if AnsiSameText(l_N.Name, 'Type') then
    ParseType(l_N)
   else
   if AnsiSameText(l_N.Name, 'Participants') then
    ParseParticipants(l_N)
   else
   if AnsiSameText(l_N.Name, 'File') or AnsiSameText(l_N.Name, 'blob') then
    ParseFile(l_N)
  end; // for i

  AddDocument;

end;

procedure TlcPravoXMLParser.ParseCourtName(aNode: TJclSimpleXMLElem);
begin
 f_Source:= ConvertCourt2Source(UTF8ToAnsiString(aNode.Value));
end;

procedure TlcPravoXMLParser.ParseFile(aNode: TJclSimpleXMLElem);
begin
 f_File:= aNode;
end;

procedure TlcPravoXMLParser.ParseDocDate(aNode: TJclSimpleXMLElem);
begin
 f_Date:= DateTimeTostDate(StrToDateFmt('yyyy-mm-dd', Copy(aNode.Value, 1, 10)));
end;

procedure TlcPravoXMLParser.ParseInstanceNumber(aNode: TJclSimpleXMLElem);
begin
 f_Number:= UTF8ToAnsiString(aNode.Value);
end;

procedure TlcPravoXMLParser.ParseType(aNode: TJclSimpleXMLElem);
begin
 f_Type:= UTF8ToAnsiString(aNode.Value);
end;

procedure TlcPravoXMLParser.ParseCaseNumber(aNode: TJclSimpleXMLElem);
begin
 f_LawCaseNumber:= UTF8ToAnsiString(aNode.Value);
end;

procedure TlcPravoXMLParser.ParseParticipants(aNode: TJclSimpleXMLElem);
var
 i: Integer;
 l_Type, l_Name: AnsiString;
begin
 for i:= 0 to Pred(aNode.Items.Count) do
 begin
  l_Type:= UTF8ToAnsiString(aNode.Items[i].Items.ItemNamed['Type'].Value);
  l_Name:= UTF8ToAnsiString(aNode.Items[i].Items.ItemNamed['Name'].Value);
  AddParticipant(IntToStr(Ord(StrToParticipantType(l_Type))), l_Name);
 end;
end;

procedure TlcPravoXMLParser.ParseCourtTag(aNode: TJclSimpleXMLElem);
begin
 f_CourtTag:= UTF8ToAnsiString(aNode.Value);
end;

end.
