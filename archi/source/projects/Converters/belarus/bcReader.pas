unit bcReader;

interface
uses
 l3Interfaces,
 l3BaseStream,
 l3Except,
 l3StringList,
 l3LongintList,
 l3Memory,
 l3Date,
 l3Variant,
 k2TagGen,
 k2Reader,
 ddTypes,
 bcInterfaces,
 bcSettings,
 arBelaDateNumList,
 arBelaPubList,
 arBelaCountryList;

type
 TbcTextFormat      = (tfUndefined, tfOEM, tfHTML, tfWord, tfXHTML);
 TbcRelatedDocTypes = (rdAffirm, rdChange, rdStop, rdExtend, rdContinue, rdExpand, rdSuccession, rdRatify, rdJoin);

type
 TbcReader = class(Tk2CustomFileReader)
 private
  f_ActiveEnd: TStDate;
  f_ActiveStart: TStDate;
  f_CancelDocNum: Il3CString;
  f_Name: Il3CString;
  f_TopicNo   : Il3CString;
  f_TextFormat: TbcTextFormat;
  f_Text: Tl3MemoryStream;
  f_TopicDispatcher: IbcTopicDispatcher;
  f_Settings: TbcSettings;
  f_Type: Il3CString;
  f_Sources: Tl3StringList;
  f_Dates: Tl3LongintList;
  f_GenName: Il3CString;
  f_Nums : Tl3StringList;
  f_LangExplicit: Boolean;
  f_OnCurTopic: TbcCurTopicReportEvent;
  f_OnError: TddErrorEvent;
  f_TopicCount: Integer;
  f_PubList : TarBelaPubList;
  f_CountryList: TarBelaCountryList;
  f_CountryListIsBad: Boolean;
  f_CurrentFile: AnsiString;
  f_PubListIsBad: Boolean;
  f_RelDocs: array [TbcRelatedDocTypes] of Tl3StringList;
  f_Conditions: Il3CString;
  f_ErrorFolder: AnsiString;
  f_RegDate: TStDate;
  f_RegNum: Il3CString;
  f_TopicList: Tl3LongintList;
  f_TopicPos: Int64;
  procedure DropRelDocs;
  function RelDocsList(aType: TbcRelatedDocTypes): Tl3StringList;
  function RelDocsCount(aType: TbcRelatedDocTypes): Integer;
  procedure AddLink(var theText: Il3CString; const aLinkText: Il3CString; var theHyperlinks: Tl3Variant; aTopics: array
   of Il3CString);
  procedure CheckValidity;
  function PubListIsOK(const aNewData: Tl3StringList): Boolean;
  procedure DropData;
  procedure FlushActiveInterval;
  procedure FlushBelongs;
  procedure FlushDateNums(const aList: TarBelaDateNumList);
  procedure FlushDocument;
  procedure FlushName;
  procedure FlushPubInfo;
  procedure FlushRelLinks;
  procedure FlushSources;
  procedure FlushText;
  procedure FlushType;
  function GetDocNum(const aStr: Tl3Wstring): Integer;
  function GetRelNum(const aStr: Tl3Wstring): Integer;
  function IsBelorussianLettersInText: Boolean;
  procedure NotifyAboutNewTopic;
  function pm_GetPubList: TarBelaPubList;
  function pm_GetCountryList: TarBelaCountryList;
  function CountryListIsOK(const aNewData: Tl3StringList): Boolean;
  procedure FlushCancelInfo;
  procedure FlushConditions;
  procedure FlushCountryInfo;
  procedure FlushCredentials;
  procedure FlushEmptyPara(aStyle: Integer = 0);
  procedure FlushRegInfo;
  procedure FlushTechInfo;
  procedure FlushTextWithLinks(const aText: Il3CString; const aHyperlinks: Tl3Variant; aStyle: Integer = 0);
  procedure GenerateName(const aDNList: TarBelaDateNumList);
  function pm_GetTopicList: Tl3LongintList;
  procedure pm_SetTopicList(const Value: Tl3LongintList);
  procedure RemoveNumID(var theStr: Il3CString);
  procedure Report(const aMsg: string; const anArgs: array of const);
  procedure SaveErroneousTopic(const aTopicNo: Il3CString; const aErrorDesc: AnsiString);
  property PubList: TarBelaPubList read pm_GetPubList;
  property CountryList: TarBelaCountryList read pm_GetCountryList;
 protected
  procedure Cleanup; override;
 public
  procedure Read; override;
  class function SetTo(var theGenerator : Tk2TagGenerator;
                     const aSettingsFilename: AnsiString;
                     const aTopicDispatcher: IbcTopicDispatcher;
                     const aOnError: TddErrorEvent = nil): Tk2TagGenerator; overload;
  property CurrentFile: AnsiString read f_CurrentFile write f_CurrentFile;
  property ErrorFolder: AnsiString read f_ErrorFolder write f_ErrorFolder;
  property TopicCount: Integer read f_TopicCount write f_TopicCount;
  property TopicList: Tl3LongintList read pm_GetTopicList write pm_SetTopicList;
  property OnCurTopic: TbcCurTopicReportEvent read f_OnCurTopic write f_OnCurTopic;
  property OnError: TddErrorEvent read f_OnError write f_OnError;
 end;

implementation
uses
 SysUtils,
 Classes,
 l3Const,
 l3Base,
 l3Types,
 l3Chars,
 l3String,
 l3Stream,
 l3Filer,
 l3FileUtils,
 l3StringToStringMap,
 l3DateSt,
 l3LingLib,
 l3StringListPrim,
 l3LongintListPrim,

 k2Tags,

 evdTypes,
 evTxtRd,
 evdStyles,

 ddRTFReader,
 ddCSV,

 DT_Types,
 DT_Const,

 k2Interfaces,
 Document_Const,
 DictItem_Const,
 ActiveInterval_Const,
 NumAndDate_Const,
 TextPara_Const,
 SegmentsLayer_Const,
 Hyperlink_Const,
 Address_Const,

 ActiveX,
 ComObj,
 OleServer,
 Variants,
 Word_TLB,

 bcHTMLReader
 ;

type
 TNumForm = (nfSingle, nfPlural);

const
 // rdAffirm, rdChange, rdStop, rdExtend, rdContinue, rdExpand, rdSuccession, rdRatify, rdJoin
 cRelDocNames: array[TNumForm, TbcRelatedDocTypes] of AnsiString = (
   ('об утверждении', 'изменяющий (дополняющий) действие', 'приостанавливающий действие', 'продлевающий действие', 'возобновляющий действие', 'распространивший действие', 'о правопреемстве в отношении', 'о ратификации', 'о присоединении к'),
   ('об утверждении', 'изменяющие (дополняющие) действие', 'приостанавливающие действие', 'продлевающие действие', 'возобновляющие действие', 'распространившие действие', 'о правопреемстве в отношении', 'о ратификации', 'о присоединении к'));

 cRDTWithComma: set of TbcRelatedDocTypes = [rdChange, rdStop, rdExtend, rdContinue, rdExpand];

const
 cMaxNameLength = 730;

