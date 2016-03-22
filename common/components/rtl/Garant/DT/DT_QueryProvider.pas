unit Dt_QueryProvider;

{ $Id: DT_QueryProvider.pas,v 1.38 2015/11/25 14:01:48 lukyanets Exp $ }

// $Log: DT_QueryProvider.pas,v $
// Revision 1.38  2015/11/25 14:01:48  lukyanets
// «аготовки дл€ выдачи номеров+переезд констант
//
// Revision 1.37  2014/12/01 15:58:57  voba
// - bf: неправильно формировалась цепочка verlink
//
// Revision 1.36  2014/04/17 13:04:31  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.35  2012/08/07 11:03:18  voba
// - bug fix
//
// Revision 1.34  2012/08/03 11:36:33  voba
// - bug fix
//
// Revision 1.33  2011/12/22 11:18:03  fireton
// - добавл€ем rStatus в результирующую запись (  321986415)
//
// Revision 1.32  2011/12/19 14:06:01  fireton
// - более правильный join
//
// Revision 1.31  2011/12/19 13:37:08  fireton
// - получаем внешние ID через JOIN (  320745075)
//
// Revision 1.30  2011/12/14 12:00:07  voba
// - k:317261462
//
// Revision 1.29  2011/09/08 07:56:56  voba
// - k : 236721575
//
// Revision 1.28  2011/06/03 14:25:17  voba
// - помен€л название функции TSabCursor.Sort на SortJoin тк проблемы с вызовом (не может отличить overload)
//
// Revision 1.27  2011/05/18 12:08:41  lulin
// {RequestLink:266409354}.
//
// Revision 1.26  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.25  2010/08/04 08:29:39  voba
// - k: 229672814
//
// Revision 1.24  2010/02/17 07:24:02  voba
// - K:190679769
//
// Revision 1.23  2010/02/10 09:25:35  voba
// - K:190251355
//
// Revision 1.22  2009/12/16 11:44:15  lulin
// - убираем неправильные приведени€ к своим собственным интерфейсам.
//
// Revision 1.21  2009/12/11 15:56:09  lulin
// {RequestLink:172984520}.
//
// Revision 1.20  2009/07/23 07:42:43  voba
// - флажок aWithReSearch у RefreshResult
//
// Revision 1.19  2009/06/23 07:32:59  voba
// - стандартизаци€ доступа к атрибутам
//
// Revision 1.18  2009/05/12 08:42:06  voba
// - заменил в ISab ссылки на таблицу на интерфейсы
//
// Revision 1.17  2009/04/07 13:03:14  voba
// - cc
//
// Revision 1.16  2009/03/26 10:24:06  fireton
// - новое поле (Comment)
//
// Revision 1.15  2009/03/25 13:56:23  voba
// - сс
//
// Revision 1.14  2009/03/10 15:27:17  voba
// - bug fix неправильно сортировалось по Name. ѕосле исправлени€ вы€снилось что по такому длинному полю вообще не может быть отсортированноно
//
// Revision 1.13  2009/02/18 13:47:14  voba
// - enh& переделал procedure TdtQueryProvider.MergeWith
//
// Revision 1.12  2009/02/17 15:28:52  voba
// - bu fix htErr=-32
//
// Revision 1.11  2009/02/03 11:57:35  voba
// - выкрутил флажок  "ѕодключен" из записи дл€ скорости (см  {$ifdef NeedInclInDocRec})
//
// Revision 1.10  2009/01/29 17:01:36  voba
// - small improve function  TdtQueryProvider.GetCount
//
// Revision 1.9  2009/01/26 08:06:17  fireton
// - сли€ние с веткой b_archi_NewSrch2 (поиск по-новому)
//
// Revision 1.8  2009/01/23 13:58:37  lulin
// - <K>: 135605086.
//
// Revision 1.7.2.2  2008/12/25 10:17:44  fireton
// - перевод спецпоисков на TdtQuery
//
// Revision 1.7.2.1  2008/12/22 11:09:17  fireton
// - перевод поисков на TdtQuery
//
// Revision 1.7  2008/11/21 12:29:41  voba
// no message
//
// Revision 1.6  2008/11/19 14:22:11  voba
// no message
//
// Revision 1.5  2008/11/17 07:41:42  voba
// no message
//
// Revision 1.4  2008/11/12 15:00:11  voba
// no message
//
// Revision 1.3  2008/11/01 14:15:29  voba
// no message
//
// Revision 1.2  2008/10/31 09:57:06  voba
// no message
//
// Revision 1.1  2008/10/27 08:21:33  voba
// - move TdtQueryProvider to  DT_QueryProvider
//

