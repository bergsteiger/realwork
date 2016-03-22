unit ddLawCaseXMLReader;

interface

Uses
 evdCustomXMLReader,
 l3Date,
 xpBase,
 ddDocReader,
 dt_Types, Classes, k2TagGen, ddTypes;

type
 TlcElement = (lcNone, lcCase, lcDate, lcNumber, lcType, lcCaseCode, lcCourt,
                lcPartCol, lcPart, lcPartType, lcPartName, lcRTF);

 TlcNewDocumentEvent = procedure(var DocID: TDocID; const Alias: AnsiString) of object;
 TLawCaseXMLReader = class(TevdCustomXMLReader)
 private
  f_Court: AnsiString;
  f_Date: Integer;
  f_LawCaseNumber: AnsiString;
  f_Number: AnsiString;
  f_OnError: TddErrorEvent;
  f_OnNewDocument: TlcNewDocumentEvent;
  f_PartNames: TStrings;
  f_PartTypes: TStrings;
  f_RTFReader: TddDocReader;
  f_Sources: TStrings;
  f_Type: AnsiString;
  f_Value: DOMString;
  procedure AddDateNumbers;
  procedure AddError(aMsg: AnsiString);
  procedure AddSource;
  procedure AddType;
  function ConvertCourt2Source(aName: AnsiString): AnsiString;
  function Element2Tag(aElement: DOMString): TlcElement;
  procedure EndPartCol;
  procedure ExctractPartName;
  procedure ExtractDate;
  procedure ExtractPartType;
  procedure ExtractRTFStream; virtual;
  function GetPartType(aParticipant: Integer): TlcParticipantType;
  function GetAlias: AnsiString;
  procedure StartPartCol;
 protected
  procedure Cleanup; override;
  procedure DoCharData(oOwner : TObject; const sValue : DOMString); override;
  procedure EndElement(oOwner : TObject; const sValue : DOMString); override;
  procedure StartElement(oOwner : TObject; const sValue : DOMString); override;
 public
    // public methods
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
  property Sources: TStrings read f_Sources write f_Sources;
  property OnError: TddErrorEvent read f_OnError write f_OnError;
  property OnNewDocument: TlcNewDocumentEvent
   read f_OnNewDocument
   write f_OnNewDocument;
 end;

 TddParticipantNameFilter = class(TLawCaseXMLReader)
 private
  f_PartTypeNames: TStrings;
  procedure AddPartType;
  procedure pm_SetPartTypeNames(const aValue: TStrings);
 protected
  procedure Cleanup; override;
  procedure EndElement(oOwner : TObject; const sValue : DOMString); override;
  procedure StartElement(oOwner : TObject; const sValue : DOMString); override;
 public
    // public methods
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
  property PartTypeNames: TStrings read f_PartTypeNames write pm_SetPartTypeNames;
 end;

 TLiteLawCaseXMLReader = class(TLawCaseXMLReader)
 private
  procedure ExtractRTFStream; override;
 end;

implementation
Uses
 l3Base, l3Memory, l3String, l3Base64, l3Stream, l3Filer,
 k2Tags, daSchemeConsts,
 NumAndDate_Const, Document_Const, Type_Const, DictItem_Const,
 SysUtils, StrUtils, Participant_Const, l3LingLib, ddUtils, l3FileUtils, l3Types, dd_lcPageNumberEliminator,
 dd_lcTableEliminator, dd_lcSectionEliminator, SectionBreak_Const, ddParticipantsConst,
 ddParticipantsUtils, dt_Const;

function CheckItems(aItem: AnsiString; aArray: Array of String): Boolean;
var
 i: Integer;
begin
 Result:= False;
 for i:= 0 to Pred(Length(aArray)) do
  if CompareText(aItem, aArray[i]) = 0 then
  begin
   Result:= True;
   break;
  end;
end;

constructor TLawCaseXMLReader.Create(anOwner: Tk2TagGeneratorOwner = nil);
  {override;}
  {-}