const
 ccomNR    : Tl3WString = (S:'NR ';    SLen:3; SCodePage:0);
 ccomNRR   : Tl3WString = (S:'NRR ';   SLen:4; SCodePage:0);
 ccomDR    : Tl3WString = (S:'DR ';    SLen:3; SCodePage:0);
 ccomFTEXT : Tl3WString = (S:'FTEXT '; SLen:6; SCodePage:0);
 ccomTXRUS : Tl3WString = (S:'TXRUS';  SLen:5; SCodePage:0);
 ccomVID   : Tl3WString = (S:'VID ';   SLen:4; SCodePage:0);
 ccomORGAN : Tl3WString = (S:'ORGAN '; SLen:6; SCodePage:0);
 ccomNAME  : Tl3WString = (S:'NAME ';  SLen:5; SCodePage:0);
 ccomLANG  : Tl3WString = (S:'LANG ';  SLen:5; SCodePage:0);
 ccomDPRIN : Tl3WString = (S:'DPRIN '; SLen:6; SCodePage:0);
 ccomNPRIN : Tl3WString = (S:'NPRIN '; SLen:6; SCodePage:0);
 ccomDVS   : Tl3WString = (S:'DVS ';   SLen:4; SCodePage:0);
 ccomDOGR  : Tl3WString = (S:'DOGR ';  SLen:5; SCodePage:0);
 ccomIST   : Tl3WString = (S:'IST ';   SLen:4; SCodePage:0);
 ccomYEAR  : Tl3WString = (S:'YEAR ';  SLen:5; SCodePage:0);
 ccomNUMB  : Tl3WString = (S:'NUMB ';  SLen:5; SCodePage:0);
 ccomIN    : Tl3WString = (S:'IN ';    SLen:3; SCodePage:0);
 ccomIDAT  : Tl3WString = (S:'IDAT ';  SLen:5; SCodePage:0);
 ccomCOUNTR: Tl3WString = (S:'COUNTR ';SLen:7; SCodePage:0);
 ccomDTPODP: Tl3WString = (S:'DTPODP ';SLen:7; SCodePage:0);
 ccomDTRATF: Tl3WString = (S:'DTRATF ';SLen:7; SCodePage:0);
 ccomOTNFR : Tl3WString = (S:'OTNFR ' ;SLen:6; SCodePage:0);
 ccomUTVER : Tl3WString = (S:'UTVER ' ;SLen:6; SCodePage:0);
 ccomRATF  : Tl3WString = (S:'RATF ';  SLen:5; SCodePage:0);
 ccomPRIS  : Tl3WString = (S:'PRIS ';  SLen:5; SCodePage:0);
 ccomPREEM : Tl3WString = (S:'PREEM '; SLen:6; SCodePage:0);
 ccomIZMFR : Tl3WString = (S:'IZMFR '; SLen:6; SCodePage:0);
 ccomPRFR  : Tl3WString = (S:'PRFR ' ; SLen:5; SCodePage:0);
 ccomPDFR  : Tl3WString = (S:'PDFR ' ; SLen:5; SCodePage:0);
 ccomVDFR  : Tl3WString = (S:'VDFR ' ; SLen:5; SCodePage:0);
 ccomRDFR  : Tl3WString = (S:'RDFR ' ; SLen:5; SCodePage:0);
 ccomUSLOV : Tl3WString = (S:'USLOV '; SLen:6; SCodePage:0);

function ConvertWordXML2RTF(const aStream: Tl3Stream): AnsiString;
var
 l_TempFS: Tl3FileStream;
 l_TempFN, l_TempFNRTF: AnsiString;
 l_WordApp: TWordApplication;
 l_Filename, l_Format, l_False: OleVariant;
 l_Docs : Documents;
 l_Doc: WordDocument;
begin
 l_TempFN := l3GetTempFileName('bcXML');
 DeleteFile(l_TempFN); // потому что файл этот сразу создаётся с нулевой длиной и потом так и не удаляется (Винда)
 l_TempFN := l_TempFN + '.xml';
 l_TempFNRTF := ChangeFileExt(l_TempFN, '.rtf');

 try
  l_TempFS := Tl3FileStream.Create(l_TempFN, l3_fmWrite);
  try
   aStream.Position := 0;
   l_TempFS.CopyFrom(aStream, aStream.Size);
  finally
   FreeAndNil(l_TempFS);
  end;

  CoInitialize(nil);
  try
    l_WordApp := TWordApplication.Create(nil);
   try
    l_WordApp.ConnectKind := ckNewInstance;
    l_WordApp.Connect;
    try
     l_WordApp.Visible := False;

     l_FileName := l_TempFN;
     l_Docs := l_WordApp.Documents;
     l_Doc := l_Docs.Open(l_FileName, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
        EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam);
     Sleep(500);
     l_Doc.AcceptAllRevisions;
     Sleep(500);
     l_Format := wdFormatRTF;
     l_FileName := l_TempFNRTF;
     l_Doc.SaveAs(l_FileName, l_Format, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
        EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam);
     l_False := False;
     l_WordApp.Quit(l_False);
     DeleteFile(l_TempFN);
     Result := l_TempFNRTF;
    finally
     l_WordApp.Disconnect;
    end;
   finally
    FreeAndNil(l_WordApp);
   end;
  finally
   CoUninitialize;
  end;
 except
  Result := '';
 end;
end;

function bcStarts(const aSubStr: Tl3Wstring; var theStr: Il3CString): Boolean;
begin
 Result := l3Starts(aSubStr, theStr.AsWStr, True);
 if Result then
  theStr := l3CStr(l3Copy(theStr.AsWStr, aSubStr.SLen));
end;

function ConvertDate(const aStr: Il3CString): TStDate;
begin
 Result := DateTimeToStDate(StrToDateFmtDef('dd.mm.yyyy', l3Str(aStr), NullDate));
end;

procedure TbcReader.Cleanup;
begin
 f_TopicDispatcher := nil;
 FreeAndNil(f_Settings);
 FreeAndNil(f_TopicList);
 inherited;
end;

procedure TbcReader.DropData;
begin
 f_TopicNo := nil;
 FreeAndNil(f_Text);
 f_TextFormat := tfUndefined;
 f_Type := nil;
 FreeAndNil(f_Sources);
 FreeAndNil(f_Dates);
 FreeAndNil(f_Nums);
 FreeAndNil(f_PubList);
 FreeAndNil(f_CountryList);
 f_ActiveStart := 0;
 f_ActiveEnd := 0;
 f_Name := nil;
 f_GenName := nil;
 f_CancelDocNum := nil;
 f_LangExplicit := False;
 f_PubListIsBad := False;
 f_CountryListIsBad := False;
 f_Conditions := nil;
 f_RegNum := nil;
 f_RegDate := 0;
 DropRelDocs;
end;

procedure TbcReader.FlushActiveInterval;
begin
 if (f_ActiveStart > 0) or (f_ActiveEnd > 0) then
 with Generator do
 begin
  StartTag(k2_tiActiveIntervals);
  try
   StartChild(k2_typActiveInterval);
   try
    if f_ActiveStart > 0 then
     AddIntegerAtom(k2_tiStart, f_ActiveStart)
    else
     AddIntegerAtom(k2_tiStart, minActiveDate);
    if f_ActiveEnd > 0 then
     AddIntegerAtom(k2_tiFinish, f_ActiveEnd)
    else
     AddIntegerAtom(k2_tiFinish, maxActiveDate);
   finally
    Finish;
   end;
  finally
   Finish;
  end;
 end;
end;

procedure TbcReader.FlushBelongs;
begin
 with Generator do
 begin
  StartTag(k2_tiGroups);
  try
   StartChild(k2_typDictItem);
   try
    AddStringAtom(k2_tiShortName, 'BELARUS');
   finally
    Finish;
   end;
  finally
   Finish;
  end;
 end; // with
end;

procedure TbcReader.FlushDateNums(const aList: TarBelaDateNumList);
var
 I: Integer;
begin
 if Assigned(aList) then
  with Generator do
  begin
   StartTag(k2_tiNumANDDates);
   try
    for I := 0 to aList.Hi do
    begin
     StartChild(k2_typNumAndDate);
     try
      AddIntegerAtom(k2_tiType, Ord(dnPublish));
      if aList.Items[I].rDate > 0 then
       AddIntegerAtom(k2_tiStart, aList.Items[I].rDate);
      if not l3IsNil(aList.Items[I].rNum) then
       AddStringAtom(k2_tiNumber, aList.Items[I].rNum.AsWStr);
     finally
      Finish;
     end;
    end;
   finally
    Finish;
   end;
  end;
