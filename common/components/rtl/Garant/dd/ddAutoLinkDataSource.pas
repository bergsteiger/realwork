unit ddAutoLinkDataSource;

{ $Id: ddAutoLinkDataSource.pas,v 1.18 2015/07/02 07:36:05 lukyanets Exp $ }

// $Log: ddAutoLinkDataSource.pas,v $
// Revision 1.18  2015/07/02 07:36:05  lukyanets
// Описываем словари
//
// Revision 1.17  2015/04/07 07:37:06  lukyanets
// Изолируем HT
//
// Revision 1.16  2014/09/19 10:15:35  fireton
// - избавляемся от m3IsStorageExists и m3DeleteStorage
//
// Revision 1.15  2014/06/20 12:50:34  fireton
// - пилим автолинковщик на базовые классы
//
// Revision 1.14  2014/04/17 13:04:46  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.13  2013/04/11 17:14:58  lulin
// - отлаживаем под XE3.
//
// Revision 1.12  2013/04/11 16:46:27  lulin
// - отлаживаем под XE3.
//
// Revision 1.11  2012/11/29 04:48:48  fireton
// - bugfix: не работало определение наличия на диске кэша структур
//
// Revision 1.10  2012/11/22 09:57:04  fireton
// - поддержка splitted storage
//
// Revision 1.9  2012/08/20 09:17:47  fireton
// - улучшенная диагностика ошибок (K 385484738)
//
// Revision 1.8  2012/08/14 11:37:21  fireton
// - отдельное поле номера дела в кэше автопростановщика
//
// Revision 1.7  2012/03/13 13:43:14  fireton
// - распознаём и ставим ссылки с учётом номера дела, к которому принадлежит документ
//
// Revision 1.6  2011/06/02 12:13:20  fireton
// - держим таблицы автопростановки ссылок постоянно открытыми
//
// Revision 1.5  2011/05/19 14:10:26  fireton
// - не искались статьи в кодексах
//
// Revision 1.4  2011/05/13 14:31:53  fireton
// - слияние с веткой
//
// Revision 1.3.2.1  2011/05/06 12:26:10  fireton
// - двойной кэш автопростановщика
//
// Revision 1.3  2011/04/13 10:50:20  fireton
// - переводим простановку ссылок на внешние номера документов
//
// Revision 1.2  2011/03/01 13:23:02  fireton
// - кэш данных для простановщика ссылок
//
// Revision 1.1  2011/02/11 17:10:25  fireton
// - отпиливаем простановщик от основной базы
//

interface
uses
 l3Types,
 l3Interfaces,
 l3ProtoObject,
 l3Date,
 l3LongintList,

 HT_Const,

 DT_Types,
 dtIntf,
 DT_Sab,
 DT_Query,
 DT_TAble,

 ddTypes,
 ddDocStructBase,
 ddDocStruct,
 ddAutolinkCache,
 ddBaseAutolinkDataSource
 ;

