unit GardocBridge;

{ $Id: GardocBridge.pas,v 1.22 2015/11/25 14:01:29 lukyanets Exp $ }

interface
 uses
  SysUtils,
  l3Date,
  ht_Const, ht_Dll,
  DT_Const, DT_Types, dt_AttrSchema, DT_Doc;

procedure AddToStageExchangeFile(aStages : TStageSet; aDocID : Integer; aUserID : TUserID);

procedure SetExchangeFileName(aExchangeFileName : string);

procedure OutListToStageExchangeFile(aExchangeFileName : TFileName; aMinDate, aMaxDate : TStDate);
//procedure OutListToStageExchangeFile2(aExchangeFileName : TFileName; aDocIDs : Sab);

implementation
 uses
  l3Types, l3Base, l3Stream, l3FileUtils,
  l3DateSt, l3DatLst,
  daSchemeConsts,
  dt_DictConst,
  DT_Query, Dt_ReNum, DT_LinkServ,
  DT_User, DT_Stage, dtIntf, DT_Sab;

 const
  ExchangeFileName : string = 'Stage.dat';

procedure SetExchangeFileName(aExchangeFileName : string);
begin
 ExchangeFileName := aExchangeFileName;
 MakeDir(ExtractFileDir(ExpandFileName(aExchangeFileName)));
end;

function GetGardocStageCode(aStageType : TStageType) : Integer;
begin
 case aStageType of
  stInput    : Result := 1001;
  stRead     : Result := 1002;
  stORead    : Result := 1102;
  stEdit     : Result := 1003;
  stOEdit    : Result := 1103;
  stClass    : Result := 503;
  stKW       : Result := 502;
  stUrObr    : Result := 501;
  stFinUrObr : Result := 1
  else         Result := 0;
 end;
end;

procedure AddToStageExchangeFile(aStages : TStageSet; aDocID : Integer; aUserID : TUserID);
var
 ltmpLoginName : ShortString;
 ltmpActFlag   : Byte;
 lUserName     : ShortString;
 lStage        : TStageType;
 lStream       : Tl3FileStream;
 lDataStr      : String;

begin
 try
  UserManager.GetUserInfo(aUserID, lUserName, ltmpLoginName, ltmpActFlag);
  lStream := Tl3FileStream.Create(ExchangeFileName,l3_fmExclusiveAppend);
  try
   for lStage := Low(TStageType) to High(TStageType) do
    If lStage in aStages then
    begin
     lDataStr := SysUtils.Format('%d|%d|%s|%s'#13#10,[aDocID, GetGardocStageCode(lStage),
                         l3DateToStr(Now, 'DD.MM.YYYY'),lUserName]);
     lStream.Write(lDataStr[1],Length(lDataStr));
    end;
  finally
   l3Free(lStream);
  end;
 except
  on E : Exception do l3System.Exception2Log(E);
 end;
end;

procedure OutListToStageExchangeFile(aExchangeFileName : TFileName; aMinDate, aMaxDate : TStDate);
var
 lStage        : TStageType;
 lStream       : Tl3FileStream;
 l_Query       : TdtQuery;
 lSab          : Sab;
 l_Docs        : ISab;
