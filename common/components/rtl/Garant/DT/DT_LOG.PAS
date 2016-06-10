Unit Dt_Log;

{ $Id: DT_LOG.PAS,v 1.92 2016/05/13 12:55:08 lukyanets Exp $ }

// $Log: DT_LOG.PAS,v $
// Revision 1.92  2016/05/13 12:55:08  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.91  2016/04/18 11:48:05  lukyanets
// Готовимся переводить UserManager
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.90  2016/04/14 11:14:28  lukyanets
// Cleanup
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.89  2015/11/25 14:01:48  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.88  2015/10/09 13:02:26  lukyanets
// Пишем в лог от чьего имени выполняется задача
//
// Revision 1.87  2015/03/31 14:09:11  lukyanets
// Начинаем изолировать GlobalHTServer
//
// Revision 1.86  2014/09/05 11:51:48  voba
// - Рефакторинг процедуры ввода пароля
//
// Revision 1.85  2014/04/17 13:04:31  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.84  2014/02/18 10:56:06  voba
//  k:236721575 (Атрибуты в EVD)
//
// Revision 1.83  2013/11/12 12:01:43  voba
// - k:236721575 (Атрибуты в EVD)
//
// Revision 1.82  2013/10/30 10:36:40  voba
// - отказ от fSrchList
//
// Revision 1.81  2013/04/01 11:46:28  voba
// - трассировщик лог записей (для демидова)
//
// Revision 1.80  2013/03/07 07:32:13  voba
// - усиленное логирование для поиска проблем Демидова
//
// Revision 1.79  2012/10/18 12:03:49  voba
// no message
//
// Revision 1.78  2012/01/13 11:12:41  fireton
// - исправил ошибки и оптимизировал по скорости (K 326776318)
//
// Revision 1.77  2012/01/13 09:27:40  fireton
// - добавил новый и переименовал старый метод (проверка действий над документами)
//
// Revision 1.76  2012/01/13 08:54:40  fireton
// - добавил новый и переименовал старый метод (проверка действий над документами)
//
// Revision 1.75  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.74  2010/08/03 13:16:38  voba
// - k: 229672814
//
// Revision 1.73  2010/03/10 14:09:47  narry
// - не собиралось
//
// Revision 1.72  2009/11/09 09:15:49  voba
// - add  param to Procedure  PutLogRecToDocs
//
// Revision 1.71  2009/06/23 07:32:59  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.70  2009/06/08 13:23:25  voba
// - enh. унификация атрибутов. Избавился от псевдоатрибутов atDateNumsChDate, atRelHLink,
//
// Revision 1.69  2009/05/19 12:16:28  voba
// - унификация атрибутов
//
// Revision 1.68  2009/05/13 10:52:54  voba
// - cc
//
// Revision 1.67  2009/05/08 11:10:07  voba
// - заменил TblH на Handle
//
// Revision 1.66  2009/03/02 08:15:08  voba
// - изменил список параметров у constructor TPrometTbl.Create
//
// Revision 1.65  2009/02/03 12:00:00  voba
// - сс выкинул ненужную функцию
//
// Revision 1.64  2008/12/17 10:10:06  voba
// - bug fix предотвращение повторной записи VINCLUDED
//
// Revision 1.63  2008/10/31 09:54:33  voba
// - add overload procedure TLogBookTbl.PutLogRecToDocs with ISAB
//
// Revision 1.62  2008/04/18 14:09:14  voba
// - bug fix
//
// Revision 1.61  2008/04/09 06:08:35  voba
// - refact.
//
// Revision 1.60  2008/01/10 14:57:44  voba
// - ref.
//
// Revision 1.59  2007/08/14 20:25:14  lulin
// - bug fix: не собиралася Архивариус.
//
// Revision 1.58  2007/08/14 14:30:08  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.57  2007/05/25 15:20:42  voba
// - DeleteRecsByKeys теперь возвращает количество удаленных и подывмает exception в случае ошибок
//
// Revision 1.56  2007/04/25 07:52:37  fireton
// - Рефакторинг. Уходим от прямых упоминаний имен таблиц в пользу перечислимых типов в DT_Types
//
// Revision 1.55  2007/04/17 11:38:13  fireton
// - регионы в имени пользователей
//
// Revision 1.54  2007/02/22 09:23:51  voba
// - ren DelRecsOnKeys -> DeleteRecsByKeys, _move this to TdtTable
//
// Revision 1.53  2007/02/12 16:11:00  voba
// - заменил использование htModifyRecs на вызов TAbsHtTbl.ModifyRecs
// - выделил TdtTable в модуль dt_Table (обертка вокруг функций HyTech по работе с таблицей целиком)
// - выделил функции HyTech по работе с Sab в dt_Sab, потом объект сделаю
//
// Revision 1.52  2006/12/01 11:22:14  voba
// - add TImpExLogRec
//
// Revision 1.51  2006/10/04 08:35:53  voba
// - merge with b_archi_ht64
//
// Revision 1.50.6.2  2006/09/19 09:35:39  voba
// - remove procedure   DelLogOnDocsID
//
// Revision 1.50.6.1  2006/09/19 08:22:02  voba
// - переход на HTStub
//
// Revision 1.50  2006/06/08 15:54:46  fireton
// - подготовка к переходу на большой User ID
//
// Revision 1.49.16.1  2006/06/08 09:08:01  fireton
// - перевод User ID на Longword
//
// Revision 1.49  2006/01/10 10:13:58  step
// добавлен перегруженный метод TLogBookTbl.DeleteRecords
//
// Revision 1.48  2005/05/17 10:21:06  step
// изменена TLogBookTbl.DelLogOnDocsID
//
// Revision 1.47  2005/05/11 12:16:16  voba
// no message
//
// Revision 1.46  2005/03/21 16:29:38  voba
// - replace cfOrdinal to dt_Const.cOrdLogActions
// - replace cfJuror to dt_Const.cJurLogActions
//
// Revision 1.45  2005/03/02 16:06:42  narry
// - исправление: процедура очистки записей журнала
//
// Revision 1.44  2005/02/28 18:38:18  step
// new: TLogBookTbl.DeleteRecsBy
//
// Revision 1.43  2005/02/25 08:38:19  step
// расширен cfJuror (добавлено acAnnoDate)
//
// Revision 1.42  2005/01/26 15:30:02  step
// исправлены TLogBookTbl.ActionsToSab и TLogBookTbl.DocIdsBy
//
// Revision 1.41  2005/01/14 16:23:16  step
// new: TLogBookTbl.DocIdsBy, TLogBookTbl.ActionsToSab
//
// Revision 1.40  2005/01/11 09:56:09  voba
// - небольшая чистка кода
//
// Revision 1.39  2004/11/05 13:00:08  voba
// - add overload  DelLogOnDocID
//
// Revision 1.38  2004/11/02 09:47:57  step
// bug fix
//
// Revision 1.37  2004/11/01 16:59:10  step
// добавлена проверка в TLogBookTbl.CopyRecords
//
// Revision 1.36  2004/11/01 11:43:50  step
// new: TLogBookTbl.CopyRecords
//
// Revision 1.35  2004/09/14 15:58:14  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.34  2004/08/09 15:21:29  step
// new: TLogBookTbl.DeleteRecords
//
// Revision 1.33  2004/08/03 08:52:49  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.32  2004/07/14 15:27:14  step
// замена Buffering на StartCaching/StopCaching
//
// Revision 1.31  2004/07/01 14:14:27  voba
// - merge newCashe
//
// Revision 1.30.2.1  2004/06/17 18:03:49  step
// В методах TAbsHtTbl.AddRec и TAbsHtTbl.UpdRec убран параметр AbsNum.
//
// Revision 1.30  2004/05/31 13:58:53  narry
// - change: при импорте документов в лог добавляется запись "Импортирован"
//
// Revision 1.29  2004/05/31 13:38:26  voba
// - redefine cfOrdinal
//
// Revision 1.28  2004/04/14 13:51:12  narry
// - bug fix: вместо последней даты юридического изменения документа возвращалась первая
//
// Revision 1.27  2004/04/14 12:22:32  step
// bug fix: вместо последней даты возвращалась первая
//
// Revision 1.26  2004/03/17 11:11:11  voba
// -new behavior: изменил порядок сортировки в Function TLogBookTbl.GetDocHistory
//
// Revision 1.25  2004/03/05 16:54:44  step
// чистка кода
//
// Revision 1.24  2004/02/03 09:42:39  voba
// -code clean
//
// Revision 1.23  2003/06/19 09:20:05  voba
// -new method DelIncludedLogOnDocsID
//
// Revision 1.22  2003/01/23 16:42:17  demon
// - new: поплнил операцию GetLogDataList в объекте TLogBookTbl одним дополнительным,
// необязательным параметром
//
// Revision 1.21  2002/08/01 09:14:37  voba
// -bug fix: присутствие журнальных записей с ID  пользователя, отсутствующими в списке пользователей приводило к невозможности открыть журнал документа
//
// Revision 1.20  2002/05/29 14:05:03  voba
// - bug fix: защищаем изменение времени ожидания.
//
// Revision 1.19  2002/03/07 10:15:36  demon
// - add new function PutLogRecToDocs
//
// Revision 1.18  2001/07/06 14:38:15  demon
// - new behavior: add transactions to all massive operation of Add, Modify and Delete of tbl records
//
// Revision 1.17  2001/04/24 13:39:56  demon
// - new behavior: many search functions now works with Usre Groups too
//
// Revision 1.16  2001/01/25 09:40:18  demon
// - add function GetDocsInDatesNotAction
//
// Revision 1.15  2001/01/11 10:59:29  demon
// Add MasterUser property for Import procedure
//
// Revision 1.14  2000/12/15 15:36:16  law
// - вставлены директивы Log.
//