end;

procedure TbcReader.FlushDocument;
var
 I: Integer;
 l_DNList: TarBelaDateNumList;
 l_DNR: TarBelaDateNumRec;
 l_TopicNo: Longword;
 l_RelTopicNo: Longword;
begin
 CheckValidity;
 { do flushing...}
 if not l3IsNil(f_TopicNo) then
 begin
  {
  if Random < 0.33333 then
   raise El3ReadError.Create('А просто так');
  } 
  if f_Text <> nil then
  begin
   l_TopicNo := GetDocNum(f_TopicNo.AsWStr);
   if TopicList.IndexOf(l_TopicNo) < 0 then
   begin
    TopicList.Add(l_TopicNo);
    if (Assigned(f_Dates) and not Assigned(f_Nums)) or
       (not Assigned(f_Dates) and Assigned(f_Nums)) or
       ((Assigned(f_Dates) and Assigned(f_Nums)) and (f_Nums.Count <> f_Dates.Count)) then
    begin
     Report('[ОШИБКА] рассинхронизация дат и номеров', []);
     FreeAndNil(f_Dates);
     FreeAndNil(f_Nums);
    end;
    l_DNList := nil;
    if Assigned(f_Dates) then
    begin
     l_DNList := TarBelaDateNumList.Create;
     for I := 0 to f_Dates.Hi do
     begin
      l_DNR.rDate := f_Dates.Items[I];
      if not l3Same('-', f_Nums.ItemC[I]) then
       l_DNR.rNum  := f_Nums.ItemC[I]
      else
       l_DNR.rNum := nil;
      if l_DNList.IndexOf(l_DNR) < 0 then
       l_DNList.Add(l_DNR);
     end;
    end;
    try
     // генерация документа
     Generator.StartChild(k2_typDocument);
     try

      l_RelTopicNo := GetRelNum(f_TopicNo.AsWStr);
      Generator.AddIntegerAtom(k2_tiExternalHandle, l_TopicNo);
      Generator.AddIntegerAtom(k2_tiRelExternalHandle, l_RelTopicNo);
      GenerateName(l_DNList);
      FlushName;
      FlushType;
      FlushSources;
      FlushBelongs;
      FlushDateNums(l_DNList);
      FlushActiveInterval;
      FlushTechInfo;
      FlushText;
     finally
      Generator.Finish;
     end;
     // генерация справки
     Generator.StartChild(k2_typDocument);
     try
      Generator.AddIntegerAtom(k2_tiExternalHandle, l_RelTopicNo);
      Generator.AddIntegerAtom(k2_tiType, Ord(dtRelText));
      FlushBelongs;
      FlushEmptyPara(ev_saNormalNote);
      if not l3IsNil(f_GenName) then
      begin
       Generator.StartChild(k2_typTextPara);
       try
        Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalNote);
        Generator.AddStringAtom(k2_tiText, f_GenName.AsWStr);
       finally
        Generator.Finish;
       end;
      end;
      // FlushRegInfo;
      FlushConditions;
      FlushCancelInfo;
      FlushPubInfo;
      FlushRelLinks;
      FlushCountryInfo;
      FlushCredentials;
     finally
      Generator.Finish;
     end;
    finally
     FreeAndNil(l_DNList);
    end;
    Inc(f_TopicCount);
   end;
  end;
 end;
 DropData;
end;

procedure TbcReader.FlushName;
var
 l_NameInTag: Il3CString;
begin
 if l3StrLength(f_GenName) > cMaxNameLength then
  l_NameInTag := l3Cat(l3Copy(f_GenName, 0, cMaxNameLength - 3), '...')
 else
  l_NameInTag := f_GenName;
 Generator.AddStringAtom(k2_tiName, l_NameInTag.AsWStr);
end;

procedure TbcReader.FlushRelLinks;
var
 I: Integer;
 l_Str: Il3CString;
 l_Type: TbcRelatedDocTypes;
 l_TotalCount: Integer;
 l_LastType: TbcRelatedDocTypes;
 l_NumForm: TNumForm;
 l_Topics: array of Il3CString;
 l_IsFirst: Boolean;
 l_Hyperlinks: Tl3Variant;
begin
 l_TotalCount := 0;
 for l_Type := Low(TbcRelatedDocTypes) to High(TbcRelatedDocTypes) do
  l_TotalCount := l_TotalCount + RelDocsCount(l_Type);
 if l_TotalCount > 0 then
 begin
  if l_TotalCount > 1 then
   l_Str := l3CStr('См. правовые акты')
  else
   l_Str := l3CStr('См. правовой акт');
  l_IsFirst := True;
  l_Hyperlinks := nil;
  try
   for l_Type := Low(TbcRelatedDocTypes) to High(TbcRelatedDocTypes) do
   begin
    if RelDocsCount(l_Type) > 0 then
    begin
     if RelDocsCount(l_Type) = 1 then
      l_NumForm := nfSingle
     else
      l_NumForm := nfPlural;
     SetLength(l_Topics, RelDocsCount(l_Type));
     for I := 0 to RelDocsList(l_Type).Hi do
      l_Topics[I] := RelDocsList(l_Type).ItemC[I];
     if l_IsFirst then
     begin
      l_IsFirst := False;
      if l_Type in cRDTWithComma then
       l_Str := l3Cat(l_Str, ', ')
      else
       l_Str := l3Cat(l_Str, ' ');
     end
     else
      l_Str := l3Cat(l_Str, ', ');
     AddLink(l_Str, l3CStr(cRelDocNames[l_NumForm, l_Type]), l_Hyperlinks, l_Topics);
     l_LastType := l_Type;
    end;
   end;
   if l_LastType = rdJoin then
    l_Str := l3Cat(l_Str, ' настоящему международному договору.')
   else
    l_Str := l3Cat(l_Str, ' настоящего документа.');
   FlushEmptyPara(ev_saNormalNote);
   FlushTextWithLinks(l_Str, l_Hyperlinks, ev_saNormalNote);
  finally
   FreeAndNil(l_Hyperlinks);
  end;
 end;
end;

procedure TbcReader.FlushSources;
var
 I: Integer;
 l_S: Il3CString;
begin
 if Assigned(f_Sources) and (f_Sources.Count > 0) then
 with Generator do
 begin
  StartTag(k2_tiSources);
  try
   for I := 0 to f_Sources.Hi do
   begin
    if f_Settings.SourcesMap.Has(f_Sources.ItemC[I]) then
    begin
     l_S := f_Settings.SourcesMap.ValueByKey(f_Sources.ItemC[I]);
     StartChild(k2_typDictItem);
     try
      AddStringAtom(k2_tiName, l_S.AsWStr);
     finally
      Finish;
     end;
    end
    else
     if not l3Same(f_Sources.ItemC[I], '-') then
      Report('Неизвестный источник: %s', [l3Str(f_Sources.ItemC[I])]);
   end;
  finally
   Finish;
  end;
 end; // with
end;

procedure TbcReader.FlushText;
var
 l_TextGen: Tk2CustomFileReader;
 l_StreamToRead: Tl3Stream;
 l_FN: AnsiString;
 l_StartLevel: Integer;
 {$IFDEF BC_SAVEERRORIMAGE}
 l_PathToSave: AnsiString;
 l_Name: AnsiString;
 l_Ext: AnsiString;
 l_FS: Tl3FileStream;
 {$ENDIF}