type
 TddDBAutolinkDataSource = class(TddBaseAutolinkDataSource)
 private
  f_Query: TdtAndQuery;
  procedure ErrorQueryNotStarted;
  procedure ErrorQueryAlreadyStarted;
 protected
  function DoGetContemporalEdition(const aExtDocID: TDocID; const aDate: TStDate): TddALDocRec; override;
 public
  procedure StartDocQuery; override;
  procedure FilterByDocType(aDocType: TDictID); override;
  procedure FilterByCasecode(const aCaseCode: Tl3PCharLen); override;
  procedure FilterByDateNum(aDate: TStDate; const aNum: Tl3PCharLen); override;
  procedure FilterBySources(const aSources: Tl3LongintList); override;
  procedure FilterByActualEditions; override;
  function ExecuteDocQuery: TddALDocRec; override;
  procedure CleanupDocQuery; override;
 end;

 TddCacheAutolinkDataSource = class(TddBaseAutolinkDataSource)
 private
  f_Sab: ISab;
  f_NewQuery: Boolean;
  f_Type: TddAutolinkCacheType;
  f_StructCache: TddDocStructCache;
 private
  procedure CheckIfQueryStarted;
  procedure DoQuery(const aField: ThtField; const aValue);
 protected
  procedure Cleanup; override;
  function DoGetContemporalEdition(const aExtDocID: TDocID; const aDate: TStDate): TddALDocRec; override;
 public
  constructor Create(aType: TddAutolinkCacheType; aOnError: TddErrorEvent);
  procedure StartDocQuery; override;
  procedure FilterByDocType(aDocType: TDictID); override;
  procedure FilterByCasecode(const aCaseCode: Tl3PCharLen); override;
  procedure FilterByDateNum(aDate: TStDate; const aNum: Tl3PCharLen); override;
  procedure FilterBySources(const aSources: Tl3LongintList); override;
  procedure FilterByActualEditions; override;
  function ExecuteDocQuery: TddALDocRec; override;
  function FindBlock(const aDocID: TDocID; const aEntryAddr: TddDocStructElementRec): Longint; override;
  procedure CleanupDocQuery; override;
 end;

 TddDualAutolinkDataSource = class(TddBaseAutolinkDataSource)
 private
  f_Casecode: Tl3PCharLen;
  f_CurSource: TddAutolinkCacheType;
  f_Date: TStDate;
  f_DocType: TDictID;
  f_FilterByActualEditions: Boolean;
  f_DataSources: array[TddAutolinkCacheType] of TddCacheAutolinkDataSource;
  f_DSIsFixed: Boolean;
  f_Num: Tl3PCharLen;
  f_Sources: Tl3LongintList;
  function pm_GetCurDS: TddCacheAutolinkDataSource;
  function pm_GetIsValidDS: Boolean;
  property CurDS: TddCacheAutolinkDataSource read pm_GetCurDS;
  property IsValidDS: Boolean read pm_GetIsValidDS;
 protected
  procedure Cleanup; override;
  function DoGetContemporalEdition(const aExtDocID: TDocID; const aDate: TStDate): TddALDocRec; override;
 public
  constructor Create(aOnError: TddErrorEvent);
  procedure StartDocQuery; override;
  procedure DocumentAlreadyDefined; override;
  procedure FilterByDocType(aDocType: TDictID); override;
  procedure FilterByCasecode(const aCaseCode: Tl3PCharLen); override;
  procedure FilterByDateNum(aDate: TStDate; const aNum: Tl3PCharLen); override;
  procedure FilterBySources(const aSources: Tl3LongintList); override;
  procedure FilterByActualEditions; override;
  function ExecuteDocQuery: TddALDocRec; override;
  procedure CleanupDocQuery; override;
  function FindBlock(const aDocID: TDocID; const aEntryAddr: TddDocStructElementRec): Longint; override;
 end;

implementation
uses
 SysUtils,

 l3Except,
 l3String,
 l3LongintListPrim,
 l3Base,

 daDataProvider,
 daTypes,

 DT_Const,
 DT_SrchQueries,
 DT_Doc,
 DT_AttrSchema,
 DT_LinkServ,
 DT_Record,
 Dt_ReNum,

 m3StgMgr,

 ddAutolinkServer;

type
 PddAbsNumRec = ^TddAbsNumRec;
 TddAbsNumRec = packed record
  rALRec : TddALDocRec;
  rAbsNum: Cardinal;
 end;


//** TddDBAutolinkDataSource **//

function TddDBAutolinkDataSource.DoGetContemporalEdition(const aExtDocID: TDocID; const aDate: TStDate): TddALDocRec;
var
 l_Query: TdtAndQuery;
 l_Q: TdtQuery;
 l_SC: ISabCursor;
 l_IntDocID: TDocID;
begin
 l_IntDocID := aExtDocID;
 LinkServer(CurrentFamily).Renum.GetRNumber(l_IntDocID);
 l_Query := TdtAndQuery.Create;
 try
  l_Q := TdtDocVersionsQuery.Create(l_IntDocID);
  l_Query.AddQueryF(l_Q);
  l_Q := TdtActiveQuery.Create([asActive], aDate);
  l_Query.AddQueryF(l_Q);
  if l_Query.FoundList.Count = 1 then
  begin
   // получаем первый документ из l_Query.FoundList
   l_SC := l_Query.FoundList.MakeSabCursor([fId_Fld], cmForward);
   Result := ddFillALDocRecFromIntDocID(PDocID(l_SC.GetItem(0))^);
   l_SC := nil;
  end
  else
  begin
   Result.rIntDocID := -1;
   Result.rExtDocID := -1;
  end;
 finally
  FreeAndNil(l_Query);
 end;