{$Include DtDefine.inc}

interface

uses
  Classes, SysUtils,
  l3Types, l3Base, l3ProtoObject,
  l3Interfaces, l3ChangeNotifier,
  l3NotifyPtrList,
  l3LongintList,
  DT_Types,
  DT_Table, dtIntf, DT_Query,
  DT_Doc;

type
 _l3Changing_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\rtl\Garant\L3\l3Changing.imp.pas}
  _l3ChangingChangedNotifier_Parent_ = _l3Changing_;
  {$Include l3ChangingChangedNotifier.imp.pas}
  _l3LockedChange_Parent_ = _l3ChangingChangedNotifier_;
  {$Include l3LockedChange.imp.pas}
 TdtQueryProvider = class(_l3LockedChange_, Il3ChangeRecipient)
  private
   fQuery : TdtQuery;
   fSabCursor  : ISabCursor;

   fPreventReset : integer;

   fSortField : TSortField;
   fSortOrder : TSortOrder;

   procedure SetQuery(aQuery : TdtQuery); virtual;
   function  GetQuery : TdtQuery; virtual;
   function  GetCount : Integer;
   function  GetSabCursor : ISabCursor;

   procedure SetSortField(aValue : TSortField);
   procedure SetSortOrder(aValue : TSortOrder);

  protected
   procedure Cleanup; override;

   procedure OpenResult;
   procedure CloseResult;

   procedure FireChanged; override;

  public
   function  GetItem(aIndex : TListIndex) : PDocListAccessRec;
   procedure Sort;

   function  MakeDocIDList(aWithRelated : Boolean = false) : ISab;

   procedure MergeWith(aQuery : TdtQuery; aMergeMode : Tl3BoolOp);

   procedure ResetResult;
   {* - —брасывает результат, при следуещем требовании результат переоткрываетс€ заново}
   procedure RefreshResult(aWithReSearch : Boolean = false);
   {* - ќбновл€ет Photo дл€ результата}

   function  IsEmpty : Boolean;

   property Query : TdtQuery read GetQuery write SetQuery;
   property SabCursor : ISabCursor read GetSabCursor;
   property Count : Integer read GetCount;

   property SortField : TSortField read fSortField write SetSortField;
   property SortOrder : TSortOrder read fSortOrder write SetSortOrder;
 end;

 TdtDocListQueryProvider = class(TdtQueryProvider)
 // QueryProvider c расширенными возможност€ми дл€ манипул€ций со списком документов
 // см TDocListQuery
  private
   procedure MakeQuery;
   procedure SetQuery(aQuery : TdtQuery); override;
   function  GetQuery : TdtQuery; override;
  protected
  public
   procedure AddID(aDocID : TDocID);
   procedure DelID(aIndex : TListIndex);
   function  GetTextQuery : TdtTextQuery;
   function  GetFoundDocSubList(aDocID : TDocID) : Tl3LongintList;

   //function DLQuery : TdtDocListQuery;
 end;

implementation
uses
  WinTypes,
  daSchemeConsts,
  HT_Const, HT_Dll,
  DT_Const,
  dt_Sab,
  dt_AttrSchema,
  DT_Misc,
  dt_LinkServ,
  DT_Renum,
  Dt_Serv, Dt_Active, Dt_Log,
  l3Date,
  l3String;

{$Include w:\common\components\rtl\Garant\L3\l3Changing.imp.pas}  

{$Include l3ChangingChangedNotifier.imp.pas}

{$Include l3LockedChange.imp.pas}

{TdtQueryProvider}
procedure TdtQueryProvider.Cleanup;
begin
 Query := nil;
 inherited;
end;

procedure TdtQueryProvider.SetQuery(aQuery : TdtQuery);
begin
 if fQuery = aQuery then Exit;
 if fQuery <> nil then
  (fQuery as Il3ChangeNotifier).Unsubscribe(Il3ChangeRecipient(Self));
 l3Set(fQuery, aQuery);
 if fQuery <> nil then
  (fQuery as Il3ChangeNotifier).Subscribe(Il3ChangeRecipient(Self));
 ResetResult;
end;

function  TdtQueryProvider.GetQuery : TdtQuery;
begin
 Result := fQuery;
