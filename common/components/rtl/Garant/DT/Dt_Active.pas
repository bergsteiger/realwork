unit Dt_Active;

{ $Id: Dt_Active.pas,v 1.44 2015/11/25 14:01:48 lukyanets Exp $ }

// $Log: Dt_Active.pas,v $
// Revision 1.44  2015/11/25 14:01:48  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.43  2014/04/17 13:04:31  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.42  2013/10/30 10:36:40  voba
// - отказ от fSrchList
//
// Revision 1.41  2011/07/28 08:41:48  voba
// - k : 236721575
//
// Revision 1.40  2010/10/20 10:04:54  voba
// - K : 236720571
//
// Revision 1.39  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.38  2009/06/23 07:32:58  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.37  2009/06/08 13:23:24  voba
// - enh. унификация атрибутов. Избавился от псевдоатрибутов atDateNumsChDate, atRelHLink,
//
// Revision 1.36  2009/05/19 12:20:48  voba
// - унификация атрибутов
//
// Revision 1.35  2009/05/08 11:10:07  voba
// - заменил TblH на Handle
//
// Revision 1.34  2009/03/02 07:55:08  voba
// - изменил список параметров у constructor TPrometTbl.Create
//
// Revision 1.33  2008/03/20 09:48:36  lulin
// - cleanup.
//
// Revision 1.32  2008/02/07 14:44:41  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.31  2008/01/31 20:38:11  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.30  2007/11/15 14:20:26  voba
// - chng. procedure TActiveIntervalTbl.DelDocActiveInterval Убрал проверку на DocID = 0
//
// Revision 1.29  2007/08/14 20:25:14  lulin
// - bug fix: не собиралася Архивариус.
//
// Revision 1.28  2007/08/14 19:31:55  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.27  2007/08/14 14:30:08  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.26  2007/06/28 11:16:25  voba
// - refact. убрал из function TAbstractList.GetItem второй параметр
//
// Revision 1.25  2007/05/25 15:26:32  voba
// - DeleteRecsByKeys теперь возвращает количество удаленных и подывмает exception в случае ошибок
//
// Revision 1.24  2007/04/25 07:52:37  fireton
// - Рефакторинг. Уходим от прямых упоминаний имен таблиц в пользу перечислимых типов в DT_Types
//
// Revision 1.23  2007/04/10 11:02:09  voba
// - refact.
//
// Revision 1.22  2007/02/22 09:19:54  voba
// - ren DelRecsOnKeys -> DeleteRecsByKeys, _move this to TdtTable
//
// Revision 1.21  2005/08/03 17:38:06  step
// исправлен метод FindDocs и перенесен из модуля Dt_Active в Dt_Doc
//
// Revision 1.20  2004/09/14 15:58:14  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.19  2004/08/03 08:52:50  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.18  2004/07/01 14:14:26  voba
// - merge newCashe
//
// Revision 1.17.14.1  2004/06/17 18:03:48  step
// В методах TAbsHtTbl.AddRec и TAbsHtTbl.UpdRec убран параметр AbsNum.
//
// Revision 1.17  2004/03/05 16:50:12  step
// чистка кода
//
// Revision 1.16  2004/03/05 13:05:49  step
// добавлено "packed" к record
//
// Revision 1.15  2004/03/04 14:33:12  step
// В табл. ACTIVE добавлено поле Typ
//
// Revision 1.14  2003/12/05 16:56:12  voba
// -code clean
//
// Revision 1.13  2003/05/08 08:12:15  voba
// - improvement: переделали возвращаемый результат в GetActiveDocNumbers (ускорение работы)
//
// Revision 1.12  2003/04/28 13:26:11  voba
// - bug fix не копировались свежедобавленные атрибуты
//
// Revision 1.11  2003/04/21 15:21:57  voba
// - bug fix: несохранялось больше одной записи
//
// Revision 1.10  2003/04/10 15:24:57  voba
// -bug fix
//
// Revision 1.9  2003/03/18 17:05:23  demon
// - new behavior: операция AddDocActiveInterval теперь совмещает в себе
// функции add и edit.
//
// Revision 1.8  2003/03/14 13:15:30  demon
// - del: константы minActiveDate, maxActiveDate перенесены в Dt_Const
//
// Revision 1.7  2003/03/14 12:32:48  demon
// - добавлены операции, используемые при пакетном чтении и
// записи данных.
//
// Revision 1.6  2003/03/13 13:00:46  demon
// - new: добавлены функции для проведения операций экспорта
//
// Revision 1.5  2003/03/12 14:59:12  demon
// - new: добавлена операция GetActiveDocNumbers, получение списка активных
// документов из диапазона.
//
// Revision 1.4  2003/03/12 12:10:04  demon
// - синтаксис fix
//
// Revision 1.3  2003/03/11 15:48:55  demon
// - new behavior: добавлено поле для хранения пользовательского коментария и работа с ним.
//
// Revision 1.2  2003/03/11 15:09:54  demon
// - небольшое изменение имен
//
// Revision 1.1  2003/03/11 14:14:13  demon
// - new: Новаый объект-таблица для хранения статусов действия документов.
// Создан базовый комплект функций для работы (get, add, del, edit, find)
//