{$I DtDefine.inc}

Interface
uses
     l3DatLst,l3Date,
     HT_Const,
     Dt_Types, Dt_Const,
     dtIntf,
     Dt_ATbl, DT_Sab,
     dt_Link;

const
 lgDocID_Key       = 1;
 lgAction_Key      = 2;
 lgDate_Key        = 3;
 lgTime_Key        = 4;
 lgActionFlag_Key  = 5;
 //lgStation_Key     = 6;
 lgAuthor_Key      = 7;
 lgUniKey          = 8;

Type
 PDatesArr = ^TDatesArr;
 TDatesArr = Array [1..16000] of TStDate;

Type
 PReadDisplayLogRec = ^TReadDisplayLogRec;
 TReadDisplayLogRec = Record
                       Action  : Byte;
                       Date    : TStDate;
                       Time    : TStTime;
                       Author  : TUserID;
                      end;

 PDisplayLogRec = ^TDisplayLogRec;
 TDisplayLogRec = Record
                   Action  : Byte;
                   Date    : TStDate;
                   Time    : TStTime;
                   Author  : TUserNameStr;
                  end;

 TUniqLogRec = Record
                DocID   : TDocID;
                Action  : TLogActionType;
                Date    : TStDate;
                Time    : TStTime;
               end;

 PImpExLogRec = ^TImpExLogRec;
 TImpExLogRec = Record
                 rDocID   : TDocID;
                 rAction  : TLogActionType;
                 rDate    : TStDate;
                 rTime    : TStTime;
                 rAuthor  : TUserID;
                end;

 TLogBookTbl = Class(TDocAttrTbl)
  private
   function GetDocHistory(aDocID : LongInt;
                          aFlag : TLogActionFlags;
                          WithSort : Boolean) : Sab;

  public
   Constructor Create(aFamID : TFamilyID); Reintroduce;
   procedure   PutDateLogRec(aDocID : LongInt;
                             aAction : TLogActionType;
                             aDate : TStDate = 0;
                             aTime : TStTime = 0;
                             aUser : TUserID = 0);

   Procedure   PutLogRec(aDocID : LongInt;aAction : TLogActionType;aUser : TUserID = 0);
   Procedure   PutLogRecSet(aDocID : LongInt; aActSet : TLogActionSet);
   Procedure   PutLogRecToDocs(aDocIDs : ISAB; aAction : TLogActionType; aUser : TUserID = 0; aDate : TStDate = 0);

   function IsDocHadAction(aDocID : LongInt;aAction : TLogActionType; aDate : TStDate = 0): Boolean;
   Function    IsDocModified(aDocID : LongInt) : Boolean;
   Function    GetDocsOnAction(aAction : TLogActionType;UserID : TUserID = 0;
                               UserGr : Boolean = False) : Sab;
   Procedure   GetLogDataList(aDocID : LongInt;aFlag : TLogActionFlags;
                              aDataList : Tl3DataList;InternalFormat : Boolean = False);

   Function    GetDocsHistory(aDocSab : Sab;aFlag : TLogActionFlags) : Sab;

   procedure   CopyRecords(aSrcDocId, aDstDocId: Longint);
    // делает копии всех записей от документа aSrcDocId для документа aDstDocId
   Procedure   DelSingleLogRec(aDocID : TDocID;aAction : TLogActionType;
                               aDate : TStDate;aTime : TStTime);
   function IsDocHadActions(aDocID : LongInt; aActions: array of TLogActionType; aDate : TStDate = 0): Boolean;
 end;