end;

function  TdtQueryProvider.GetCount : Integer;
begin
 if IsEmpty then
  Result := 0
 else
  Result := SabCursor.Count;
  //fQuery.FoundList.Count;
end;

function  TdtQueryProvider.GetSabCursor : ISabCursor;
begin
 OpenResult;
 Result := fSabCursor;
end;

procedure TdtQueryProvider.SetSortField(aValue : TSortField);
begin
 fSortField := aValue;
 Sort;
end;

procedure TdtQueryProvider.SetSortOrder(aValue : TSortOrder);
begin
 fSortOrder := aValue;
 Sort;
end;

function TdtQueryProvider.MakeDocIDList(aWithRelated : Boolean = false) : ISab;
var
 lSab : ISab;
begin
 Result := nil;
 if Count = 0 then Exit;
 Result := MakeSabCopy(Query.FoundList);
 Result.ValuesOfKey(fId_Fld);
 if aWithRelated then
 begin
  lSab := MakeSabCopy(Query.FoundList);
  lSab.ValuesOfKey(fRelated_fld);
  Result.OrSab(lSab);
  Result.TransferToPhoto(fId_Fld);
 end;
end;

procedure TdtQueryProvider.MergeWith(aQuery : TdtQuery; aMergeMode : Tl3BoolOp);
var
 lIDListQuery : TdtIDListQuery;
begin
 Changing;
 if not Query.MergeWith(aQuery, aMergeMode) then
 begin
  // трансформируем Query в IDList
  lIDListQuery := TdtIDListQuery.CreateFrom(MakeDocIDList);
  try
   lIDListQuery.MergeWith(aQuery, aMergeMode);
   Query := lIDListQuery;

  finally
   l3Free(lIDListQuery);
  end;
 end;
 Changed;
end;

procedure TdtQueryProvider.OpenResult;
var
 lMainSab       : ISab;
 lActiveSab     : ISab;
 lIncludeSab    : ISab;
 lRenumSab      : ISab;
 lJoinRenumSab  : IJoinSab;
 lJoinActiveSab : IJoinSab;
 lJoinInclSab   : IJoinSab;
 lAllSab        : IJoinSab;

 lMainTbl       : ITblInfo;
 lActiveTbl     : ITblInfo;
 lLogTbl        : ITblInfo;
 lRenumTbl      : ITblInfo;

 lCurDate       : TStDate;
 lCurType       : Byte;
 lAction : TLogActionType;

 lDupMainAct  : TdtTable;
{$ifdef NeedInclInDocRec}
 lDupMainIncl : TdtTable;
{$Endif}
 //lMode : SmallInt;
begin
 if fSabCursor <> nil then exit;

 lMainTbl   := Query.FoundList.Table;
 lActiveTbl := LinkServer(CurrentFamily)[atActiveIntervals];
 lLogTbl    := LinkServer(CurrentFamily)[atLogRecords];
 lRenumTbl  := LinkServer(CurrentFamily).Renum;

 lMainSab := Query.FoundList;

 {lRenumSab := MakeAllRecords(lRenumTbl);
 lRenumSab.ValuesOfKey(rnRealID_fld);
 lRenumSab.TransferToPhoto(fId_Fld, lMainSab);
 lRenumSab.RecordsByKey;
 lMainSab.SubtractSab(lRenumSab);}

 lRenumSab := MakeAllRecords(lRenumTbl);

 lActiveSab := MakeSabCopy(lMainSab);
 lActiveSab.ValuesOfKey(fId_Fld);

{$ifdef NeedInclInDocRec}
 lIncludeSab := MakeSabCopy(lActiveSab);
{$Endif}
 lActiveSab.TransferToPhoto(actDocID, lActiveTbl);
 lActiveSab.RecordsByKey;

 lCurDate := CurrentDate;
 lActiveSab.SubSelect(actStart, lCurDate, Less_Equal);
 lActiveSab.SubSelect(actFinish, lCurDate, Great_Equal);
 lCurType := 0;
 lActiveSab.SubSelect(actTyp, lCurType, Equal);

 // Ќижеследующее - дл€ того, чтобы избежать дубликатов, если периодов действи€ несколько
 // на один документ.
 lActiveSab.ValuesOfKey(actDocID);
 //f_DupMainAct := TdtTable.CreateDup(lMainTbl);
 lDupMainAct := GlobalHtServer.GetTblObjectEx(CurrentFamily, Ord(ftFileDup1));
 lActiveSab.TransferToPhoto(fId_Fld, lDupMainAct);
 lActiveSab.RecordsByKey;