type
 PStageRec = ^TStageRec;
 TStageRec = packed record
              rDocID  : TDocID;
              rStType : Byte;
              rEDate  : TStDate;
              rAuthor : TUserID;
             end;

 procedure OutListToStream(aStagesList : Tl3CustomDataList; aStream : Tl3FileStream);
 var
  I             : Integer;
  lDataStr      : String;
  ltmpLoginName : ShortString;
  ltmpActFlag   : Byte;
  lUserName     : ShortString;
  lGardocStageCode : Integer;
 begin
  for I := 0 to pred(aStagesList.Count) do
   with PStageFullRec(aStagesList.Data[I])^ do
   begin
    UserManager.GetUserInfo(Author, lUserName, ltmpLoginName, ltmpActFlag);

    lGardocStageCode := GetGardocStageCode(TStageType(StType));
    if lGardocStageCode > 0 then
    begin
    //lExtDocID := DocumentServer.ReNumTbl.ConvertToImportNumber(DocID); уже внешние номера
     lDataStr := SysUtils.Format('%d|%d|%s|%s'#13#10,[ DocID {lExtDocID}, lGardocStageCode,
                         l3DateToStr(EDate, 'DD.MM.YYYY'), lUserName]);
     aStream.Write(lDataStr[1],Length(lDataStr));
    end;
   end;
 end;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 var
  lUserName : ShortString;
  lGardocStageCode : Integer;
  lDataStr      : String;

  ltmpLoginName : ShortString;
  ltmpActFlag   : Byte;
 begin
  Result := True;
  with PStageRec(aItemPtr)^ do
  begin
   lGardocStageCode := GetGardocStageCode(TStageType(rStType));
   if lGardocStageCode > 0 then
   begin
    UserManager.GetUserInfo(rAuthor, lUserName, ltmpLoginName, ltmpActFlag);
    lDataStr := SysUtils.Format('%d|%d|%s|%s'#13#10, [rDocID, lGardocStageCode, l3DateToStr(rEDate, 'DD.MM.YYYY'), lUserName]);
    lStream.Write(lDataStr[1],Length(lDataStr));
   end;
  end;
 end;

 var
  lRAProcStub : TdtRecAccessProc;

 var
  lRecByDates : ISab;
  lUserSab    : ISab;
  lRenumSab   : ISab;
  lJoinSab    : IJoinSab;
begin
 try
   lStream := Tl3FileStream.Create(aExchangeFileName, l3_fmExclusiveAppend);
   try
    // выводим все новые этапы за период
    lRecByDates := MakeSab(LinkServer(CurrentFamily).Attribute[atStages]);

    aMinDate := StDateToDemon(aMinDate);
    aMaxDate := StDateToDemon(aMaxDate);
    lRecByDates.Select(stEDate_Key, aMinDate, aMaxDate);

    // + все этапы для документов залитых за период
    l_Query := TdtLogByActionQuery.Create(acWasImported, aMinDate, aMaxDate);
    try
     if not l_Query.IsEmpty then
     begin
      //lStagesList.Clear;
      l_Docs := l_Query.GetDocIdList;
      try
       l_Docs.RecordsByKey(stDocID_Key, lRecByDates);
       lRecByDates.OrSab(l_Docs);
      finally
       l_Docs := nil;
      end;
     end;
    finally
     l3Free(l_Query);
    end;
    //

    if lRecByDates.Count <> 0 then
    begin
     lUserSab := MakeAllRecords(UserManager.UserTbl);
     lUserSab.ValuesOfKey(dtIDFld);
     lUserSab.RecordsByKey(stAuthor_Key, lRecByDates);
     lRecByDates.AndSab(lUserSab);
    end;

    lRenumSab := MakeAllRecords(LinkServer(CurrentFamily)[atRenum]);

    lJoinSab := MakeJoinSab(lRecByDates, stDocID_Key,
                            lRenumSab, rnRealID_fld);

    lRAProcStub := L2RecAccessProc(@lRecAccessProc);
    try
     lJoinSab.IterateJoinRecords(lRAProcStub, [JFRec(lRenumSab.Table,   rnImportID_fld),
                                               JFRec(lRecByDates.Table, stType_Key),
                                               //JFRec(lRecByDates.Table, stBDate_Key),
                                               JFRec(lRecByDates.Table, stEDate_Key),
                                               JFRec(lRecByDates.Table, stAuthor_Key)]);
    finally
     FreeRecAccessProc(lRAProcStub);
    end;

   finally
    l3Free(lStream);
   end;
 
 except
  on E : Exception do
  begin
   l3System.Exception2Log(E);
   raise;
  end;
 end;
end;

(*procedure OutListToStageExchangeFile2(aExchangeFileName : TFileName; aDocIDs :  Sab);
var
 lStage        : TStageType;
 lStream       : Tl3FileStream;
 lStagesList   : Tl3CustomDataList;
 lSab          : Sab;

 procedure OutListToStream(aStagesList : Tl3CustomDataList; aStream : Tl3FileStream);
 var
  I             : Integer;
  lDataStr      : String;
  ltmpLoginName : ShortString;
  ltmpActFlag   : Byte;
  lUserName     : ShortString;
  //lExtDocID     : TDocID;
  lGardocStageCode : Integer;
 begin
  for I := 0 to pred(aStagesList.Count) do
   with PStageFullRec(aStagesList.Data[I])^ do
   begin
    UserManager.GetUserInfo(Author, lUserName, ltmpLoginName, ltmpActFlag);

    lGardocStageCode := GetGardocStageCode(TStageType(StType));
    if lGardocStageCode > 0 then
    begin
    //lExtDocID := DocumentServer.ReNumTbl.ConvertToImportNumber(DocID); уже внешние номера
     lDataStr := SysUtils.Format('%d|%d|%s|%s'#13#10,[ DocID {lExtDocID}, lGardocStageCode,
                         l3DateToStr(EDate, 'DD.MM.YYYY'), lUserName]);
     aStream.Write(lDataStr[1],Length(lDataStr));
    end; 
   end;
 end;

begin
 try
  lStagesList := Tl3DataList.Create;
  try
   lStream := Tl3FileStream.Create(aExchangeFileName, l3_fmExclusiveAppend);
   try
     LinkServer(CurrentFamily).Stages.StagesOnDocs(aDocIDs, lStagesList);
     OutListToStream(lStagesList, lStream);
   finally
    l3Free(lStream);
   end;
  finally
   l3Free(lStagesList);
  end;
 except
  on E : Exception do
  begin
   l3System.Exception2Log(E);
   raise;
  end;
 end;
end;
*)
end.