Implementation
Uses
  SysUtils, WinProcs,
  TypInfo,
  l3Base,

  daDataProvider,
  daSchemeConsts,

  HT_DLL,
  dt_AttrSchema,
  Dt_Serv, Dt_Err, Dt_User,
  vConst;

{ TLogBookTbl }

Const
 DateTimeArr : Array [1..2] of SmallInt = (lgDate_Key,lgTime_Key);
 DisplayArr : Array [1..4] of SmallInt = (lgAction_Key,lgDate_Key,lgTime_Key,
                                          lgAuthor_Key);

constructor TLogBookTbl.Create(aFamID : TFamilyID);
begin
 Assert(aFamID <> MainTblsFamily);
 inherited Create(aFamID, atOrdLogRecords);
end;

Function TLogBookTbl.GetDocHistory(aDocID : LongInt;aFlag : TLogActionFlags;
                                   WithSort : Boolean) : Sab;
Var
 TmpSab1,
 TmpSab2,
 TmpSab3 : Sab;
 SortArr : Array [1..2] of SmallInt;
Begin
 l3FillChar(Result,SizeOf(Sab));
 with fTable do
 begin
  htSearch(nil,TmpSab3,Handle,lgDocID_Key,Equal,@aDocID,Nil);
  If aFlag<>acfNone
  then
   Begin
    htSearch(@TmpSab3,TmpSab2,Handle,lgActionFlag_Key,Equal,@aFlag,Nil);
    Try
     htAndResults(TmpSab1,TmpSab3,TmpSab2);
    finally
     htClearResults(TmpSab2);
     htClearResults(TmpSab3);
    end;
   end;
  If WithSort
  then
   Try
    SortArr[1] := -lgDate_Key;
    SortArr[2] := -lgTime_Key;
    Ht(htSortResults(Result,TmpSab1,@SortArr,2));
   finally
    htClearResults(TmpSab1);
   end
  else
   Result:=TmpSab1;
 end;