begin
 l_TextGen := nil;
 l_StartLevel := Generator.CurrentStartLevel;
 f_Text.Position := 0;
 l_StreamToRead := f_Text.Use;
 try
  try
   try
    case f_TextFormat of
     tfOEM :
      begin
       l_TextGen := TevTxtReader.Create;
       TevTxtReader(l_TextGen).PlainText := True;
       TevTxtReader(l_TextGen).AnalizeCharSet := False;
       l_TextGen.Filer.CodePage := CP_OEM;
       l_TextGen.Filer.SoftEnterAsEOL := True;
      end;
     tfHTML,
     tfXHTML:
      begin
       l_TextGen := TbcHTMLReader.Create;
      end;
     tfWord :
      begin
       try
        l_FN := ConvertWordXML2RTF(f_Text);
       except
        l_FN := '';
       end;
       if l_FN <> '' then
       begin
        FreeAndNil(l_StreamToRead);
        l_StreamToRead := Tl3FileStream.Create(l_FN, l3_fmRead);
        l_TextGen := TddRTFReader.Create(nil);
        TddRTFReader(l_TextGen).LiteVersion := False;
        TddRTFReader(l_TextGen).ReadURL := True;
        TddRTFReader(l_TextGen).EnablePictures := True;
       end
       else
        raise El3ReadError.Create('Не удалось сконвертировать документ Word!');
      end;
    else
     raise El3ReadError.Create('Неизвестный формат текста документа!');
    end;

    l_TextGen.Generator := Generator;
    l_TextGen.Filer.Stream := l_StreamToRead;
    l_TextGen.Execute;
   except
    while Generator.CurrentStartLevel > l_StartLevel do
     Generator.Finish; // закрываем все скобки в ошибочно прочтённом образе, чтобы следующие документы нормально импортировались
    {$IFDEF BC_SAVEERRORIMAGE}
    l_PathToSave := ConcatDirName(ExtractFilePath(ParamStr(0)), '_BC_ERRORS_');
    ForceDirectories(l_PathToSave);
    case f_TextFormat of
     tfOEM: l_Ext := '.txt';
     tfHTML, tfXHTML: l_Ext := '.html';
     tfWord : l_Ext := '.rtf';
    end;
    if l3IsNil(f_TopicNo) then
     l_Name := 'unknown'
    else
     l_Name := l3Str(f_TopicNo);
    l_PathToSave := ConcatDirName(l_PathToSave, l_Name + l_Ext);
    FreeAndNil(l_TextGen);
    if (f_TextFormat = tfWord) and (l_FN <> '') then
    begin
     FreeAndNil(l_StreamToRead);
     CopyFile(l_FN, l_PathToSave);
     DeleteFile(l_FN);
    end
    else
    begin
     if f_TextFormat = tfWord then
      l_PathToSave := ChangeFileExt(l_PathToSave, '.xml'); // упали при конвертации Word в RTF
     l_FS := Tl3FileStream.Create(l_PathToSave, l3_fmWrite);
     try
      f_Text.Position := 0;
      l_FS.CopyFrom(f_Text, f_Text.Size);
     finally
      FreeAndNil(l_FS);
     end;
    end;
    {$ENDIF}
    raise;
   end;
  finally
   FreeAndNil(l_TextGen);
  end;
 finally
  FreeAndNil(l_StreamToRead);
 end;
 if f_TextFormat = tfWord then
  DeleteFile(l_FN);
end;

procedure TbcReader.FlushType;
begin
 if not l3IsNil(f_Type) then
 with Generator do
 begin
  StartTag(k2_tiTypes);
  try
   StartChild(k2_typDictItem);
   try
    AddStringAtom(k2_tiName, f_Type.AsWStr);
   finally
    Finish;
   end;
  finally
   Finish;
  end;
 end;
end;

function TbcReader.GetDocNum(const aStr: Tl3Wstring): Integer;
begin
 Result := f_TopicDispatcher.GetTopic(aStr, 0, False);
end;

function TbcReader.GetRelNum(const aStr: Tl3Wstring): Integer;
begin
 Result := f_TopicDispatcher.GetTopic(aStr, cAddNum4Rel, False);
end;

function TbcReader.IsBelorussianLettersInText: Boolean;
var
 I: Integer;
 l_Size: Integer;
 l_C: PAnsiChar;
 l_ANSICount, l_OEMCount: Longint;
 l_IsANSI: Boolean;
