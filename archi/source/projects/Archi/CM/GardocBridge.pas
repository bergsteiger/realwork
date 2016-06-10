unit GardocBridge;

{ $Id: GardocBridge.pas,v 1.26 2016/05/19 07:33:30 fireton Exp $ }

interface
 uses
  SysUtils,
  l3Date,
  ht_Const, ht_Dll, l3BaseStream,
  DT_Const, DT_Types, dt_AttrSchema, DT_Doc;

procedure OutListToStageExchange(aStream: Tl3Stream; aMinDate, aMaxDate : TStDate);
procedure OutListToStageExchangeFile(aExchangeFileName : TFileName; aMinDate, aMaxDate : TStDate);

implementation
 uses
  l3Types, l3Base,  l3FileUtils,
  l3DateSt, l3DatLst, l3Stream,
  daSchemeConsts,
  daDataProvider,
  dt_DictConst,
  DT_Query, Dt_ReNum, DT_LinkServ,
  DT_User, DT_Stage, dtIntf, DT_Sab;

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

procedure OutListToStageExchange(aStream: Tl3Stream; aMinDate, aMaxDate : TStDate);
var
 lStage        : TStageType;
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

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 var
  lUserName : String;
  lGardocStageCode : Integer;
  lDataStr      : String;
  ltmpLoginName : String;
  ltmpActFlag   : Byte;
 begin
  Result := True;
  with PStageRec(aItemPtr)^ do
  begin
   lGardocStageCode := GetGardocStageCode(TStageType(rStType));
   if lGardocStageCode > 0 then
   begin
    GlobalDataProvider.UserManager.GetUserInfo(rAuthor, lUserName, ltmpLoginName, ltmpActFlag);
    lDataStr := SysUtils.Format('%d|%d|%s|%s'#13#10, [rDocID, lGardocStageCode, l3DateToStr(rEDate, 'DD.MM.YYYY'), lUserName]);
    aStream.Write(lDataStr[1],Length(lDataStr));
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
   lUserSab := MakeAllRecords(UserManager.xxxUserTbl);
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

 except
  on E : Exception do
  begin
   l3System.Exception2Log(E);
   raise;
  end;
 end;
end;

procedure OutListToStageExchangeFile(aExchangeFileName : TFileName; aMinDate, aMaxDate : TStDate);
var
 l_Stream: Tl3FileStream;
begin
 l_Stream := Tl3FileStream.Create(aExchangeFileName, l3_fmExclusiveAppend);
 try
  OutListToStageExchange(l_Stream, aMinDate, aMaxDate);
 finally
  l3Free(l_Stream);
 end;
end;

end.