end;

Function TLogBookTbl.GetDocsHistory(aDocSab : Sab;aFlag : TLogActionFlags) : Sab;
Var
 TmpSab1,
 TmpSab2,
 TmpSab3 : Sab;
Begin
 l3FillChar(Result,SizeOf(Sab));
 htRecordsByKey(TmpSab1,aDocSab);
 If aFlag<>acfNone
  then
   Begin
    TmpSab3:=TmpSab1;
    htSearch(@aDocSab,TmpSab2,Table.Handle,lgActionFlag_Key,Equal,@aFlag,Nil);
    Try
     htAndResults(TmpSab1,TmpSab3,TmpSab2);
    finally
     htClearResults(TmpSab2);
     htClearResults(TmpSab3);
    end;
   end;
 Result:=TmpSab1;
end;

procedure TLogBookTbl.PutDateLogRec(aDocID : LongInt;
                                    aAction : TLogActionType;
                                    aDate : TStDate = 0;
                                    aTime : TStTime = 0;
                                    aUser : TUserID = 0);
var
 TmpFlag : TLogActionFlags;
 TmpPChar: PChar;

 function CheckSingleAction(aAction : TLogActionType) : boolean;
 begin
  Result :=  not (aAction in cSingleJurLogActions) or not IsDocHadAction(aDocID, aAction);
 end;