{$ifdef NeedInclInDocRec}
 lIncludeSab.TransferToPhoto(lgDocID_Key, lLogTbl);
 lIncludeSab.RecordsByKey;
 //lIncludeSab.SubSelect(actStart, lCurDate, Less_Equal);

 lAction := acIncluded;
 lIncludeSab.SubSelect(lgAction_Key, lAction);

 // Ќижеследующее - дл€ того, чтобы избежать дубликатов, если документ подключен
 // несколько раз.
 lIncludeSab.ValuesOfKey(lgDocID_Key);
 //f_DupMainIncl := TdtTable.CreateDup(lMainTbl);
 lDupMainIncl := GlobalHtServer.GetTblObjectEx(CurrentFamily, Ord(ftFileDup2));
 lIncludeSab.TransferToPhoto(fId_Fld, lDupMainIncl);
 lIncludeSab.RecordsByKey;
{$Endif}

 lJoinActiveSab := MakeJoinSab(lMainSab, fId_Fld,
                               lActiveSab, fId_Fld,
                               Draft_Left);

 //lMode := Draft_Zero;
 lJoinRenumSab := MakeJoinSab(lMainSab, fId_Fld,
                              lRenumSab, rnRealID_fld,
                              Draft_Left {DRAFT_ZERO});

 lJoinActiveSab := MakeJoinSab(lJoinActiveSab, lJoinRenumSab, False, LINK_MULT);

{$ifdef NeedInclInDocRec}
 lJoinInclSab  := MakeJoinSab(lMainSab, fId_Fld,
                              lIncludeSab, fId_Fld,
                              Draft_Left);

 lAllSab := MakeJoinSab(lJoinActiveSab, lJoinInclSab, LINK_MULT);

{$else}
 lAllSab := lJoinActiveSab;
{$Endif}

 fSabCursor := lAllSab.MakeJoinSabCursor([JFRec(lMainTbl, fId_Fld),            // FILE.Id  (см. Dt_Types.TDocListAccessRec)
                                          JFRec(lRenumTbl, rnImportID_fld),    // RENUM.ImportID
                                          JFRec(lMainTbl, fType_Fld),          // FILE.Type
                                          JFRec(lMainTbl, fUserType_Fld),      // FILE.UserType
                                          JFRec(lMainTbl, fFName_Fld),         // FILE.Name
                                          JFRec(lMainTbl, fUrgency_fld),       // FILE.Urgency
                                          JFRec(lMainTbl, fStatus_Fld),        // FILE.Status
                                          JFRec(lDupMainAct, fId_Fld),         // Active.DocID (смапированный на MainTbl)
                                         {$ifdef NeedInclInDocRec}
                                          JFRec(lDupMainIncl, fId_Fld),        // Log.DocID
                                         {$Endif}
                                          JFRec(lMainTbl, fComment_fld)        // FILE.Comment
                                          //, JFRec(lMainTbl, fSDate_Fld)        // 
                                          ],

                                         cmBalanced,
                                         ROPEN_READ);
 Sort;
end;

procedure TdtQueryProvider.CloseResult;
begin
 fSabCursor := nil;
 //l3Free(f_DupMainAct);
{$ifdef NeedInclInDocRec}
 //l3Free(f_DupMainIncl);
{$Endif}
end;

procedure TdtQueryProvider.FireChanged;
begin
 ResetResult;
 Inherited;
end;

procedure TdtQueryProvider.ResetResult;
begin
 if fPreventReset = 0 then
  CloseResult;
end;

procedure TdtQueryProvider.RefreshResult(aWithReSearch : Boolean = false);
begin
 if fPreventReset > 0 then Exit;
 Changing;
 try
  CloseResult;
  Query.RefreshMainTblPhoto;
  if aWithReSearch then
   Query.DoQuery;
 finally
  Changed;
 end;
end;

function TdtQueryProvider.GetItem(aIndex : TListIndex) : PDocListAccessRec;
begin
 Result := SabCursor.GetItem(aIndex);
end;

procedure TdtQueryProvider.Sort;
var
 lMainTbl    : ITblInfo;
 lSortFields : TJoinFieldarray;