end;

procedure TddDBAutolinkDataSource.CleanupDocQuery;
begin
 if f_Query <> nil then
 begin
  FreeAndNil(f_Query);
 end
 else
  ErrorQueryNotStarted;
end;

procedure TddDBAutolinkDataSource.ErrorQueryAlreadyStarted;
begin
 raise EddAutoLinkDataSourceError.Create('TddDBAutolinkDataSource: Query already started');
end;

procedure TddDBAutolinkDataSource.ErrorQueryNotStarted;
begin
 raise EddAutoLinkDataSourceError.Create('TddDBAutolinkDataSource: Query not started');
end;

function TddDBAutolinkDataSource.ExecuteDocQuery: TddALDocRec;
var
 l_SC: ISabCursor;
begin
 Result.rIntDocID := cBlankDocID;
 if f_Query <> nil then
 begin
  if not f_Query.IsEmpty then
  begin
   if f_Query.FoundList.Count = 1 then
   begin
    // получаем первый документ из l_Query.FoundList
    l_SC := f_Query.FoundList.MakeSabCursor([fId_Fld], cmForward);
    Result := ddFillALDocRecFromIntDocID(PDocID(l_SC.GetItem(0))^);
    l_SC := nil;
   end
   else
    Result.rIntDocID := TDocID(cUndefDocID);
  end;
 end
 else
  ErrorQueryNotStarted;
end;

procedure TddDBAutolinkDataSource.FilterByActualEditions;
var
 l_DocType: TUserType;
 l_Q: TdtQuery;
begin
 if f_Query <> nil then
 begin
  l_DocType := utEdition;
  l_Q := TdtMainAttrQuery.Create(fUserType_Fld, l_DocType);
  SQNot(l_Q);
  f_Query.AddQueryF(l_Q);
 end
 else
  ErrorQueryNotStarted;
end;

procedure TddDBAutolinkDataSource.FilterByCasecode(const aCaseCode: Tl3PCharLen);
var
 l_Q: TdtQuery;
begin
 if f_Query <> nil then
 begin
  l_Q := TdtDateNumQuery.Create(0, 0, l3Str(aCaseCode), dnLawCaseNum);
  f_Query.AddQueryF(l_Q);
 end
 else
  ErrorQueryNotStarted;
end;

procedure TddDBAutolinkDataSource.FilterByDateNum(aDate: TStDate; const aNum: Tl3PCharLen);
var
 l_Q: TdtQuery;
begin
 if f_Query <> nil then
 begin
  l_Q := TdtDateNumQuery.Create(aDate, aDate, l3Str(aNum), dnPublish);
  f_Query.AddQueryF(l_Q);
 end
 else
  ErrorQueryNotStarted;
end;

procedure TddDBAutolinkDataSource.FilterByDocType(aDocType: TDictID);
var
 l_Q: TdtQuery;
begin
 if f_Query <> nil then
 begin
  l_Q := TdtDictQuery.Create(da_dlTypes, aDocType, False, False, True);
  f_Query.AddQueryF(l_Q);
 end
 else
  ErrorQueryNotStarted;
end;

procedure TddDBAutolinkDataSource.FilterBySources(const aSources: Tl3LongintList);
var
 l_Q: TdtQuery;
begin
 if f_Query <> nil then
 begin
  l_Q := TdtDictQuery.Create(da_dlSources, aSources);
  f_Query.AddQueryF(l_Q);
 end
 else
  ErrorQueryNotStarted;
end;

procedure TddDBAutolinkDataSource.StartDocQuery;
begin
 if f_Query = nil then
  f_Query := TdtAndQuery.Create
 else
  ErrorQueryAlreadyStarted;