begin
 inherited;
 f_PartNames:= TStringList.Create;
 f_PartTypes:= TStringList.Create;
 f_RTFReader:= TddDocReader.Create(nil);
 f_RTFReader.LiteVersion:= true;
end;

procedure TLawCaseXMLReader.AddDateNumbers;
begin
 if (f_Date <> 0) or (f_Number <> '') or (f_LawCaseNumber <> '') then
 begin
  StartTag(k2_tiNumAndDates);
  try
   StartChild(k2_typNumAndDate);
   try
    AddIntegerAtom(k2_tiType, ord(dnLawCaseNum));
    if f_LawCaseNumber <> '' then
     AddStringAtom(k2_tiNumber, f_LawCaseNumber);
   finally
    Finish;
   end;
   StartChild(k2_typNumAndDate);
   try
    AddIntegerAtom(k2_tiType, ord(dnPublish));
    if f_Date <> 0 then
     AddIntegerAtom(k2_tiStart, f_Date);
    if f_Number <> '' then
     AddStringAtom(k2_tiNumber, f_Number);
   finally
    Finish;
   end;
   (*
   if GetAlias then
   begin
    StartChild(k2_typNumAndDate);
    try
     AddIntegerAtom(k2_tiType, ord(dnPublish));
     if f_Date <> 0 then
      AddIntegerAtom(k2_tiStart, f_Date);
     if f_Number <> '' then
      AddStringAtom(k2_tiNumber, 'ВАС-'+f_Number);
    finally
     Finish;
    end;
   end; // GetAlias
   *)
  finally
   Finish;
  end;
 end;
end;

procedure TLawCaseXMLReader.AddError(aMsg: AnsiString);
begin
 if Assigned(f_OnError) then
  f_OnError(aMsg);
end;

procedure TLawCaseXMLReader.AddSource;
begin
 f_Court:= ConvertCourt2Source(f_Value);
 StartTag(k2_tiSources);
 try
  StartChild(k2_typDictItem);
  try
   AddStringAtom(k2_tiName, f_Court);
  finally
   Finish;
  end;
 finally
  Finish;
 end;
end;

procedure TLawCaseXMLReader.AddType;
begin
 f_Type:= f_Value;
 StartTag(k2_tiTypes);
 try
  StartChild(k2_typDictItem);
  try
   AddStringAtom(k2_tiName, f_Type);
  finally
   Finish;
  end;
 finally
  Finish;
 end;
end;

procedure TLawCaseXMLReader.Cleanup;
begin
 inherited;
 l3Free(f_PartNames);
 l3Free(f_PartTypes);
 l3Free(f_RTFReader);                       
end;

function TLawCaseXMLReader.ConvertCourt2Source(aName: AnsiString): AnsiString;
begin
 // Преобразование внешнего имени источника в арчевое
 Result:= '';
 if f_Sources <> nil then
  Result:= f_Sources.Values[aName];
 if Result = '' then
  Result:= aName;
end;