begin
 // Проверка на наличие в найденном тексте документа белорусской буквы "Ў"
 Result := False;
 if Assigned(f_Text) then
 begin
  l3AnalizeCodePage(f_Text.MemoryPool.AsPointer, f_Text.MemoryPool.AsPointer + f_Text.Size, l_OEMCount, l_ANSICount);
  l_IsANSI := l_ANSICount > l_OEMCount;
  f_Text.Position := 0;
  l_Size := f_Text.Size;
  l_C := f_Text.MemoryPool.AsPointer;
  for I := 0 to l_Size-1 do
  begin
   if (l_IsANSI and (l_C^ in [#$A1, #$A2])) or (not l_IsANSI and (l_C^ in [#$F6, #$F7])) then
   begin
    Result := True;      
    Break;
   end;
   Inc(l_C);
  end;
 end;
end;

procedure TbcReader.NotifyAboutNewTopic;
var
 l_Gen : Ik2TagGenerator;
 l_NR  : IbcBelanumReceiver;
begin
 if Assigned(f_OnCurTopic) then
  f_OnCurTopic(f_TopicNo);
 l_Gen := Generator;
 while l_Gen <> nil do
 begin
  if Supports(l_Gen, IbcBelanumReceiver, l_NR) then
   l_NR.NewBelaNum(f_TopicNo);
  l_Gen := l_Gen.NextGenerator;
 end;
end;

function TbcReader.pm_GetPubList: TarBelaPubList;
begin
 if f_PubList = nil then
  f_PubList := TarBelaPubList.Create;
 Result := f_PubList;
end;

function TbcReader.PubListIsOK(const aNewData: Tl3StringList): Boolean;
begin
 Result := False;
 if not f_PubListIsBad then
 begin
  if (PubList.Count > 0) and (PubList.Count <> aNewData.Count) then
  begin
   f_PubListIsBad := True;
   Report('ОШИБКА - рассинхронизация данных о публикациях!', []);
  end
  else
   Result := True;
 end;
end;

type
 TPubInfoModificationProc = procedure (var thePubInfo: TarBelaPubInfo; const aData: Il3CString);
 TCountryModificationProc = procedure (var theCountryRec: TarBelaCountryRec; const aData: Il3CString);

procedure modPubInfoPubSource(var thePubInfo: TarBelaPubInfo; const aData: Il3CString);
begin
 thePubInfo.rPubSource := aData;
end;

procedure modPubInfoYear(var thePubInfo: TarBelaPubInfo; const aData: Il3CString);
begin
 thePubInfo.rYear := l3StrToIntDef(aData.AsWStr, 0);
end;

procedure modPubInfoNum(var thePubInfo: TarBelaPubInfo; const aData: Il3CString);
begin
 if not l3Same('-', aData) then
  thePubInfo.rNum := aData
 else
  thePubInfo.rNum := nil;
end;

procedure modPubInfoArticle(var thePubInfo: TarBelaPubInfo; const aData: Il3CString);
begin
 if not l3Same('-', aData) then
  thePubInfo.rArticle := aData
 else
  thePubInfo.rArticle := nil;
end;

procedure modPubInfoPubDate(var thePubInfo: TarBelaPubInfo; const aData: Il3CString);
begin
 thePubInfo.rDate := ConvertDate(aData);
end;

procedure modCountryRecName(var theCountryRec: TarBelaCountryRec; const aData: Il3CString);
begin
 theCountryRec.rName := aData;
end;

procedure modCountryRecSigned(var theCountryRec: TarBelaCountryRec; const aData: Il3CString);
begin
 theCountryRec.rSigned := ConvertDate(aData);
end;

procedure modCountryRecRatify(var theCountryRec: TarBelaCountryRec; const aData: Il3CString);
begin
 theCountryRec.rRatify := ConvertDate(aData);
end;

procedure TbcReader.AddLink(var theText: Il3CString; const aLinkText: Il3CString; var theHyperlinks: Tl3Variant;
 aTopics: array of Il3CString);
var
 I: Integer;
 l_Link: Tl3Variant;
 l_Addr: Tl3Variant;
 l_DocID: Longword;
 l_URL: Il3CString;
begin
 if theHyperlinks = nil then
 begin
  k2_typSegmentsLayer.MakeTag.AsObject.SetRef(theHyperLinks);
  theHyperlinks.IntW[k2_tiHandle, nil] := Ord(ev_slHyperlinks);
 end;
 l_Link := k2_typHyperlink.MakeTag.AsObject;
 l_Link.IntW[k2_tiStart, nil] := theText.AsWStr.SLen;
 l_Link.IntW[k2_tiFinish, nil] := theText.AsWStr.SLen + aLinkText.AsWStr.SLen;
 l_URL := l3CStr('BCLINK:');
 for I := 0 to Length(aTopics) - 1 do
  l_URL := l3Cat([l_URL, aTopics[I], l3CStr(' ')]);
 l_Link.PCharLenW[k2_tiURL, nil] := l_URL.AsWStr;
 theHyperlinks.AddChild(l_Link);
 theText := l3Cat([theText, aLinkText]);
end;

procedure TbcReader.CheckValidity;
begin
 // проверяем валидность собранных данных
 if (f_ActiveStart > 0) and (f_ActiveEnd > 0) and (f_ActiveStart > f_ActiveEnd) then
 begin
  Report('ОШИБКА - дата начала действия документа больше даты окончания (команды DVS и DOGR). Топик пропущен!', []);
  DropData;
 end;
end;

procedure TbcReader.FlushPubInfo;
var
 I: Integer;
 l_Str: Il3CString;
 l_Rec: TarBelaPubInfo;
begin
 if Assigned(f_PubList) and (not f_PubListIsBad) and (f_PubList.Count > 0) then
 begin
  FlushEmptyPara(ev_saNormalNote);
  Generator.StartChild(k2_typTextPara);
  try
   Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalNote);
   Generator.AddStringAtom(k2_tiText, 'Информация о публикации документа:');
  finally
   Generator.Finish;
  end;
  for I := 0 to f_PubList.Hi do
  begin
   l_Rec := f_PubList.Items[I];
   l_Str := l_Rec.rPubSource;
   if l_Rec.rYear <> 0 then
    l_Str := l3Cat(l_Str, Format(', %d г.', [l_Rec.rYear]));
   if not l3IsNil(l_Rec.rNum) then
    l_Str := l3Cat([l_Str, l3CStr(', № '), l_Rec.rNum]);
   if not l3IsNil(l_Rec.rArticle) then
    l_Str := l3Cat([l_Str, l3CStr(', ст. '), l_Rec.rArticle]);
   if l_Rec.rDate <> 0 then
    l_Str := l3Cat(l_Str, Format(', %s г.', [l3DateToStr(l_Rec.rDate, 'dd mmmm yyyy')]));
   if not l3IsNil(l_Str) then
   begin
    Generator.StartChild(k2_typTextPara);
    try
     Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalNote);
     Generator.AddStringAtom(k2_tiText, l_Str.AsWStr);
    finally
     Generator.Finish;
    end;
   end;
  end;
 end;
end;

function TbcReader.pm_GetCountryList: TarBelaCountryList;
begin
 if f_CountryList = nil then
  f_CountryList := TarBelaCountryList.Create;
 Result := f_CountryList;
end;

function TbcReader.CountryListIsOK(const aNewData: Tl3StringList): Boolean;
begin
 Result := False;
 if not f_CountryListIsBad then
 begin
  if (CountryList.Count > 0) and (CountryList.Count <> aNewData.Count) then
  begin
   f_CountryListIsBad := True;
   Report('ОШИБКА - рассинхронизация данных о публикациях!', []);
  end
  else
   Result := True;
 end;
end;

procedure TbcReader.DropRelDocs;
var
 l_Type: TbcRelatedDocTypes;
begin
 for l_Type := Low(TbcRelatedDocTypes) to High(TbcRelatedDocTypes) do
  FreeAndNil(f_RelDocs[l_Type]);
end;

procedure TbcReader.FlushCancelInfo;
var
 l_Str: Il3CString;
 l_Segments: Tl3Variant;
begin
 if not l3IsNil(f_CancelDocNum) then
 begin
  l_Segments := nil;
  try
   FlushEmptyPara(ev_saNormalNote);
   l_Str := l3CStr('См. ');
   AddLink(l_Str, l3CStr('документ'), l_Segments, [f_CancelDocNum]);
   l_Str := l3Cat(l_Str, ', отменяющий действие настоящего документа.');
   FlushTextWithLinks(l_Str, l_Segments, ev_saNormalNote);
  finally
   FreeAndNil(l_Segments);
  end;
 end;
end;

procedure TbcReader.FlushConditions;
begin
 if not l3IsNil(f_Conditions) then
 begin
  FlushEmptyPara(ev_saNormalNote);
  Generator.StartChild(k2_typTextPara);
  try
   Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalNote);
   Generator.AddStringAtom(k2_tiText, f_Conditions.AsWStr);
  finally
   Generator.Finish;
  end;
 end;
end;

procedure TbcReader.FlushCountryInfo;
var
 I: Integer;
 l_Str: Il3CString;
 l_Rec: TarBelaCountryRec;
 l_DetailsStr: Il3CString;
begin
 if Assigned(f_CountryList) and (not f_CountryListIsBad) and (f_CountryList.Count > 0) then
 begin
  l_Str := l3CStr('Настоящий документ принят следующими странами: ');
  for I := 0 to f_CountryList.Hi do
  begin
   l_Rec := f_CountryList.Items[I];
   if I = 0 then
    l_Str := l3Cat([l_Str, l_Rec.rName])
   else
    l_Str := l3Cat([l_Str, l3CStr(', '), l_Rec.rName]);
   if (l_Rec.rSigned <> 0) or (l_Rec.rRatify <> 0) then
   begin
    l_DetailsStr := l3CStr(' (');
    if l_Rec.rSigned <> 0 then
     l_DetailsStr := l3Cat(l_DetailsStr, 'подписан ' + l3DateToStr(l_Rec.rSigned, 'dd.mm.yyyy'));
    if l_Rec.rRatify <> 0 then
    begin
     if l_Rec.rSigned <> 0 then
      l_DetailsStr := l3Cat(l_DetailsStr, ', ');
     l_DetailsStr := l3Cat(l_DetailsStr, 'ратифицирован ' + l3DateToStr(l_Rec.rRatify, 'dd.mm.yyyy'));
    end;
    l_DetailsStr := l3Cat(l_DetailsStr, ')');
    l_Str := l3Cat([l_Str, l_DetailsStr]);
   end;
  end; // for
  FlushEmptyPara(ev_saNormalNote);
  Generator.StartChild(k2_typTextPara);
  try
   Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalNote);
   Generator.AddStringAtom(k2_tiText, l_Str.AsWStr);
  finally
   Generator.Finish;
  end;
 end;
end;

procedure TbcReader.FlushCredentials;
begin
 FlushEmptyPara(ev_saNormalNote);
 Generator.StartChild(k2_typTextPara);
 try
  Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalNote);
  Generator.AddStringAtom(k2_tiText, 'Информационные и технологические составляющие и дополнительные информационные и технологические ресурсы эталонного банка данных правовой информации Республики Беларусь предоставлены Национальным центром правовой информации Республики Беларусь');
 finally
  Generator.Finish;
 end;
end;