end;

constructor TddCacheAutolinkDataSource.Create(aType: TddAutolinkCacheType; aOnError: TddErrorEvent);
begin
 inherited Create(aOnError);
 f_Type := aType;
 f_StructCache := TddDocStructCache.Create(GetAutolinkStructCacheFilePath(f_Type), GlobalDataProvider.TextBase[CurrentFamily], False);
end;

procedure TddCacheAutolinkDataSource.CheckIfQueryStarted;
begin
 if f_Sab = nil then
  raise EddAutoLinkDataSourceError.Create('TddCacheAutolinkDataSource: Query not started');
end;

procedure TddCacheAutolinkDataSource.Cleanup;
begin
 FreeAndNil(f_StructCache);
 inherited;
end;

procedure TddCacheAutolinkDataSource.CleanupDocQuery;
begin
 f_Sab := nil;
end;

function TddCacheAutolinkDataSource.DoGetContemporalEdition(const aExtDocID: TDocID; const aDate: TStDate): TddALDocRec;
var
 l_Sab: ISab;
 l_SC : ISabCursor;
 l_AbsNum: Cardinal;
 l_Rec: TdtRecord;
begin
 Result.rIntDocID := -1;
 Result.rExtDocID := -1;
 l_Sab := MakeSab(AutolinkServer(CurrentFamily).GetAutolinkCacheVersionsTableInfo(f_Type));
 l_Sab.Select(falvMasterDocID, aExtDocID);
 l_Sab.SubSelect(falvStart, aDate, LESS_EQUAL);
 l_Sab.SubSelect(falvFinish, aDate, GREAT_EQUAL);
 if l_Sab.Count = 1 then
 begin
  l_SC := l_Sab.MakeSabCursor([falvIntDocID, falvExtDocID, AbsNumFld], cmForward);
  Result := PddALDocRec(l_SC.GetItem(0))^;
  if Result.rIntDocID = 0 then
  begin
   Result := ddFillALDocRecFromExtDocID(Result.rExtDocID);
   l_AbsNum := PddAbsNumRec(l_SC.GetItem(0))^.rAbsNum;
   l_Rec := InitRecord(l_Sab.Table);
   l_Rec.FindByUniq(AbsNumFld, l_AbsNum);
   l_Rec.Get(True);
   try
    l_Rec.FillField(falvIntDocID, [Result.rIntDocID]);
    l_Rec.Update;
   finally
    l_Rec.Unlock;
   end;
  end;
 end;
end;

procedure TddCacheAutolinkDataSource.DoQuery(const aField: ThtField; const aValue);
begin
 CheckIfQueryStarted;
 if f_NewQuery then
 begin
  f_Sab.Select(aField, aValue);
  f_NewQuery := False;
 end
 else
  f_Sab.Subselect(aField, aValue);
end;

function TddCacheAutolinkDataSource.ExecuteDocQuery: TddALDocRec;
var
 l_SC : ISabCursor;
 I: Integer;
 l_AbsNum: Cardinal;
 l_Rec: TdtRecord;
begin
 CheckIfQueryStarted;
 Result.rIntDocID := cBlankDocID;
 if f_Sab.Count > 0 then
 begin
  l_SC := f_Sab.MakeSabCursor([falmIntDocID, falmExtDocID, AbsNumFld], cmForward);
  Result := PddALDocRec(l_SC.GetItem(0))^;
  if Result.rIntDocID = 0 then
  begin
   Result := ddFillALDocRecFromExtDocID(Result.rExtDocID);
   l_AbsNum := PddAbsNumRec(l_SC.GetItem(0))^.rAbsNum;
   l_Rec := InitRecord(f_Sab.Table);
   l_Rec.FindByUniq(AbsNumFld, l_AbsNum);
   l_Rec.Get(True);
   try
    l_Rec.FillField(falmIntDocID, [Result.rIntDocID]);
    l_Rec.Update;
   finally
    l_Rec.Unlock;
   end;
  end;
  for I := 1 to l_SC.Count - 1 do
   if Result.rExtDocID <> PddALDocRec(l_SC.GetItem(I))^.rExtDocID then
   begin
    Result.rIntDocID := TDocID(cUndefDocID);
    Exit;
   end;
 end;