const
 cSortSign : array[TSortOrder] of integer = (1, -1);   //TSortOrder      = (soUpDown,soDownUp);

begin
 if fSabCursor = nil then exit;

 lMainTbl := Query.FoundList.Table;

 case fSortField of
  sfNone :
    lSortFields := MakeJoinFieldArray([JFRec(lMainTbl, cSortSign[fSortOrder] * fID_Fld)]);
  sfName :
    lSortFields := MakeJoinFieldArray([JFRec(lMainTbl, cSortSign[fSortOrder] * fFName_Fld)]);
  sfDate :
   lSortFields := MakeJoinFieldArray([JFRec(lMainTbl, cSortSign[fSortOrder] * fSDate_Fld), JFRec(lMainTbl, fPriority_fld)]);
  sfPriority :
   lSortFields := MakeJoinFieldArray([JFRec(lMainTbl, cSortSign[fSortOrder] * -fPriority_fld), JFRec(lMainTbl, fSDate_Fld)]);
  sfUrgency :
   lSortFields := MakeJoinFieldArray([JFRec(lMainTbl, cSortSign[fSortOrder] * fUrgency_fld)]);
 end;

 fSabCursor.SortJoin(lSortFields);
end;

function TdtQueryProvider.IsEmpty : Boolean;
begin
 Result := (fQuery = nil) or fQuery.IsEmpty;
end;

{TdtDocListQueryProvider}

procedure TdtDocListQueryProvider.SetQuery(aQuery : TdtQuery);
var
 lQuery : TdtDocListQuery;
begin
 if (aQuery = nil) or
    //(aQuery is TdtIDListQuery) or
    (aQuery is TdtDocListQuery) then
  inherited SetQuery(aQuery)
 else
 begin
  if not (fQuery is TdtDocListQuery) then
   MakeQuery;
  TdtDocListQuery(fQuery).UQuery := aQuery;
 end;
end;

procedure TdtDocListQueryProvider.MakeQuery;
var
 lQuery : TdtDocListQuery;
begin
 lQuery := TdtDocListQuery.Create;
 try
  SetQuery(lQuery);
 finally
  l3Free(lQuery);
 end;
end;

function TdtDocListQueryProvider.GetQuery : TdtQuery;
var
 lQuery : TdtDocListQuery;
begin
 if fQuery = nil then
  MakeQuery;
 Result := fQuery;
end;

procedure TdtDocListQueryProvider.AddID(aDocID : TDocID);
begin
 Changing;
 try
  if (Query is TdtDocListQuery) then
   TdtDocListQuery(fQuery).AddID(aDocID)
  else
  if (Query is TdtIDListQuery) then
   TdtIDListQuery(fQuery).AddID(aDocID);
 finally
  Changed;
 end;
end;

procedure TdtDocListQueryProvider.DelID(aIndex : TListIndex);
var
 lDocID : TDocID;
begin
 Changing;
 try
  lDocID := GetItem(aIndex)^.rID;

  if (Query is TdtDocListQuery) then
   TdtDocListQuery(fQuery).DelID(lDocID)
  else
  if (Query is TdtIDListQuery) then
   TdtIDListQuery(fQuery).DelID(lDocID);

  // дл€ скорости удалим сами + взведем fPreventReset
  if fSabCursor <> nil then
   fSabCursor.DelItem(aIndex);
 finally
  Inc(fPreventReset);
  try
   Changed;
  finally
   Dec(fPreventReset);
  end;
 end;
end;

function TdtDocListQueryProvider.GetTextQuery : TdtTextQuery;
var
 I : Integer;
begin
 Result := nil;
 if (Query is TdtDocListQuery) and
    (TdtDocListQuery(Query).UQuery is TdtAndQuery) then
  with TdtAndQuery(TdtDocListQuery(Query).UQuery) do
   for I := 0 to Pred(QueryList.Count) do
    if QueryList[I] is TdtTextQuery then
    begin
     Result := TdtTextQuery(QueryList[I]);
     Exit;
    end;
end;

function  TdtDocListQueryProvider.GetFoundDocSubList(aDocID : TDocID) : Tl3LongintList;
var
 I : Integer;
begin
 Result := nil;
 if (Query is TdtDocListQuery) and (TdtDocListQuery(Query).UQuery is TdtAndQuery) then
  TdtAndQuery(TdtDocListQuery(Query).UQuery).GetFoundDocSubList(aDocID, Result);
end;

end.