{$IfDef DocSaveTrace}
 var
  lAge : Int64;
{$EndIf}

begin
 {$IfDef DocSaveTrace}
 l3System.Msg2Log('PutDateLogRec : DocID=%d, Action=%s', [aDocID, GetEnumName(TypeInfo(TLogActionType), Ord(aAction))]);
 {$EndIf}

 if not CheckSingleAction(aAction) then exit;

 {$IfDef DocSaveTrace}
 l3System.Msg2Log('PutDateLogRec : DocID=%d  Check pass', [aDocID]);
 {$EndIf}

 with fTable do
 begin
 ClearFullRec;
 PutToFullRec(lgDocID_Key,aDocID);
 //TmpPChar:=@GlobalHtServer.CurStationName;
 //PutToFullRec(lgStation_Key,TmpPChar);

 if aUser = 0 then
  aUser := GlobalDataProvider.ImpersonatedUserID;
 if aDate = 0 then
  aDate := CurrentDate;
 if aTime = 0 then
  aTime := CurrentTime;

 PutToFullRec(lgAuthor_Key,aUser);
 PutToFullRec(lgDate_Key,aDate);
 PutToFullRec(lgTime_Key,aTime);

 TmpFlag := acfNone;
 if aAction in cOrdLogActions then
  TmpFlag:=acfOrdinal;
 if aAction in cJurLogActions then
  TmpFlag:=acfJuror;

 PutToFullRec(lgActionFlag_Key,TmpFlag);
 PutToFullRec(lgAction_Key,aAction);

 {$IfDef DocSaveTrace}
 l3System.Msg2Log('PutDateLogRec : DocID=%d  AddFRec', [aDocID]);
 l3System.Msg2Log('PutDateLogRec : TblPath=%s', [TblFullName]);
 lAge := MakePhoto(Self).Age;
 {$EndIf}

 Try
  AddFRec;
  {$IfDef DocSaveTrace}
   if MakePhoto(Self).Age > lAge then
    l3System.Msg2Log('PutDateLogRec : AgeCheck OK')
   else
    l3System.Msg2Log('PutDateLogRec : !!!! AgeCheck Fault');
  {$EndIf}
 except
  On E : Exception do
   l3System.Exception2Log(E);
 end;
 end; //with fTable do
end;

Procedure TLogBookTbl.PutLogRec(aDocID : LongInt;aAction : TLogActionType;aUser : TUserID);
Begin
 PutDateLogRec(aDocID,aAction,0,0,aUser);
end;

Procedure TLogBookTbl.PutLogRecSet(aDocID : LongInt;aActSet : TLogActionSet);
Var
 I : TLogActionType;