end;

procedure TddCacheAutolinkDataSource.FilterByActualEditions;
begin
 // уже отфильтровано на этапе построения кэша
end;

procedure TddCacheAutolinkDataSource.FilterByCasecode(const aCaseCode: Tl3PCharLen);
var
 l_Num: TNumberStr;
begin
 if not l3IsNil(aCaseCode) then
 begin
  l3PCharLenToArray(l_Num, cDNNumberLen, aCaseCode);
  DoQuery(falmLawCase, l_Num);
 end;
end;

procedure TddCacheAutolinkDataSource.FilterByDateNum(aDate: TStDate; const aNum: Tl3PCharLen);
var
 l_Num: TNumberStr;
begin
 if aDate > 0 then
  DoQuery(falmDate, aDate);
 if not l3IsNil(aNum) then
 begin
  l3PCharLenToArray(l_Num, cDNNumberLen, aNum);
  DoQuery(falmNumber, l_Num);
 end;
end;

procedure TddCacheAutolinkDataSource.FilterByDocType(aDocType: TDictID);
begin
 DoQuery(falmType, aDocType);
end;

procedure TddCacheAutolinkDataSource.FilterBySources(const aSources: Tl3LongintList);
var
 l_Table: ITblInfo;
 l_ResultSab, l_Sab  : ISab;
 I, l_Value: Integer;
begin
 CheckIfQueryStarted;
 if aSources.Count > 0 then
 begin
  l_Table := f_Sab.Table;
  for I := 0 to aSources.Count - 1 do
  begin
   l_Sab := MakeSab(l_Table);
   l_Value := aSources.Items[I];
   l_Sab.Select(falmSource, l_Value);
   if l_ResultSab = nil then
    l_ResultSab := l_Sab
   else
    l_ResultSab.OrSab(l_Sab);
  end;
  if f_NewQuery then
  begin
   f_Sab := l_ResultSab;
   f_NewQuery := False;
  end 
  else
   f_Sab.AndSab(l_ResultSab);
 end;
end;

function TddCacheAutolinkDataSource.FindBlock(const aDocID: TDocID; const aEntryAddr: TddDocStructElementRec): Longint;
begin
 Result := f_StructCache.FindBlock(aDocID, aEntryAddr);
end;

procedure TddCacheAutolinkDataSource.StartDocQuery;
begin
 f_Sab := MakeSab(AutolinkServer(CurrentFamily).GetAutolinkCacheMainTableInfo(f_Type));
 f_NewQuery := True;
end;

constructor TddDualAutolinkDataSource.Create(aOnError: TddErrorEvent);
var
 l_ALS: TddAutolinkServer;
 l_CType: TddAutolinkCacheType;
 l_SCFN: AnsiString;
 l_TblInfo: ITblInfo;
begin
 inherited Create(aOnError);
 for l_CType := dsLocal to dsRemote do
 begin
  l_SCFN := GetAutolinkStructCacheFilePath(l_CType);
  if Tm3StorageManager.StorageFileExists(l_SCFN) then
  begin
   l_ALS := AutolinkServer(CurrentFamily);
   try
    l_TblInfo := l_ALS.GetAutolinkCacheMainTableInfo(l_CType);
    l_TblInfo := l_ALS.GetAutolinkCacheVersionsTableInfo(l_CType);
    l_TblInfo := nil;
    f_DataSources[l_CType] := TddCacheAutolinkDataSource.Create(l_CType, aOnError);
   except
    on E : EAutoLinkBadCache do
     DoError(E.Message);
   end;
  end;
 end; // for
end;

procedure TddDualAutolinkDataSource.Cleanup;
begin
 FreeAndNil(f_DataSources[dsLocal]);
 FreeAndNil(f_DataSources[dsremote]);
 inherited;
end;

procedure TddDualAutolinkDataSource.CleanupDocQuery;
begin
 f_Casecode.Init;
 f_Date := 0;
 f_Num.Init;
 f_Sources := nil;
 f_DocType := 0;
 f_FilterByActualEditions := False;