{$I DtDefine.inc}

interface
uses
 l3Base, l3Date,l3DatLst,
 HT_Const,
 Dt_Types,Dt_Const,
 dtIntf, Dt_Sab, Dt_ATbl,
 dt_Link,
 l3LongintList
 ;

const
 (* константы для полей таблицы *)
 actDocID            = 1;
 actRecID            = 2;
 actTyp              = 3;
 actStart            = 4;
 actFinish           = 5;
 actComment          = 6;
 actRec_Key          = 7; {уникальный ключ}

 ActiveReadFldCount = 5;
 ActiveReadFldArr : Array[1..ActiveReadFldCount] of SmallInt = (actRecID,
                                                                actTyp,
                                                                actStart,
                                                                actFinish,
                                                                actComment);

type
 (* структура данных диапазона действия документа *)
 PActiveIntervalRec = ^TActiveIntervalRec;
 TActiveIntervalRec = packed record
                       RecID   : Byte;
                       Typ     : Byte;
                       Start,
                       Finish  : TStDate;
                       Comment : Array[1..1000] of Char;
                      end;

 TActiveIntervalTbl = class(TDocAttrTbl)
  public
   constructor Create(aFamID : TFamilyID); reintroduce;

   (* Процедура заполняет пользовательский список записями TActiveFullRec, для
      документа, указанного в property DocID *)
   procedure   GetDocActiveIntervalsList(aDocID : TDocID; aList : Tl3CustomDataList);

   (* Процедура заполняет пользовательский список идентификаторами интервалов
      действия, для документа, указанного в property DocID *)
   procedure   GetDocActiveIntervalsIDList(aDocID : TDocID; aList : Tl3LongintList);

   (* Процедура добавляет новый или изменяеет существующий (в зависимости от
      значения RecID) диапазон действия для документа, указанного в property DocID *)
   procedure   AddDocActiveInterval(aDocID : TDocID; aInterval : PActiveIntervalRec);

   (* Процедура удаляет один из диапазонов действия для документа, указанного в
      property DocID*)
   procedure   DelDocActiveInterval(aDocID : TDocID; aRecID : Byte);

   (* Процедура удаляет все диапазоны действия для документа, указанного в
      property DocID*)

   (* Получение списка активных документов (aList) из числа поданных в aDiapason *)
   function    GetActiveDocNumbers(const aDiapason : ISAB) : Tl3LongintList;

    (* Нижняя граница диапазона действия для дока *)
   function    MinDate(aDocID : TDocID) : TstDate;

   (* Операции для процедуры экспорт *)
   function    GetActiveIntervalsOnDoc(aDocID : TDocID) : Sab;
   //function    GetActiveIntervalsOnDocs(aDocSab : Sab) : Sab;

   (* Операция для поиска конкретной записи в таблице с получением ее AbsNum *)
   //function    FindDocActiveIntervalRec(aRecID : Byte;var AbsNum : LongInt) : Boolean;

 end;

implementation
uses
 SysUtils,
 daSchemeConsts,
 HT_Dll,
 dt_AttrSchema,
 Dt_List, Dt_Err;