Begin
 with fTable do
 begin
 StartCaching;
 try
  for I:=Low(TLogActionType) to High(TLogActionType) do
   if I in aActSet then
    PutLogRec(aDocID,I);
 finally
  StopCaching;
 end;
 end;
end;

procedure TLogBookTbl.PutLogRecToDocs(aDocIDs : ISAB; aAction : TLogActionType; aUser : TUserID = 0; aDate : TStDate = 0);

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 begin
  Result := True;
  PutDateLogRec(PDocID(aItemPtr)^, aAction, aDate, 0, aUser);
 end;

 var
  lSab        : ISab;
  lRAProcStub : TdtRecAccessProc;

begin
 Assert(aDocIDs.TypeOfSab = RES_VALUE);
 if aDocIDs.IsEmpty then Exit;

 if aUser = 0 then
  aUser := GlobalDataProvider.ImpersonatedUserID;
 if aDate = 0 then
  aDate := CurrentDate;

 with fTable do
 begin
 StartCaching;
 try
  lRAProcStub := L2RecAccessProc(@lRecAccessProc);
  try
   aDocIDs.IterateRecords(lRAProcStub);
  finally
   FreeRecAccessProc(lRAProcStub);
  end;
 finally
  StopCaching;
 end;
 end;
end;

function TLogBookTbl.IsDocHadAction(aDocID : LongInt;aAction : TLogActionType; aDate : TStDate = 0): Boolean;
var
 lSab : ISab;
Begin
 Result := False;
 lSab := MakeSab(Self);
 lSab.Select(lgDocID_Key, aDocID);
 if lSab.Count = 0 then Exit;
 lSab.SubSelect(lgAction_key, aAction);
 if lSab.Count = 0 then Exit;
 if aDate <> 0 then
  lSab.SubSelect(lgDate_Key, aDate);
 Result := lSab.Count > 0;
end;

Function TLogBookTbl.IsDocModified(aDocID : LongInt) : Boolean;
Var
 TmpSab : Sab;
Begin
 TmpSab:=GetDocHistory(aDocID,acfOrdinal,False);
 Try
  If TmpSab.gFoundCnt>1 then
   Result:=True
  else
   Result:=False;
 finally
  htClearResults(TmpSab);
 end;
end;

Function TLogBookTbl.GetDocsOnAction(aAction : TLogActionType;UserID : TUserID;UserGr : Boolean) : Sab;
Var
 TmpSab  : Sab;
 TmpSab1,
 TmpSab2 : Sab;
 l_Sab: ISab;
Begin
 with fTable do
 begin
  htSearch(nil,TmpSab,Handle,lgAction_key,Equal,@aAction,Nil);
 Try
  If UserID<>0 then
   If UserGr then
    begin
     l_Sab := UserManager.xxxMakeUserIDSabOnGroup(UserID);
     try
      TmpSab2 := l_Sab.ExtractHTSab;
     finally
      l_Sab := nil;
     end;
     Try
      htTransferToPhoto(TmpSab2,TmpSab,lgAuthor_Key);
      htRecordsByKey(TmpSab1,TmpSab2);
     finally
      htClearResults(TmpSab2);
     end;
     try
      TmpSab2:=TmpSab;
      Try
       htAndResults(TmpSab,TmpSab1,TmpSab2);
      finally
       htClearResults(TmpSab2);
      end;
     finally
      htClearResults(TmpSab1);
     end;
    end
   else
    begin
     htSearch(@TmpSab,TmpSab1,Handle,lgAuthor_Key,Equal,@UserID,Nil);
     try
      TmpSab2:=TmpSab;
      Try
       htAndResults(TmpSab,TmpSab1,TmpSab2);
      finally
       htClearResults(TmpSab2);
      end;
     finally
      htClearResults(TmpSab1);
     end;
    end;
  htValuesOfKey(Result,lgDocID_Key,TmpSab);
 finally
  htClearResults(TmpSab);
 end;
 end; //with fTable do
end;