end;

procedure TddDualAutolinkDataSource.DocumentAlreadyDefined;
begin
 f_DSIsFixed := False;
 f_CurSource := dsLocal;
end;

function TddDualAutolinkDataSource.DoGetContemporalEdition(const aExtDocID: TDocID; const aDate: TStDate): TddALDocRec;
begin
 Result.rIntDocID := -1;
 Result.rExtDocID := -1;
 if IsValidDS then
  Result := CurDS.DoGetContemporalEdition(aExtDocID, aDate);
end;

function TddDualAutolinkDataSource.ExecuteDocQuery: TddALDocRec;
begin
 Result.rIntDocID := cBlankDocID;
 while True do
 begin
  if IsValidDS then
  begin
   CurDS.StartDocQuery;
   try
    if f_FilterByActualEditions then
     CurDS.FilterByActualEditions;
    if f_DocType <> 0 then
     CurDS.FilterByDocType(f_DocType);
    if f_Sources <> nil then
     CurDS.FilterBySources(f_Sources);

    if (f_Date <> 0) or (not l3IsNil(f_Num)) then
     CurDS.FilterByDateNum(f_Date, f_Num);

    if (not l3IsNil(f_Casecode)) and l3IsNil(f_Num) then
     CurDS.FilterByCasecode(f_Casecode);

    Result := CurDS.ExecuteDocQuery;
   finally
    CurDS.CleanupDocQuery;
   end;
   if Result.rIntDocID <> cBlankDocID then
   begin
    f_DSIsFixed := True; // "зафиксировать" DS, чтобы структура искалась в том же источнике
    Break; // нашли!
   end
   else
    if f_CurSource = dsLocal then
     f_CurSource := dsRemote // попробуем другой источник данных
    else
     Break;
  end
  else
   if f_CurSource = dsLocal then
    f_CurSource := dsRemote // попробуем другой источник данных
   else
    Break;
 end;
end;

procedure TddDualAutolinkDataSource.FilterByActualEditions;
begin
 f_FilterByActualEditions := True;
end;

procedure TddDualAutolinkDataSource.FilterByCasecode(const aCaseCode: Tl3PCharLen);
begin
 f_Casecode := aCasecode;
end;

procedure TddDualAutolinkDataSource.FilterByDateNum(aDate: TStDate; const aNum: Tl3PCharLen);
begin
 f_Date := aDate;
 f_Num  := aNum;
end;

procedure TddDualAutolinkDataSource.FilterByDocType(aDocType: TDictID);
begin
 f_DocType := aDocType;
end;

procedure TddDualAutolinkDataSource.FilterBySources(const aSources: Tl3LongintList);
begin
 f_Sources := aSources;
end;

function TddDualAutolinkDataSource.FindBlock(const aDocID: TDocID; const aEntryAddr: TddDocStructElementRec): Longint;
begin
 if not f_DSIsFixed then // пока ни один блок не найден, будем начинать искать с локального кэша
  f_CurSource := dsLocal;
 while True do
 begin
  if IsValidDS then
   Result := CurDS.FindBlock(aDocID, aEntryAddr)
  else
   Result := -1;
  if Result = -1 then
  begin
   if f_DSIsFixed then
    Break // DS зафиксирован, менять нельзя
   else
    if f_CurSource = dsLocal then
     f_CurSource := dsRemote // попробуем поискать в "удалённом"
    else
     Break; // уже перебрали оба источника
  end
  else
  begin
   f_DSIsFixed := True; // нашлось, фиксируем DS
   Break;
  end;
 end;
end;

function TddDualAutolinkDataSource.pm_GetCurDS: TddCacheAutolinkDataSource;
begin
 Result := f_DataSources[f_CurSource];
end;

function TddDualAutolinkDataSource.pm_GetIsValidDS: Boolean;
begin
 Result := f_DataSources[f_CurSource] <> nil;
end;

procedure TddDualAutolinkDataSource.StartDocQuery;
begin
 f_DSIsFixed := False;
 f_CurSource := dsLocal;
end;

end.