procedure TbcReader.FlushEmptyPara(aStyle: Integer = 0);
begin
 Generator.StartChild(k2_typTextPara); // пустая строка
 try
  if aStyle <> 0 then
   Generator.AddIntegerAtom(k2_tiStyle, aStyle);
 finally
  Generator.Finish;
 end;
end;

procedure TbcReader.FlushRegInfo;
var
 l_Str: Il3CString;
 l_PStr: AnsiString;
begin
 if (not l3IsNil(f_RegNum)) and (f_RegDate <> 0) then
 begin
  FlushEmptyPara(ev_saNormalNote);
  l_Str := l3CStr('Зарегистрировано в Национальном реестре правовых актов Республики Беларусь ');
  //if f_RegDate <> 0 then
  l_Str := l3Cat(l_Str, l3DateToStr(f_RegDate, 'd mmmm yyyy г.'));
  {
  if not l3IsNil(f_RegNum) then
   if f_RegDate <> 0 then
  }
  l_Str := l3Cat([l_Str, l3CStr(', № '), f_RegNum]);
  {
   else
    l_Str := l3Cat([l_Str, l3CStr('№ '), f_RegNum]);
  }
  Generator.StartChild(k2_typTextPara);
  try
   Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalNote);
   Generator.AddStringAtom(k2_tiText, l_Str.AsWStr);
  finally
   Generator.Finish;
  end;
 end;
 {
 if l3IsNil(f_RegNum) or (f_RegDate = 0) then
 begin
  l_PStr := 'Отсутствуют регистрационные данные (';
  if f_RegDate = 0 then
   l_PStr := l_PStr + 'дата';
  if l3IsNil(f_RegNum) then
  begin
   if f_RegDate = 0 then
    l_PStr := l_PStr + ', ';
   l_PStr := l_PStr + 'номер';
  end;
  l_PStr := l_PStr + ')';
  Report(l_PStr, []);
 end;
 }
end;

procedure TbcReader.FlushTechInfo;
begin
 Generator.StartChild(k2_typTextPara);
 try
  Generator.AddIntegerAtom(k2_tiStyle, ev_saTechComment);
  if f_CurrentFile <> '' then
   Generator.AddStringAtom(k2_tiText, Format('%s %s', [f_CurrentFile, l3Str(f_TopicNo)]))
  else
   Generator.AddStringAtom(k2_tiText, f_TopicNo.AsWStr);
 finally
  Generator.Finish;
 end;
end;

procedure TbcReader.FlushTextWithLinks(const aText: Il3CString; const aHyperlinks: Tl3Variant; aStyle: Integer = 0);
begin
 Generator.StartChild(k2_typTextPara);
 try
  if aHyperlinks <> nil then
  begin
   Generator.StartTag(k2_tiSegments);
   try
    Generator.StartChild(k2_typSegmentsLayer);
    try
     aHyperlinks.WriteTag(Generator);
    finally
     Generator.Finish;
    end;
   finally
    Generator.Finish;
   end;
  end; // if aHyperlinks <> nil
  if aStyle <> 0 then
   Generator.AddIntegerAtom(k2_tiStyle, aStyle);
  Generator.AddStringAtom(k2_tiText, aText.AsWStr);
 finally
  Generator.Finish;
 end;
end;

procedure TbcReader.GenerateName(const aDNList: TarBelaDateNumList);
var
 I, J: Integer;
 l_SrcStr: AnsiString;
 l_DateArr: array of TStDate;
 l_DateStr, l_NumStr: Il3CString;
 l_NumCount: Integer;

 procedure AppendName;
 begin
  if not l3IsNil(f_Name) then
   f_GenName := l3Cat([f_GenName, l3CStr(' "'), f_Name, l3CStr('"')]);
 end;

begin
 if Assigned(aDNList) then
 begin
  SetLength(l_DateArr, aDNList.Count);
  J := 0;
  for I := 0 to aDNList.Hi do
   if aDNList.Items[I].rDate <> NullDate then
   begin
    l_DateArr[J] := aDNList.Items[I].rDate;
    Inc(J);
   end;
  if J > 0 then
  begin
   SetLength(l_DateArr, J);
   l_DateStr := l3Cat([l3CStr(' от '), l3CStr(l3DateArrayToString(l_DateArr))]);
  end;

  J := 0;
  for I := 0 to aDNList.Hi do
  begin
   if not l3IsNil(aDNList.Items[I].rNum) then
   begin
    if J = 0 then
     l_NumStr := aDNList.Items[I].rNum
    else
     l_NumStr := l3Cat([l_NumStr, l3CStr(', '), aDNList.Items[I].rNum]);
    Inc(J);
   end;
  end;

  if J > 0 then
   if J = 1 then
    l_NumStr := l3Cat([l3CStr(' № '), l_NumStr])
   else
    l_NumStr := l3Cat([l3CStr(' №№ '), l_NumStr]);
 end;

 if l3Same(f_Type, 'Закон') then
 begin
  f_GenName := l3Cat([l3CStr('Закон Республики Беларусь'), l_DateStr, l_NumStr]);
  AppendName;
 end
 else

 if l3Same(f_Type, 'Кодекс') or l3IsNil(f_Type) then
  f_GenName := l3Cat([f_Name, l_DateStr, l_NumStr])
 else

 if l3Same(f_Type, 'Нота') then
  f_GenName := f_Name
 else

 if l3Same(f_Type, 'Конституция') or l3Same(f_Type, 'Конвенция') or l3Same(f_Type, 'Договор') or
    l3Same(f_Type, 'Соглашение') or l3Same(f_Type, 'Меморандум') then
  f_GenName := l3Cat([f_Name, l_DateStr])
 else
 begin
  // все остальные типы документов
  f_GenName := f_Type;
  {
  if not l3IsNil(f_Type) then
   f_GenName := f_Type
  else
   f_GenName := l3CStr('Документ');
  }
  if Assigned(f_Sources) then
  begin
   for I := 0 to f_Sources.Hi do
   begin
    l_SrcStr := mlmaRusDeclensionStr(l3Str(f_Sources.ItemC[I]), rdRodit);
    if I = 0 then
     f_GenName := l3Cat([f_GenName, l3CStr(' '),  l3CStr(l_SrcStr)])
    else
     f_GenName := l3Cat([f_GenName, l3CStr(', '),  l3CStr(l_SrcStr)]);
   end;
  end;
  f_GenName := l3Cat([f_GenName, l_DateStr, l_NumStr]);
  AppendName;
 end;
end;

function TbcReader.pm_GetTopicList: Tl3LongintList;
begin
 if f_TopicList = nil then
  f_TopicList := Tl3LongintList.MakeSorted;
 Result := f_TopicList;
end;

procedure TbcReader.pm_SetTopicList(const Value: Tl3LongintList);
begin
 FreeAndNil(f_TopicList);
 if Value <> nil then
  f_TopicList := Value.Use;
end;