procedure TLogBookTbl.GetLogDataList(aDocID : LongInt;aFlag : TLogActionFlags;
                                     aDataList : Tl3DataList; InternalFormat : Boolean);
var
 DocHistory : Sab;
 ReadRec    : TReadDisplayLogRec;
 DisplayRec : TDisplayLogRec;
begin
 DocHistory:=GetDocHistory(aDocID,aFlag,True);
 try
  aDataList.Changing;
  try
   aDataList.Clear;
   if DocHistory.gFoundCnt<>0 then
   begin
    htOpenResults(DocHistory,ROPEN_READ,@DisplayArr,4);
    try
     while htReadResults(DocHistory,@ReadRec,SizeOf(TReadDisplayLogRec))<>0 do
      if not InternalFormat then
       with ReadRec do
       begin
        DisplayRec.Action:=Action;
        DisplayRec.Date:=Date;
        DisplayRec.Time:=Time;
        DisplayRec.Author := GlobalDataProvider.UserManager.GetUserDisplayName(Author);
        aDataList.Add(@DisplayRec);
       end
      else
       aDataList.Add(@ReadRec);
    finally
     htCloseResults(DocHistory);
    end;
   end;
  finally
   aDataList.Changed;
  end;
 finally
  htClearResults(DocHistory);
 end;
end;

Procedure TLogBookTbl.DelSingleLogRec(aDocID : TDocID;aAction : TLogActionType;
                                      aDate : TStDate;aTime : TStTime);
var
 SrchRec : TUniqLogRec;
 AbsNum  : LongInt;
 RecH    : RHANDLE;
begin
 With SrchRec do
  begin
   DocID:=aDocID;
   Action:=aAction;
   Date:=aDate;
   Time:=aTime;
  end;
 AbsNum:=Ht(htRecordByUniq(Nil,Table.Handle,lgUniKey,@SrchRec,@RecH));
 If AbsNum <> 0 then
 begin
  Ht(htRecordDelete(Table.Handle,AbsNum));
 {$IfDef DelLogTrace}
  l3System.Msg2Log('Delete Journal: DocID=%d, TLogBookTbl.DelSingleLogRec', [aDocID]);
 {$EndIf}
 end;
end;

procedure TLogBookTbl.CopyRecords(aSrcDocId, aDstDocId: Longint);

 function lRecModifyProc(aBuffer : Pointer) : Boolean;
 begin
  PDocID(aBuffer)^ := aDstDocId; //Модифицируем первое поле записи
  Result := True;
 end;

var
 lSab : ISab;
 lRecModifyProcStub : TdtRecAccessProc;

begin
 lSab := MakeSab(fTable);
 lSab.Select(lgDocID_Key, aSrcDocId);
 // заносим получившиеся записи в таблицу

 lRecModifyProcStub := L2RecAccessProc(@lRecModifyProc);
 try
  fTable.CopyRecs(lSab, lRecModifyProcStub);
 finally
  FreeRecAccessProc(lRecModifyProcStub);
 end;

end;

function TLogBookTbl.IsDocHadActions(aDocID : LongInt; aActions: array of TLogActionType; aDate : TStDate = 0): Boolean;
var
 I: Integer;
 l_Sab   : ISab;
 l_Sab2 : ISab;
Begin
 Result := False;
 l_Sab := MakeSab(Self);
 l_Sab.Select(lgDocID_Key, aDocID);
 if l_Sab.Count = 0 then Exit;
 if aDate <> 0 then
 begin
  l_Sab.SubSelect(lgDate_Key, aDate);
  if l_Sab.Count = 0 then Exit;
 end;

 for I := Low(aActions) to High(aActions) do
 begin
  l_Sab2 := MakeSabCopy(l_Sab);
  l_Sab2.SubSelect(lgAction_key, aActions[I]);
  Result := l_Sab2.Count > 0;
  if Result then
   Exit;
 end;
end;

end.