(******************************** TActiveIntervalTbl *********************************)

type
 (* Уникальный ключ для поиска по таблице *)
 TAIRec_key = record
               DocID   : TDocID;
               RecID   : Byte;
              end;

constructor TActiveIntervalTbl.Create(aFamID : TFamilyID);
var
 CurName : ShortString;
begin
 if aFamID = MainTblsFamily then
  Abort;
 inherited Create(aFamID, atActiveIntervals);
end;

procedure TActiveIntervalTbl.GetDocActiveIntervalsList(aDocID : TDocID; aList : Tl3CustomDataList);
var
 TmpSab,
 DocActives  : Sab;
 TmpMode     : TOpenMode;
 ActivesList : TAbstractList;
 I           : Word;
 SortFld     : SmallInt;
begin
 if (aDocID = 0) then
  raise EHtErrors.CreateInt(ecNotAssigned);

 aList.Clear;

 with fTable do
 begin
  htSearch(nil, tmpSab, Handle, actDocID, Equal, @aDocID, nil);
 end;

 if tmpSab.gFoundCnt > 1 then
 begin
  SortFld:=actStart;
  htSortResults(DocActives,TmpSab,@SortFld,1);
  htClearResults(tmpSab);
 end
 else
  DocActives:=tmpSab;
 try
  if DocActives.gFoundCnt<>0 then
  begin
   aList.DataSize:=SizeOf(TActiveIntervalRec);
   with TmpMode do
   begin
    openMode:=ROPEN_READ;
    FldArr:=@ActiveReadFldArr;
    Count:=ActiveReadFldCount;
   end;
   ActivesList:=TAbstractList.Create(@DocActives,TmpMode);
   try
    ActivesList.ReadForvard:=True;
    for I:=0 to ActivesList.Count-1 do
     aList.Add(ActivesList.GetItem(I));
   finally
    l3Free(ActivesList);
   end;
  end;
 finally
  htClearResults(DocActives);
 end;
end;

(*procedure TActiveIntervalTbl.GetMinPublishDate(aDocID : TDocID) : TStDate;
var
 lSab : ISab;
 lType  : Byte;
begin
 if (aDocID = 0) then
  raise EHtErrors.CreateInt(ecNotAssigned);

 lSab := MakeSab(fTable);
 lSab.Select(actDocID, aDocID);
 lType := Ord(dnPublish);
 lSab.SubSelect(actTyp, lType);
 Result := lSab.GetMinValue(actStart);
end;
*)

function TActiveIntervalTbl.MinDate(aDocID : TDocID) : TstDate;
var
 lSab : ISab;
begin
 lSab := MakeSab(fTable);
 lSab.Select(actDocID, aDocID);
 Result := lSab.GetMinValue(actStart);
end;

procedure TActiveIntervalTbl.GetDocActiveIntervalsIDList(aDocID : TDocID; aList : Tl3LongintList);
var
 tmpSab,
 ValList  : Sab;
 lRecID   : Byte;
begin
 if (aDocID = 0) then
  raise EHtErrors.CreateInt(ecNotAssigned);

 aList.Clear;
 with fTable do
 begin
  htSearch(nil, tmpSab, Handle, actDocID, Equal, @aDocID, nil);
 end;
 try
  if tmpSab.gFoundCnt > 0 then
  begin
   htValuesOfKey(ValList,actRecID,TmpSab);
   try
    if ValList.gFoundCnt>0 then
    begin
     Ht(htOpenResults(ValList,ROPEN_READ,nil,0));
     try
      while htReadResults(ValList,@lRecID,SizeOf(lRecID))<>0 do
       aList.Add(lRecID);
     finally
      htCloseResults(ValList);
     end;
    end;
   finally
    htClearResults(ValList);
   end;
  end;
 finally
  htClearResults(tmpSab);
 end;
end;

procedure TActiveIntervalTbl.AddDocActiveInterval(aDocID : TDocID; aInterval : PActiveIntervalRec);
var
 TmpSab   : Sab;
 AbsNum   : LongInt;
 RecH     : RHANDLE;
 tmpPChar : PChar;