procedure TbcReader.Read;
var
 l_Str   : Il3CString;
 l_StrPos: Int64;

 procedure DropStr;
 begin
  l_Str := nil;
 end;

 function IsEndOfDocument: Boolean;
 begin
  Result := not l3IsNil(l_Str) and (l_Str.AsWStr.S[0] = cc_DollarSign);
 end;

 function NextLine: Il3CString;
 var
  l_S: Tl3WString;
  l_FirstLine: Boolean;
 begin
  Result := nil;
  l_FirstLine := True;
  l_StrPos := Filer.Pos;
  while not Filer.EOF do
  begin
   l_S := Filer.Readln;
   l_S.SCodePage := CP_OEM;
   if l_FirstLine then
   begin
    if not l3IsNil(l_S) then
    begin
     Result := l3CStr(l_S);
     if l3Same(ccomTXRUS, l_S) then // потому что после TXRUS идет текст документа, а preformated текст вполне может
      Break;                        // начинаться с пробела!
     l_FirstLine := False;
    end
    else
     Random;
   end
   else
   begin
    if not l3IsNil(l_S) and (l_S.S[0] = cc_HardSpace) then
     Result := l3Cat(Result, l_S)
    else
    begin
     Filer.UngetChars(l_S.SLen+2);
     Break;
    end;
   end;
  end; // while
  Result := l3ChangeCodePage(Result, CP_ANSI);
 end;

 procedure ReadList(const aList: Tl3StringList; aRemoveCode: Boolean = True);
 var
  l_S: Il3CString;
 begin
  if aRemoveCode then
   RemoveNumID(l_Str);
  aList.Add(l3Trim(l_Str));
  while not Filer.EOF do
  begin
   l_Str := NextLine;
   if not l3IsNil(l_Str) and (l_Str.AsWStr.S[0] = cc_Semicolon) then
   begin
    l_S := l3Copy(l_Str, 1);
    if aRemoveCode then
     RemoveNumID(l_S);
    aList.Add(l_S);
   end
   else
    Break;
  end; // while
 end;

 procedure SkipCurrentDocument;
 var
  l_S: Tl3WString;
 begin
  DropData;
  DropStr;
  while not Filer.EOF do
  begin
   l_S := Filer.Readln;
   if not l3IsNil(l_S) and (l_S.S[0] = cc_DollarSign) then
    Break;
  end;
 end;
                                                                    
 procedure LoadPubInfo(aProc: TPubInfoModificationProc; aRemoveNum: Boolean = False);
 var
  I: Integer;
  l_IsNew: Boolean;
  l_PubRec: TarBelaPubInfo;
  l_TempList: Tl3StringList;
 begin
  l_TempList := Tl3StringList.Make;
  try
   ReadList(l_TempList, aRemoveNum);
   l_IsNew := PubList.Count = 0;
   if l_IsNew or PubListIsOK(l_TempList) then
   begin
    if l_IsNew then
     l3FillChar(l_PubRec, SizeOf(l_PubRec));
    for I := 0 to l_TempList.Hi do
     if l_IsNew then
     begin
      aProc(l_PubRec, l_TempList.ItemC[I]);
      f_PubList.Add(l_PubRec);
     end
     else
     begin
      l_PubRec := f_PubList.Items[I];
      aProc(l_PubRec, l_TempList.ItemC[I]);
      f_PubList.Items[I] := l_PubRec;
     end;
   end;
  finally
   FreeAndNil(l_TempList);
  end;
 end;

 procedure LoadCountryInfo(aProc: TCountryModificationProc; aRemoveNum: Boolean = False);
 var
  I: Integer;
  l_IsNew: Boolean;
  l_CountryRec: TarBelaCountryRec;
  l_TempList: Tl3StringList;
 begin
  l_TempList := Tl3StringList.Make;
  try
   ReadList(l_TempList, aRemoveNum);
   l_IsNew := CountryList.Count = 0;
   if l_IsNew or CountryListIsOK(l_TempList) then
   begin
    if l_IsNew then
     l3FillChar(l_CountryRec, SizeOf(l_CountryRec));
    for I := 0 to l_TempList.Hi do
     if l_IsNew then
     begin
      aProc(l_CountryRec, l_TempList.ItemC[I]);
      f_CountryList.Add(l_CountryRec);
     end
     else
     begin
      l_CountryRec := f_CountryList.Items[I];
      aProc(l_CountryRec, l_TempList.ItemC[I]);
      f_CountryList.Items[I] := l_CountryRec;
     end;
   end;
  finally
   FreeAndNil(l_TempList);
  end;
 end;

 procedure LoadRelDocs(aType: TbcRelatedDocTypes);
 begin
  ReadList(RelDocsList(aType), False);
 end;

var
 I: Integer;
 l_IsNew: Boolean;
 l_WStr: Tl3WString;
 l_Num: Integer;
 l_PubRec: TarBelaPubInfo;
 l_TempList: Tl3StringList;
 l_TextFiler: Tl3CustomFiler;
 l_TypeStr: Il3CString;
 l_TempStr: Il3CString;
