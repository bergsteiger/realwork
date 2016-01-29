unit mdpSourceSync;

{ $Id: mdpSourceSync.pas,v 1.5 2015/08/27 09:47:14 fireton Exp $ }

{$IFDEF MDP_TEST}
 {$DEFINE MDP_TOFILE}
{$ENDIF}


interface
uses
 l3BaseStream,
 dtIntf;

const
 cMdpSourceSyncVersion = 2;

type
 PmssProxySettingsRec = ^TmssProxySettingsRec;
 TmssProxySettingsRec = packed record
  rServer  : AnsiString;
  rPort    : Integer;
  rLogin   : AnsiString;
  rPassword: AnsiString;
 end;

 TmssOperation = (ssoAll, ssoNew, ssoDel, ssoUpd);

const
 c_mssOperationStr: array[TmssOperation] of AnsiString = ('all', 'new', 'del', 'upd');

procedure ExportSourcesToXML(const aStream: Tl3Stream; const aSrcList: ISab = nil; aOperation: TmssOperation = ssoAll);
 // aSrcList - саб с набором idшников

procedure SyncSources(const anURL : AnsiString;
                      aProxy: PmssProxySettingsRec = nil;
                      aOperation: TmssOperation = ssoAll;
                      const aSrcList: ISab = nil);

implementation
uses
 SysUtils,

 daTypes,
 daDataProvider,

 dt_Types,
 dt_Const,
 dt_Dict,
 dt_DictConst,
 dt_Sab,
 l3Types,
 l3Base,
 l3Interfaces,
 l3XMLWriter,
 l3Writer,
 l3String,
 l3Memory,

 IdHTTP,

 l3Filer,
 l3Stream,
 IdHTTPHeaderInfo,
 l3LongintList;

type
 PSourceSyncRec = ^TSourceSyncRec;
 TSourceSyncRec = packed record
  rID        : TDictID;
  rShortName : array[1..cSourceShortNameLen] of AnsiChar;
  rSynonims  : array[1..cSourceSynonimsLen] of AnsiChar;
 end; 

procedure ExportSourcesToXML(const aStream: Tl3Stream; const aSrcList: ISab = nil; aOperation: TmssOperation = ssoAll);
var
 l_Sab: ISab;
 l_SC : ISabCursor;
 I : Integer;
 l_List: Tl3LongintList;
 l_Src: PSourceSyncRec;
 l_XML: Il3XMLWriter;
 l_Path: AnsiString;
 l_SynsStr: Il3CString;

 procedure PutField(const aName, aData: AnsiString);
 begin
  l_XML.OpenLevel(aName);
  try
   l_XML.PutData(aData);
  finally
   l_XML.CloseLevel;
  end;
 end;

 function DoOneSynonim(const aStr: Tl3PCharLen; aIsLast: Bool): Bool;
 begin
  Result := True;
  l_XML.OpenSubLevel;
  try
   l_XML.PutData(l3Trim(aStr));
  finally
   l_XML.CloseLevel;
  end;
 end;

begin
 if aSrcList = nil then
 begin
  l_Sab := MakeAllRecords(DictServer(CurrentFamily).DictTbl[da_dlSources]);
  aOperation := ssoAll;
 end
 else
 begin
  if aOperation <> ssoDel then
  begin
   l_Sab := MakeSabCopy(aSrcList);
   l_Sab.TransferToPhoto(dtIDFld, DictServer(CurrentFamily).DictTbl[da_dlSources]);
   l_Sab.RecordsByKey;
  end;
 end;

 l_XML := Tl3XMLWriter.Make(aStream);
 // Генерируем начало XML
 l_XML.OpenLevel('data', Format('version="%d" region="%d" operation="%s"', [cMdpSourceSyncVersion,
   GlobalDataProvider.RegionID, c_mssOperationStr[aOperation]]));
 try
  if aOperation = ssoDel then
  begin
   l_List := Tl3LongintList.Make;
   try
    dtCopyValuesSabToList(aSrcList, l_List);
    for I := 0 to Pred(l_List.Count) do
    begin
     l_XML.OpenLevel('element', Format('id="%d"', [l_List[I]]));
     l_XML.CloseLevel;
    end;
   finally
    FreeAndNil(l_List);
   end;
  end
  else
  begin
   l_SC := l_Sab.MakeSabCursor([dtIDFld, dtShNameFld, dtSinonimsFld]);
   for I := 0 to Pred(l_SC.Count) do
   begin
    l_Src := l_SC.GetItem(I);
    l_Path := DictServer(CurrentFamily).Dict[da_dlSources].GetFullDictItemName(l_Src.rID, False);
    if l_Path <> '' then
    begin
     l_XML.OpenLevel('element', Format('id="%d"', [l_Src.rID]));
     try
      PutField('path', l_Path);
      PutField('short', l3ArrayToString(l_Src.rShortName, cSourceShortNameLen));
      l_XML.OpenLevel('syns');
      try
       l_SynsStr := l3ArrayToCString(l_Src.rSynonims, cSourceSynonimsLen);
       if not l3IsNil(l_SynsStr) then
        l3ParseWordsExF(l_SynsStr.AsWStr, l3L2WA(@DoOneSynonim), [';']);
      finally
       l_XML.CloseLevel; // syns
      end;
     finally
      l_XML.CloseLevel; // element
     end;
    end; // if l_Path <> ''
   end;
  end;
 finally
  l_XML.CloseLevel; // data
 end;
end;

procedure SyncSources(const anURL : AnsiString;
                      aProxy: PmssProxySettingsRec = nil;
                      aOperation: TmssOperation = ssoAll;
                      const aSrcList: ISab = nil);
var
 {$IFDEF MDP_TOFILE}
 l_FS: Tl3FileStream;
 {$ELSE}
 l_Data: Tl3MemoryStream;
 l_HTTP: TIdHTTP;
 l_Respond: AnsiString;
 {$ENDIF}
begin
 {$IFDEF MDP_TOFILE}
 l_FS := Tl3FileStream.Create('c:\temp\sources.xml', l3_fmWrite);
 try
  ExportSourcesToXML(l_FS, aSrcList, aOperation);
 finally
  FreeAndNil(l_FS);
 end;
 {$ELSE}
 l_Data := Tl3MemoryStream.Make;
 try
  ExportSourcesToXML(l_Data, aSrcList, aOperation);
  l_Data.Position := 0;
  l_HTTP := TIdHTTP.Create;
  try
   //l_HTTP.Request.CharSet := 'windows-1251';
   if aProxy <> nil then
   begin
    // настраиваем тут прокси
    with l_HTTP.ProxyParams do
    begin
     ProxyServer := aProxy.rServer;
     ProxyPort   := aProxy.rPort;
     ProxyUsername := aProxy.rLogin;
     ProxyPassword := aProxy.rPassword;
     BasicAuthentication := True;
    end;
   end;
   try
    l_Respond := l_HTTP.Post(anURL, l_Data);
    {
    l_FS := Tl3DOSFiler.Make('c:\temp\respond.html', l3_fmWrite);
    try
     l_FS.Open;
     l_FS.Write(l_Respond);
    finally
     FreeAndNil(l_FS);
    end;
    }
    l3System.Msg2Log('ОГВ синхронизированы успешно');
   except
    on E: Exception do
     l3System.Msg2Log('ОШИБКА синхронизации ОГВ: %s', [E.Message]);
   end;
  finally
   FreeAndNil(l_HTTP);
  end;
 finally
  FreeAndNil(l_Data);
 end;
 {$ENDIF}
end;


end.