procedure TLawCaseXMLReader.DoCharData(oOwner : TObject; const sValue : DOMString);
begin
 if not AnsiStartsStr(#10, sValue) then
  f_Value:= sValue;
end;

function TLawCaseXMLReader.Element2Tag(aElement: DOMString): TlcElement;
begin
 if AnsiStartsText('CaseDocInfoExport', aElement) then
  Result:= lcCase
 else
 if AnsiStartsText('DocDate', aElement) then
  Result:= lcDate
 else
 if AnsiStartsText('DocNum', aElement) then
  Result:= lcNumber
 else
 if AnsiStartsText('DocTypeName', aElement) then
  Result:= lcType
 else
 if AnsiStartsText('Num1st', aElement) then
  Result:= lcCaseCode
 else
 if AnsiStartsText('PartCol', aElement) then
  Result:= lcPartCol
 else
 if AnsiStartsText('Participant', aElement) then
  Result:= lcPart
 else
 if AnsiStartsText('PartType', aElement) then
  Result:= lcParttype
 else
 if AnsiStartsText('PartName', aElement) then
  Result:= lcPartName
 else
 if AnsiStartsText('ac', aElement) then
  Result:= lcCourt
 else
 if AnsiStartsText('Blob', aElement) then
  Result:= lcRTF
 else
  Result:= lcNone;
end;

procedure TLawCaseXMLReader.EndElement(oOwner : TObject; const sValue : DOMString);
begin
 case Element2Tag(sValue) of
  lcCase: Finish;
  lcDate: ExtractDate;
  lcNumber: f_Number:= f_Value;
  lcType: AddType;
  lcCaseCode : f_LawCaseNumber:= Trim(f_Value);
  lcCourt: AddSource;
  lcPartCol: EndPartCol;
  lcPartType: ExtractPartType;
  lcPartName: ExctractPartName;
  lcRTF: ExtractRTFStream;
 end;
end;

procedure TLawCaseXMLReader.EndPartCol;
var
 i: Integer;
begin
 StartTag(k2_tiCaseDocParticipants);
 try
  for i:= 0 to Pred(f_PartTypes.Count) do
  begin
   StartChild(k2_typParticipant);
   try
    AddStringAtom(k2_tiName, f_PartNames.Strings[i]);
    AddIntegerAtom(k2_tiType, Ord(GetPartType(i)));
   finally
    Finish;
   end;
  end;
 finally
  Finish;
 end;
end;

procedure TLawCaseXMLReader.ExctractPartName;
begin
 f_PartNames.Add(f_Value);
end;

procedure TLawCaseXMLReader.ExtractDate;
begin
 // Преобразует строку вида 2009-01-11T00:00:00 в дату
 f_Date:= DateTimeTostDate(StrToDateFmt('yyyy-mm-dd', Copy(f_Value, 1, 10)));
end;

procedure TLawCaseXMLReader.ExtractPartType;
begin
 f_PartTypes.Add(f_Value);
end;

procedure TLawCaseXMLReader.ExtractRTFStream;
var
 l_Base64: Tl3Base64Stream;
 l_Stream: Tl3StringStream;
 l_String: Tl3String;
 l_DOSFiler: Tl3DOSFiler;
 l_FileStream: Tl3FileStream;
 l_FileName: AnsiString;
 l_Gen: Tdd_lcPageNumberEliminator;
 l_TE: TlcTableEliminator;
 l_SE: Tdd_lcSectionEliminator;
begin
 // Преобразовать Base64-данные (f_Value) в RTF-поток (l_Stream) и скормить l_RTFReader
  l_String:= Tl3String.Create;
  try
   l_String.AsString:= f_Value;
   l_Stream:= Tl3StringStream.Create(l_String);
   try
    l_Base64:= Tl3Base64Stream.Create(l_Stream);
    try
     // Из-за того, что внутри данных может лежать вордовый документ, нужно вылить его в файл
     l_FileName:= GetUniqFileName(GetWindowsTempFolder, 'LC', '', True);
     l_FileStream:= Tl3FileStream.Create(l_FileName, l3_fmReadWrite);
     try
      l_Base64.Seek(0, 0);
      l_FileStream.CopyFrom(l_Base64, l_Base64.Size);
     finally
      l3Free(l_FileStream);
     end;

     l_DOSFiler:= Tl3DOSFiler.Create;
     try
      l_DOSFiler.FileName:= l_FileName;
      f_RTFReader.Filer:= l_DOSFiler;
      l_TE:= TlcTableEliminator.Create(nil);
      try
       l_Gen:= Tdd_lcPageNumberEliminator.Create(k2_idDocument);
       try
        l_SE:= Tdd_lcSectionEliminator.Create(nil);
        try
         l_SE.OnError:= f_OnError;
         f_RTFReader.Generator:= l_SE;
         l_SE.Generator:= l_TE;
         l_TE.Generator:= l_Gen;
         l_Gen.Generator:= Generator;
         try
          f_RTFReader.Execute;
         except
          on E: Exception do
           l3System.Exception2Log(E);
         end;
        finally
         l3Free(l_SE);
        end;
       finally
        l3Free(l_Gen);
       end;
      finally
       l3Free(l_TE);
      end;
     finally
      l3Free(l_DOSFiler);
      DeleteFile(l_FileName);
     end;
    finally
     l3Free(l_Base64);
    end;
   finally
    l3Free(l_Stream);
   end;
  finally
   l3Free(l_String);
  end
end;

function TLawCaseXMLReader.GetPartType(aParticipant: Integer): TlcParticipantType;
begin
 Result:= StrToParticipantType(f_PartTypes.Strings[aParticipant]);
end;

function TLawCaseXMLReader.GetAlias: AnsiString;
begin
 Result:= IfThen(AnsiContainsText(f_Court, 'ВАС'), ftnDocIDVAS, ftnDocIDLawCase)
end;

procedure TLawCaseXMLReader.StartElement(oOwner : TObject; const sValue : DOMString);
var
 l_ID: TDocID;
begin
 case Element2Tag(sValue) of
  lcCase:
   begin
    StartChild(k2_typDocument);
    f_Date:= 0;
    f_Number:= '';
    f_LawCaseNumber:= '';
    if Assigned(f_OnNewDocument) then
    begin
     f_OnNewDocument(l_ID, GetAlias);
     if l_ID > 0 then
      AddIntegerAtom(k2_tiExternalHandle, l_ID);
    end; // Assigned(f_OnNewDocument)
   end;
  lcPartCol: StartPartCol;
  lcRTF:
   begin
    AddDateNumbers;
    //AddName;
   end;
 end;
end;

procedure TLawCaseXMLReader.StartPartCol;
begin
 f_PartNames.Clear;
 f_PartTypes.Clear;
end;

constructor TddParticipantNameFilter.Create(anOwner: Tk2TagGeneratorOwner = nil);
  {override;}
  {-}
begin
 inherited;
 f_PartTypeNames:= TStringList.Create;
end;

procedure TddParticipantNameFilter.AddPartType;
begin
 if f_PartTypeNames.IndexOf(f_Value) = -1 then
  f_PartTypeNames.Add(f_Value);
end;

procedure TddParticipantNameFilter.Cleanup;
begin
 inherited;
 l3Free(f_PartTypeNames);
end;

procedure TddParticipantNameFilter.EndElement(oOwner : TObject; const sValue : DOMString);
begin
 if Element2Tag(sValue) = lcPartType then
  AddPartType;
end;

procedure TddParticipantNameFilter.pm_SetPartTypeNames(const aValue: TStrings);
begin
 f_PartTypeNames.Assign(aValue);
end;

procedure TddParticipantNameFilter.StartElement(oOwner : TObject; const sValue : DOMString);
begin
end;

procedure TLiteLawCaseXMLReader.ExtractRTFStream;
var
 l_Base64: Tl3Base64Stream;
 l_Stream: Tl3StringStream;
 l_String: Tl3String;
 l_DOSFiler: Tl3DOSFiler;
 l_FileStream: Tl3FileStream;
 l_FileName: AnsiString;
 l_Gen: Tdd_lcPageNumberEliminator;
 l_TE: TlcTableEliminator;
 l_SE: Tdd_lcSectionEliminator;
begin
 // Преобразовать Base64-данные (f_Value) в RTF-поток (l_Stream) и скормить l_RTFReader
  l_String:= Tl3String.Create;
  try
   l_String.AsString:= f_Value;
   l_Stream:= Tl3StringStream.Create(l_String);
   try
    l_Base64:= Tl3Base64Stream.Create(l_Stream);
    try
     // Из-за того, что внутри данных может лежать вордовый документ, нужно вылить его в файл
     l_FileName:= GetUniqFileName(GetWindowsTempFolder, 'LC', '', True);
     l_FileStream:= Tl3FileStream.Create(l_FileName, l3_fmReadWrite);
     try
      l_Base64.Seek(0, 0);
      l_FileStream.CopyFrom(l_Base64, l_Base64.Size);
     finally
      l3Free(l_FileStream);
     end;

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
      DeleteFile(l_FileName);
     end;
    finally
     l3Free(l_Base64);
    end;
   finally
    l3Free(l_Stream);
   end;
  finally
   l3Free(l_String);
  end
end;

end.