begin
 if (aDocID = 0) then
  raise EHtErrors.CreateInt(ecNotAssigned);

 with fTable do
 begin
  ClearFullRec;
  PutToFullRec(actDocID,aDocID);
  PutToFullRec(actRecID,aInterval^.RecID);
  PutToFullRec(actTyp,aInterval^.Typ);
  PutToFullRec(actStart,aInterval^.Start);
  PutToFullRec(actFinish,aInterval^.Finish);
  tmpPChar:=@(aInterval^.Comment);
  PutToFullRec(actComment,tmpPChar);

  // поищем в таблице запись с таким aInterval^.RecID
  AbsNum := Ht(htRecordByUniq(nil, Handle, actRec_Key, FullRecord, @RecH));

  ///скорректируем aInterval^.RecID
  if aInterval^.RecID <= 0 then
  begin
   htSearch(nil, tmpSab, Handle, actDocID, Equal, @aDocID, nil);
   if tmpSab.gFoundCnt <> 0 then
   begin
    Ht(htKeyMaximum(tmpSab, actRecID, @(aInterval^.RecID)));
    Inc(aInterval^.RecID);
   end
   else
    aInterval^.RecID := 1;

   PutToFullRec(actRecID, aInterval^.RecID);
  end;

  if AbsNum <> 0 then // запись с таким aInterval^.RecID есть в таблице
  begin
   HoldRec(AbsNum);
   try
    UpdFRec(AbsNum);
   finally
    FreeRec(AbsNum);
   end
  end 
  else
   AddFRec;
 end;
end;

procedure TActiveIntervalTbl.DelDocActiveInterval(aDocID : TDocID; aRecID : Byte);
var
 AbsNum  : LongInt;
 RecH    : RHANDLE;
begin
 //if (fDocID = 0) then
 // raise EHtErrors.CreateInt(ecNotAssigned);
 with fTable do
 begin
  ClearFullRec;
  PutToFullRec(actDocID,aDocID);
  PutToFullRec(actRecID,aRecID);
  AbsNum := Ht(htRecordByUniq(nil,Handle,actRec_Key,FullRecord,@RecH));
  if AbsNum <> 0 then
   DelRec(AbsNum);
 end;
end;

function TActiveIntervalTbl.GetActiveDocNumbers(const aDiapason : ISAB) : Tl3LongintList;
var
 lCurDate  : TStDate;
 lDateSub  : ISab;
begin
 Result := nil;
 if not aDiapason.IsEmpty then
 begin
  lCurDate := CurrentDate;
  lDateSub := MakeSab(fTable);
  lDateSub.Select(actStart, lCurDate, Less_Equal);
  lDateSub.SubSelect(actFinish, lCurDate, Great_Equal);

  aDiapason.RecordsByKey(actDocId, lDateSub);
  aDiapason.AndSab(lDateSub);

  if not aDiapason.IsEmpty then
  begin
   // Получение списка идентификаторов документов, действующих на дату
   aDiapason.ValuesOfKey(actDocID);
   Result := dtMakeSortedIDListBySab(aDiapason);
  end;
 end;
end;

function TActiveIntervalTbl.GetActiveIntervalsOnDoc(aDocID : TDocID) : Sab;
begin
 with fTable do
 begin
  l3FillChar(Result,SizeOf(Sab));
  htSearch(nil, Result, Handle, actDocID, Equal, @aDocID, nil);
 end;
end;

{function TActiveIntervalTbl.GetActiveIntervalsOnDocs(aDocSab : Sab) : Sab;
begin
 l3FillChar(Result,SizeOf(Sab));
 htRecordsByKey(Result,aDocSab);
end;

function TActiveIntervalTbl.FindDocActiveIntervalRec(aRecID : Byte;var AbsNum : LongInt) : Boolean;
var
 RecH    : RHandle;
 lKeyRec : TAIRec_key;
begin
 lKeyRec.DocID:=fDocID;
 lKeyRec.RecID:=aRecID;
 AbsNum:=Ht(htRecordByUniq(nil,Handle,actRec_Key,@lKeyRec,@RecH));
 Result:=AbsNum>0;
end;
}
(**********************************************************************************)
end.