begin
 DropStr;
 DropData;
 try
  while not Filer.EOF do
  begin
   try
    if l3IsNil(l_Str) then // потому что могло остаться значение от предыдущих
     l_Str := NextLine;
    if not l3IsNil(l_Str) then
    begin
     if IsEndOfDocument then
     begin
      FlushDocument;
      DropStr;
     end
     else
     begin
      if bcStarts(ccomNR, l_Str) then
      begin
       f_TopicNo := l3Trim(l_Str);
       f_TopicPos := l_StrPos;
       NotifyAboutNewTopic;
       if f_Settings.SkipMap.Has(f_TopicNo) then
       begin
        Report('намеренно пропущен (%s)', [l3Str(f_Settings.SkipMap.ValueByKey(f_TopicNo))]);
        SkipCurrentDocument;
       end;

       //l3System.Msg2Log(l3Str(f_TopicNo));
       {
       if l3Same('W20004638', f_TopicNo) then
        Random;
       }
       DropStr;
      end
      else
       if not l3IsNil(f_TopicNo) then // номер топика получен уже?
       begin
        if bcStarts(ccomFTEXT, l_Str) then
        begin
         l_Num := l3StrToIntDef(l3Trim(l_Str).AsWStr, -1);
         case l_Num of
          0: f_TextFormat := tfOEM;
          1: f_TextFormat := tfHTML;
          2: f_TextFormat := tfWord;
          3: f_TextFormat := tfXHTML;
         else
          f_TextFormat := tfUndefined;
         end;
         DropStr;
        end
        else

        if l3Same(ccomTXRUS, l_Str) then
        begin
         f_Text := Tl3MemoryStream.Create;
         l_TextFiler := Tl3CustomFiler.Create;
         try
          l_TextFiler.Stream := f_Text;
          l_TextFiler.Open;
          while not Filer.EOF do
          begin
           l_WStr := Filer.ReadLn;
           if not l3IsNil(l_WStr) and (l_WStr.S[0] = cc_DollarSign) then
            Break;
           l_TextFiler.WriteLn(l_WStr);
          end;
         finally
          FreeAndNil(l_TextFiler);
         end;
         if IsBelorussianLettersInText and not f_LangExplicit then
         begin
          Report('ВНИМАНИЕ: документ пропущен (похоже, он на белорусском языке, а команда LANG отсутствует)', []);
          DropData;
         end
         else
          FlushDocument;
         DropStr;
        end
        else

        if bcStarts(ccomVID, l_Str) then
        begin
         l_Str := l3Trim(l_Str);
         RemoveNumID(l_Str);
         l_TypeStr := l_Str;
         if f_Settings.TypesMap.Has(l_TypeStr) then
         begin
          l_TempStr := f_Settings.TypesMap.ValueByKey(l_TypeStr);
          if l3Same(l_TempStr, '-') then
          begin
           Report('в документе удален тип "%s"', [l3Str(l_TypeStr)]);
           l_TypeStr := nil;
          end
          else
           l_TypeStr := l_TempStr;
         end;
         f_Type := l_TypeStr;
         DropStr;
        end
        else

        if bcStarts(ccomORGAN, l_Str) then
        begin
         FreeAndNil(f_Sources);
         f_Sources := Tl3StringList.Make;
         ReadList(f_Sources);
        end
        else

        if bcStarts(ccomNAME, l_Str) then
        begin
         f_Name := l3Trim(l_Str);
         DropStr;
        end
        else

        if bcStarts(ccomUSLOV, l_Str) then
        begin
         f_Conditions := l3Trim(l_Str);
         if l3IsNil(f_Conditions) or l3Same(f_Conditions, '-') then
          f_Conditions := nil;
         DropStr;
        end
        else

        if bcStarts(ccomLANG, l_Str) then
        begin
         f_LangExplicit := True;
         if not l3Same('Р русский', l3Trim(l_Str)) then
          SkipCurrentDocument // Если язык явно указан не русским, то этот документ нам не нужен
         else
          DropStr;
        end
        else

        if bcStarts(ccomDPRIN, l_Str) then
        begin
         FreeAndNil(f_Dates);
         l_TempList := Tl3StringList.Make;
         try
          ReadList(l_TempList, False);
          if l_TempList.Count > 0 then
          begin
           f_Dates := Tl3LongintList.Make;
           for I := 0 to l_TempList.Hi do
            f_Dates.Add(ConvertDate(l_TempList.ItemC[I]));
          end;
         finally
          FreeAndNil(l_TempList);
         end;
        end
        else

        if bcStarts(ccomNPRIN, l_Str) then
        begin
         FreeAndNil(f_Nums);
         f_Nums := Tl3StringList.Make;
         ReadList(f_Nums, False);
        end
        else

        if bcStarts(ccomDVS, l_Str) then
        begin
         f_ActiveStart := ConvertDate(l3Trim(l_Str));
         DropStr;
        end
        else

        if bcStarts(ccomDOGR, l_Str) then
        begin
         f_ActiveEnd := ConvertDate(l3Trim(l_Str));
         DropStr;
        end
        else

        // Информация о регистрации в реестре
        if bcStarts(ccomDR, l_Str) then
        begin
         f_RegDate := ConvertDate(l3Trim(l_Str));
         DropStr;
        end
        else
        if bcStarts(ccomNRR, l_Str) then
        begin
         f_RegNum := l3Trim(l_Str);
         DropStr;
        end
        else

        // Информация о публикациях
        if bcStarts(ccomIST, l_Str) then
         LoadPubInfo(modPubInfoPubSource, True)
        else
        if bcStarts(ccomYEAR, l_Str) then
         LoadPubInfo(modPubInfoYear)
        else
        if bcStarts(ccomNUMB, l_Str) then
         LoadPubInfo(modPubInfoNum)
        else
        if bcStarts(ccomIN, l_Str) then
         LoadPubInfo(modPubInfoArticle)
        else
        if bcStarts(ccomIDAT, l_Str) then
         LoadPubInfo(modPubInfoPubDate)
        else

        // Информация о странах-участницах
        if bcStarts(ccomCOUNTR, l_Str) then
         LoadCountryInfo(modCountryRecName, True)
        else
        if bcStarts(ccomDTPODP, l_Str) then
         LoadCountryInfo(modCountryRecSigned)
        else
        if bcStarts(ccomDTRATF, l_Str) then
         LoadCountryInfo(modCountryRecRatify)
        else

        if bcStarts(ccomOTNFR, l_Str) then
        begin
         f_CancelDocNum := l3Trim(l_Str);
         DropStr;
        end
        else

        // доки, связанные с текущим
        if bcStarts(ccomUTVER, l_Str) then
         LoadRelDocs(rdAffirm)
        else
        if bcStarts(ccomIZMFR, l_Str) then
         LoadRelDocs(rdChange)
        else
        if bcStarts(ccomPRFR, l_Str) then
         LoadRelDocs(rdStop)
        else
        if bcStarts(ccomPDFR, l_Str) then
         LoadRelDocs(rdExtend)
        else
        if bcStarts(ccomVDFR, l_Str) then
         LoadRelDocs(rdContinue)
        else
        if bcStarts(ccomRDFR, l_Str) then
         LoadRelDocs(rdExpand)
        else
        if bcStarts(ccomPREEM, l_Str) then
         LoadRelDocs(rdSuccession)
        else
        if bcStarts(ccomRATF, l_Str) then
         LoadRelDocs(rdRatify)
        else
        if bcStarts(ccomPRIS, l_Str) then
         LoadRelDocs(rdJoin)
        else

         DropStr; // пропускаем необработанную строку
       end // if not l3IsNil(f_TopicNo)
       else
        DropStr; // номер топика не получен, пропускаем вообще всё до его получения
     end;
    end; // if not l3IsNil(l_Str)
   except
    on E: Exception do
    begin
     Report('ОШИБКА при преобразовании документа: %s', [E.Message]);
     if (E is EOutOfMemory) or (E is EAccessViolation) then
      l3System.Exception2Log(E);
     SaveErroneousTopic(f_TopicNo, E.Message); 
     DropData;
     DropStr;
    end;
   end; // try...except
  end; // while
 finally
  DropData;
 end;
end;

function TbcReader.RelDocsCount(aType: TbcRelatedDocTypes): Integer;
begin
 if f_RelDocs[aType] <> nil then
  Result := f_RelDocs[aType].Count
 else
  Result := 0;
end;

function TbcReader.RelDocsList(aType: TbcRelatedDocTypes): Tl3StringList;
begin
 if f_RelDocs[aType] = nil then
  f_RelDocs[aType] := Tl3StringList.Make;
 Result := f_RelDocs[aType];
end;

procedure TbcReader.RemoveNumID(var theStr: Il3CString);
var
 l_Pos: Integer;
 l_Temp: Tl3WString;
begin
 l_Pos := ev_lpCharIndex(cc_HardSpace, theStr.AsWStr);
 if (l_Pos <> l3NotFound) then
 begin
  l_Temp := l3Trim(l3Copy(theStr.AsWStr, 0, l_Pos+1));
  if l3StrToIntDef(l_Temp, -1) > 0 then // проверяем, что первое слово - число
   theStr := l3CStr(l3Trim(l3Copy(theStr.AsWStr, l_Pos)));
 end;
end;

procedure TbcReader.Report(const aMsg: string; const anArgs: array of const);
begin
 if Assigned(f_OnError) then
  f_OnError(Format(aMsg, anArgs));
end;

procedure TbcReader.SaveErroneousTopic(const aTopicNo: Il3CString; const aErrorDesc: AnsiString);
var
 l_DirName: AnsiString;
 l_EF: Tl3DOSFiler;
 l_Str: Tl3WString;
begin
 if l3IsNil(aTopicNo) then
  Exit;
 l_DirName := f_ErrorFolder;
 if l_DirName = '' then
  l_DirName := ConcatDirName(ExtractFileDir(ParamStr(0)), '_errors');
 ForceDirectories(l_DirName);
 l_EF := Tl3DOSFiler.Make(ConcatDirName(l_DirName, '_errors.txt'), l3_fmAppend);
 try
  l_EF.Open;
  l_EF.WriteLn(l3Cat([aTopicNo, l3CStr(': '), l3CStr(aErrorDesc)]).AsWStr);
 finally
  FreeAndNil(l_EF);
 end;
 l_EF := Tl3DOSFiler.Make(ConcatDirName(l_DirName, l3Str(aTopicNo)+'.txt'), l3_fmWrite);
 try
  l_EF.Open;
  Filer.Seek(f_TopicPos, soBeginning);
  repeat
   l_Str := Filer.ReadLn;
   l_EF.WriteLn(l_Str);
  until ((l_Str.SLen > 0) and (l_Str.S[0] = '$')) or Filer.EOF;
 finally
  FreeAndNil(l_EF);
 end;
end;

class function TbcReader.SetTo(var theGenerator : Tk2TagGenerator;
                             const aSettingsFilename: AnsiString;
                             const aTopicDispatcher: IbcTopicDispatcher;
                             const aOnError: TddErrorEvent = nil): Tk2TagGenerator;
begin
 Result := TbcReader.SetTo(theGenerator);
 TbcReader(Result).f_TopicDispatcher := aTopicDispatcher;
 TbcReader(Result).f_Settings := TbcSettings.Create(aSettingsFilename);
 if FileExists(aSettingsFilename) then
  TbcReader(Result).f_Settings.Process;
 TbcReader(Result).f_OnError := aOnError;
end;


end.
