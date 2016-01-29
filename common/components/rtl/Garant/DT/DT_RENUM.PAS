Unit Dt_ReNum;

{ $Id: DT_RENUM.PAS,v 1.76 2015/06/02 14:26:30 voba Exp $ }

// $Log: DT_RENUM.PAS,v $
// Revision 1.76  2015/06/02 14:26:30  voba
// -bf
//
// Revision 1.75  2015/04/03 13:50:42  lukyanets
// Изолируем HT
//
// Revision 1.74  2015/03/13 11:55:46  voba
// - локальное автосохранение документов
//
// Revision 1.73  2013/10/30 09:22:19  fireton
// - список должен быть вегда сортированным (К 497224311)
//
// Revision 1.72  2013/10/24 13:29:34  voba
// - k:495147545
//
// Revision 1.71  2013/10/14 07:19:27  fireton
// - дополнительный конструктор TImportIdToRealIdMap
//
// Revision 1.70  2012/09/20 13:15:20  narry
// Вывод в лог сообщения о превышении размера буфера
//
// Revision 1.69  2012/03/07 08:55:51  narry
// Импорт справок к заблокированным документам (342862487)
//
// Revision 1.68  2011/06/10 12:49:03  voba
// - DocumentServer сделал функцией function DocumentServer(aFamily : TFamilyID), что бы отдельно Family не присваивать
//
// Revision 1.67  2011/01/28 11:28:07  voba
// - k : 251343383
//
// Revision 1.66  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.65  2010/08/03 13:16:38  voba
// - k: 229672814
//
// Revision 1.64  2010/06/18 16:21:10  lulin
// {RequestLink:182452717}.
// - перенумеровываем номер документа из внешнего во внутренний.
//
// Revision 1.63  2009/07/27 09:09:03  voba
// - bug fix
//
// Revision 1.62  2009/07/20 12:38:48  voba
// - Засунул renum в атрибуты
//
// Revision 1.61  2009/06/23 07:32:59  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.60  2009/05/19 12:15:49  voba
// - переход на ISab
//
// Revision 1.59  2009/05/08 11:10:08  voba
// - заменил TblH на Handle
//
// Revision 1.58  2009/05/06 12:00:13  voba
// - add debug code
//
// Revision 1.57  2009/03/02 08:15:39  voba
// - изменил список параметров у constructor TPrometTbl.Create
//
// Revision 1.56  2008/05/07 15:46:21  voba
// - Refact. function .GetRelImportNum и GetINumber убил, вместо нех использовать GetExtDocID
//
// Revision 1.55  2008/04/30 10:14:54  voba
// - add  procedure ChangeHLAddr
//
// Revision 1.54  2008/04/04 15:16:32  fireton
// - внешние номера документов из диапазона
//
// Revision 1.53  2008/03/28 10:00:56  voba
// - ren GetRecordByUniq -> GetRecordIDByUniq
// - ren HasRecordsWith -> HasRecord
//
// Revision 1.52  2008/03/20 09:48:36  lulin
// - cleanup.
//
// Revision 1.51  2008/02/13 14:02:20  voba
// - add   procedure ConvertToInternalNumbers(aExternalIDs : ISab);
//
// Revision 1.50  2008/02/07 14:44:41  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.49  2008/01/31 13:04:19  narry
// - использование констант вместо значений
//
// Revision 1.48  2007/11/15 14:22:02  voba
// - use function TdtTable.DeleteRecByUniq
//
// Revision 1.47  2007/11/12 16:42:12  voba
// - bug fix
//
// Revision 1.46  2007/11/06 12:38:30  voba
// - refact
//
// Revision 1.45  2007/08/14 14:30:08  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.44  2007/06/28 11:16:25  voba
// - refact. убрал из function TAbstractList.GetItem второй параметр
//
// Revision 1.43  2007/05/25 15:20:24  voba
// - DeleteRecsByKeys теперь возвращает количество удаленных и подывмает exception в случае ошибок
//
// Revision 1.42  2007/04/27 14:29:23  voba
// - cc
//
// Revision 1.41  2007/04/25 07:52:37  fireton
// - Рефакторинг. Уходим от прямых упоминаний имен таблиц в пользу перечислимых типов в DT_Types
//
// Revision 1.40  2007/03/23 08:49:52  voba
// - merge with b_archi_BigDictID (повторно)
//
// Revision 1.39.4.1  2007/03/21 08:15:05  voba
// - cc
//
// Revision 1.39  2007/02/27 12:29:47  voba
// - временный запил htGetDiffLength
//
// Revision 1.38  2007/02/22 09:24:29  voba
// - ren DelRecsOnKeys -> DeleteRecsByKeys, _move this to TdtTable
//
// Revision 1.37  2007/02/12 16:11:00  voba
// - заменил использование htModifyRecs на вызов TAbsHtTbl.ModifyRecs
// - выделил TdtTable в модуль dt_Table (обертка вокруг функций HyTech по работе с таблицей целиком)
// - выделил функции HyTech по работе с Sab в dt_Sab, потом объект сделаю
//
// Revision 1.36  2006/10/04 08:36:42  voba
// - add comments
//
// Revision 1.35.2.1  2006/09/19 14:05:22  voba
// - cc
//
// Revision 1.35  2006/06/28 08:36:35  narry
// - исправление: ошибка преобразования номера отсутсвующего документа
//
// Revision 1.34  2006/04/18 12:32:48  voba
// - избавляемся от лишних RefreshSrchList
//
// Revision 1.33.2.1  2006/04/18 12:29:30  voba
// no message
//
// Revision 1.33  2006/03/27 13:54:26  narry
// - исправление: борьба с неконтролируемым использованием памяти
//
// Revision 1.32  2005/06/06 12:46:23  step
// ловим причину появления гиперссылок на нулевой DestDoc
//
// Revision 1.31  2005/02/25 14:24:31  step
// в TReNumTbl.GetBufferedImportNumber добавлен параметр aForced
//
// Revision 1.30  2005/01/19 09:34:51  step
// В TReNumTbl.GetINumber добавлено обновление снимка таблицы
//
// Revision 1.29  2005/01/18 18:35:26  step
// TReNumTbl.GetINumber выполняется в контексте транзакции
//
// Revision 1.28  2004/11/10 12:40:56  step
// переименование метода
//
// Revision 1.27  2004/11/09 09:35:26  step
// изменена логика TReNumTbl.GetRelImportNum
//
// Revision 1.26  2004/09/21 12:04:20  lulin
// - Release заменил на Cleanup.
//
// Revision 1.25  2004/08/03 08:52:49  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.24  2004/07/23 16:41:32  step
// в TReNumTbl.GetINumber добавлен параметр aForced
//
// Revision 1.23  2004/07/13 08:02:34  step
// слияние с веткой b_import_filter_optimization2
//
// Revision 1.22.4.4  2004/07/09 17:08:21  step
// убран отладочный код
//
// Revision 1.22.4.3  2004/07/09 17:05:54  step
// исправлена опечатка
//
// Revision 1.22.4.2  2004/07/09 16:58:54  step
// новый класс TImportIdToRealIdMap; исправлена TReNumTbl.GetRNumber
//
// Revision 1.22.4.1  2004/07/08 17:16:31  step
// исправлен порядок получения FreeNum
//
// Revision 1.22  2004/07/01 14:14:27  voba
// - merge newCashe
//
// Revision 1.21.2.1  2004/06/17 18:03:49  step
// В методах TAbsHtTbl.AddRec и TAbsHtTbl.UpdRec убран параметр AbsNum.
//
// Revision 1.21  2004/06/02 16:42:35  law
// - удален класс Tl3VList.
//
// Revision 1.20  2004/05/20 14:48:20  step
// Замена fFreeTbl на GlobalHtServer.FreeTbl[fFamily]
//
// Revision 1.19  2004/05/13 16:32:18  step
// замена: "TFreeTbl.Create ..." --> "GlobalHtServer.FreeTbl[...]"
//
// Revision 1.18  2004/05/06 09:16:07  voba
// merge with adding_diapasons_table_free2
//
// Revision 1.17.34.1  2004/04/09 16:57:56  step
// Переделан класс TFreeTbl (теперь работает с диапазонами)
//
// Revision 1.17  2003/01/27 11:44:29  demon
// - bug fix: небольшие изменения в функции PureUpdateImportNumber
//
// Revision 1.16  2003/01/22 15:26:44  demon
// - new behavior: в процедуру PureUpdateImportNumber добавлен флаг withCheck
// для проверки необходимости проведения update.
//
// Revision 1.15  2001/08/06 08:30:42  demon
// no message
//
// Revision 1.14.2.1  2001/07/10 12:50:18  demon
// - bug fix
//
// Revision 1.14  2001/02/01 14:10:16  demon
// - fixed freeing of FreeNumList if exception
//
// Revision 1.13  2000/12/15 15:36:16  law
// - вставлены директивы Log.
//

{$I DtDefine.inc}

Interface

Uses
 Contnrs,
 HT_Const,
 Dt_Types,
 DT_aTbl, DT_Sab,
 DT_Free,
 Dt_Link,
 DTIntf,
 l3Base, l3LongintList, l3FieldSortRecList,
 evdInterfaces
 ;

Const
 cNormalRelIndent : LongInt = 100000;

 rnRealID_fld   = 1;
 rnImportID_fld = 2;
Type
 PRenumRec = ^TReNumRec;
 TRenumRec = Record
              RealID,
              ImportID : TDocID;
             end;

 TdtLongintList = class(Tl3LongintList)
 end;

 TReNumTbl = Class({TPrometTbl} TDocAttrTbl, IevdExternalDocNumberToInternal)
  protected
   fBufferedList  : Tl3LongintList;

   function    GetBufferedImportNumber(aID : TDocID) : TDocID;

   procedure   GetBufferedList;
   procedure   FreeBufferedList;
   function    GetBuffered : Boolean;
   procedure   SetBuffered(aVal : Boolean);

   procedure   BeforeRelease; override;
   procedure   AddRecord(aInternalID, aExternalID : TDocID);
  public
   constructor Create(aFamily : TFamilyID {;WithGetFreeNum : Boolean; aSharing: Boolean}); Reintroduce;

   //procedure   UpdateTbl; override;

   //procedure   AddRecord(aInternalID, aExternalID : TDocID);

   function    ConvertToRealNumber(aImpID : LongInt) : LongInt;

   function    ConvertToRealNumbers(Imp_IDs : Sab) : Sab;
   function    ConvertToImportNumbers(Real_IDs : Sab) : Sab;
   procedure   ConvertToInternalNumbers(aExternalIDs : ISab);

   function ConvertExternalDocNumberToInternal(aDocID: Integer): Integer;
   procedure ConvertToExternalNumbers(aInternalIDs: ISab);
   procedure   GetRNumber(Var aID : LongInt);
   function    GetExtDocID(aID : TDocID) : TDocID;

   function    UpdateImportNumber(aRealID,aImpID : LongInt) : Boolean;
   procedure   PureUpdateImportNumber(aRealID,aImpID : LongInt;
                                     withCheck : Boolean = False);

   function  DelAllLinkItems(const aDocIDs: ISab) : integer;  overload;
    {* - удаляет все линки из пачки документов, возвращает количество удаленных}
   procedure DelAllLinkItems(aDocID : TDocID); overload;
    {* - удаляет все линки для документа}

   property    Buffered : Boolean read GetBuffered write SetBuffered;
 end;

 TImportIdToRealIdMap = class(Tl3base)
 private
  f_Map: Tl3FieldSortRecList;
 protected
  procedure Cleanup; override;
 public
  constructor Create(aReNumTbl: TReNumTbl); overload;
  constructor Create(const aReNumTbl: ITblInfo); overload;
  constructor Create(const aSab: ISab); overload;
  function Find(const aImportID: LongWord; out aRealId: LongWord): Boolean;
 end;

Implementation
Uses
 HT_Dll,
 SysUtils,
 Dt_Const,
 dt_AttrSchema,
 dt_Record,
 Dt_Serv, Dt_Doc, Dt_Err,
 Dt_List, Dt_Hyper,
 dt_LinkServ;

(**************************** TReNumTbl ********************************)

Constructor TReNumTbl.Create(aFamily : TFamilyID);
Begin
 Assert(aFamily <> MainTblsFamily);
 inherited Create(aFamily, atRenum);
end;

Procedure TReNumTbl.BeforeRelease;
Begin
 if fBufferedList <> Nil then FreeBufferedList;
 //GlobalHtServer.FreeTbl[TblFamily].ExclusiveUse := False;
 (*
 RefreshSrchList;
 If fUpdInt > 0 then
 Begin
  DiffLength := htGetDiffLength(fSrchList);
  If DiffLength > 32 then UpdateTbl;
 end;
 *)
 Inherited;
end;

{Procedure TReNumTbl.UpdateTbl;
Begin
 Try
  Inherited UpdateTbl;
 except
 end;
end;}

procedure TReNumTbl.GetBufferedList;
Var
 MaxNum   : LongInt;
 ReNumRec : PReNumRec;
 NumList  : TAbstractList;
 tmpMode  : TOpenMode;
 I        : LongInt;
 lSab     : Sab;
begin
 with Table do
 begin
  l3Free(fBufferedList);
  fBufferedList:= TdtLongintList.Make; //Tl3LongintList.Make;
  try
   lSab := MakeAllRecordsSab;
   MaxNum :=0;
   htKeyMaximum(lSab,rnRealID_fld,@MaxNum);
   Inc(MaxNum);
   fBufferedList.Count := MaxNum+1;
   tmpMode.openMode := ROPEN_BODY;
   tmpMode.Count:=0;
   tmpMode.FldArr:=Nil;
   NumList:=TAbstractList.Create(@lSab,tmpMode);
   try
    NumList.ReadForvard:=True;
    for I:=0 to NumList.Count-1 do
    begin
     ReNumRec := NumList.GetItem(I);
     fBufferedList.Items[RenumRec^.RealID]:=RenumRec^.ImportID;
    end;
   htClearResults(lSab);
  finally
   l3Free(NumList);
  end;
  except
   l3Free(fBufferedList);
   l3System.Msg2log('Не удалось выделить буфер под %d элементов', [MaxNum]);
   raise;
  end;
 end; //with Table do
end;

procedure TReNumTbl.FreeBufferedList;
begin
 l3Free(fBufferedList);
end;

function TReNumTbl.GetBuffered : Boolean;
begin
 Result:=fBufferedList<>nil;
end;

procedure TReNumTbl.SetBuffered(aVal : Boolean);
begin
 if (fBufferedList<>nil) and not aVal then FreeBufferedList;
 if (fBufferedList=nil) and aVal then GetBufferedList;
end;

Function TReNumTbl.ConvertToRealNumber(aImpID : LongInt) : LongInt;
begin
 if aImpID = 0 then exit;
 with InitRecord(Self) do
  if FindByUniq(rnImportID_fld, aImpID) then
   GetField(rnRealID_fld, Result)
  else
   Result := cUndefDocID;
end;

(*
Function TReNumTbl.ConvertToImportNumber(Real_ID : LongInt) : LongInt;
Var
 AbsNum : LongInt;
 RecH   : RHANDLE;
Begin
 Result:= cUndefDocID;
 If Real_ID=0 then exit;
 AbsNum:=Ht(htRecordByUniq(nil,Handle,rnRealID_fld,@Real_ID,@RecH));
 If AbsNum<>0
  then
   Begin
    GetFullRec(AbsNum,False);
    GetFromFullRec(rnImportID_fld,Result);
   end;
end;
*)

function TReNumTbl.ConvertToRealNumbers(Imp_IDs : Sab) : Sab;
var
 TmpSab  : SAB;
begin
 with Table do
 begin
  htTransferToTable(Imp_IDs, Handle, rnImportID_fld);
  if Imp_IDs.nRetCode = 0 then
  Begin
   htRecordsByKey(TmpSab, Imp_IDs);
   try
    htValuesOfkey(Result, rnRealID_fld, TmpSab);
   finally
    htClearResults(TmpSab);
   end;
  end;
 end; //with Table
end;

procedure TReNumTbl.ConvertToInternalNumbers(aExternalIDs : ISab);
begin
 aExternalIDs.TransferToPhoto(rnImportID_fld, Self);
 aExternalIDs.RecordsByKey;
 aExternalIDs.ValuesOfKey(rnRealID_fld);
end;

Function TReNumTbl.ConvertToImportNumbers(Real_IDs : Sab) : Sab;
var
 TmpSab  : SAB;
begin
 with Table do
 begin
  htTransferToTable(Real_IDs,Handle,rnRealID_fld);
  if Real_IDs.nRetCode = 0 then
  Begin
   htRecordsByKey(TmpSab,Real_IDs);
   try
    htValuesOfkey(Result,rnImportID_fld,TmpSab);
   finally
    htClearResults(TmpSab);
   end;
  end;
 end; //with Table
end;

procedure TReNumTbl.AddRecord(aInternalID, aExternalID : TDocID);
begin
 with Table do
 begin
  ClearFullRec;
  PutToFullRec(rnRealID_fld, aInternalID);
  PutToFullRec(rnImportID_fld, aExternalID);
  AddFRec;
 end; //with Table
end;

procedure TReNumTbl.GetRNumber(Var aID : LongInt);
var
 lID    : TDocID;
begin
 if aID = 0 then exit;
 lID := ConvertToRealNumber(aID);
 if lID < 0 then
 begin
  lID := DocumentServer(Table.TblFamily).FileTbl.GetFreeNum;
  if lID <= 0 then
  begin
   l3System.Msg2Log(format('TReNumTbl.GetRNumber: IntID = %d ExtID = %d', [lID, aID]));
   lID := DocumentServer(Table.TblFamily).FileTbl.GetFreeNum;
   Assert(lID > 0, format('try another one TReNumTbl.GetRNumber: IntID = %d ExtID = %d', [lID, aID]));
   l3System.Msg2Log('Recover!!');
  end;
  AddRecord(lID, aID);
 end;
 aID := lID;
end;

function TReNumTbl.ConvertExternalDocNumberToInternal(aDocID: Integer): Integer;
begin
 Result := aDocID;
 GetRNumber(Result);
end;

procedure TReNumTbl.ConvertToExternalNumbers(aInternalIDs: ISab);
begin
 aInternalIDs.TransferToPhoto(rnRealID_fld, Self);
 aInternalIDs.RecordsByKey;
 aInternalIDs.ValuesOfKey(rnImportID_fld);
end;

function  TReNumTbl.GetBufferedImportNumber(aID : TDocID) : TDocID;
begin
 try
  Result := fBufferedList.Items[aID];
  if Result = 0 then
   Result := cUndefDocID;
 except
  Result := cUndefDocID;
 end;
end;

function TReNumTbl.GetExtDocID(aID : TDocID) : TDocID;
begin
 Assert(aID > 0,'TReNumTbl.GetExtDocID: aID = 0');

 if Buffered then
  Result := GetBufferedImportNumber(aID)
 else
  with InitRecord(Self) do
   if FindByUniq(rnRealID_fld, aID) then
    GetField(rnImportID_fld, Result)
   else
    Result := cUndefDocID;
end;

Function TReNumTbl.UpdateImportNumber(aRealID,aImpID : LongInt) : Boolean;
Var
 AbsNum     : LongInt;
 RecH       : RHANDLE;

 TmpRID     : LongInt;
 RelFlag    : Boolean;
 lRecNum_Imp : LongInt;
 lRecNum_Int : LongInt;
Begin
 with Table do
 begin
  if aRealID = 0 then
   raise Exception.Create('Вызов TReNumTbl.UpdateImportNumber с параметром aRealID = 0.');

  Result := False;
  lRecNum_Imp := Ht(htRecordByUniq(nil, Handle, rnImportID_fld, @aImpID, @RecH));
  if lRecNum_Imp <> 0 then
  begin
   TmpRID := 0;
   GetFullRec(lRecNum_Imp, False);
   GetFromFullRec(rnRealID_fld, TmpRID);
   if TmpRID = aRealID then
   begin
    Result := True;
    exit;
   end;

   if not DocumentServer(TblFamily).CheckDoc(TmpRID,True,RelFlag) then
   //если дока с таким внутренним в базе нет (только в ренуме)
   begin
    DocumentServer(TblFamily).ChangeHLAddr(TmpRID, AllSubs, aRealID, AllSubs);
    //если aImpID был ранее закреплен за другим внутренним номером,
    // то нужно исправить все ссылки, которые ссылаются на этот внутренний номер

    //GlobalHtServer.FreeTbl[TblFamily].PutFree(DocPrefName+IntToHex(TblFamily,3),TmpRID);
   end
   else
    exit;
  end; //if lRecNum_Imp <> 0 then

  lRecNum_Int := Ht(htRecordByUniq(nil, Handle, rnRealID_fld, @aRealID, @RecH));

  if lRecNum_Int <> 0 then
  begin
   //удалим найденную по внешнему номеру
   if lRecNum_Imp <> 0 then
    DelRec(lRecNum_Imp);
   //исправим найденную по внутреннему номеру
   GetFullRec(lRecNum_Int, True);
   try
    PutToFullRec(rnImportID_fld, aImpID);
    UpdFRec(lRecNum_Int);
    Result := True;
   finally
    FreeRec(lRecNum_Int);
   end;
  end
  else //if lRecNum_Int <> 0 then
   if lRecNum_Imp = 0 then
   begin
    AddRecord(aRealID, aImpID);
    Result := True;
   end
   else
   begin
    //исправим найденную по внешнему номеру
    GetFullRec(lRecNum_Imp, True);
    try
     PutToFullRec(rnRealID_fld, aRealID);
     UpdFRec(lRecNum_Imp);
     Result := True;
    finally
     FreeRec(lRecNum_Imp);
    end;
   end; //if lRecNum_Int <> 0 then
 end; //with Table
end;

procedure TReNumTbl.PureUpdateImportNumber(aRealID, aImpID : LongInt; withCheck : Boolean);
var
 AbsNum     : LongInt;
 RecH       : RHANDLE;
 tmpID      : LongInt;
begin
 with Table do
 begin
 AbsNum:=Ht(htRecordByUniq(nil,Handle,rnImportID_fld,@aImpID,@RecH));
 if AbsNum > 0 then
  if withCheck then
  begin
   GetFullRec(AbsNum,False);
   GetFromFullRec(rnRealID_fld,tmpID);
   if tmpID=aRealID then
    exit
   else
    raise EHtErrors.CreateInt(ecNotUniqID);
  end
  else
   raise EHtErrors.CreateInt(ecNotUniqID);

 AbsNum:=Ht(htRecordByUniq(nil,Handle,rnRealID_fld,@aRealID,@RecH));
 if AbsNum > 0 then
 begin
  GetFullRec(AbsNum,True);
  try
   if withCheck then
   begin
    GetFromFullRec(rnImportID_fld,tmpID);
    if tmpID<>aImpID then
    begin
     PutToFullRec(rnImportID_fld,aImpID);
     UpdFRec(AbsNum);
    end;
   end
   else
   begin
    PutToFullRec(rnImportID_fld,aImpID);
    UpdFRec(AbsNum);
   end;
  finally
   FreeRec(AbsNum);
  end;
 end
 else
  if AbsNum = 0 then
   AddRecord(aRealID, aImpID);
 end; //with Table
end;

procedure TReNumTbl.DelAllLinkItems(aDocID : TDocID);
begin
 Table.DeleteRecByUniq(rnRealID_fld, aDocID);
end;

function TReNumTbl.DelAllLinkItems(const aDocIDs: ISab) : integer;
begin
 Result := 1;
 Table.DeleteRecsByKeys(aDocIDs, rnRealID_fld);
end;

{ TImportIdToRealIdMap }

constructor TImportIdToRealIdMap.Create(aReNumTbl: TReNumTbl);
begin
 Create(aReNumTbl as ITblInfo);
end;

constructor TImportIdToRealIdMap.Create(const aReNumTbl: ITblInfo);
var
 lSab : ISab;
begin
 Assert(aReNumTbl <> nil, 'Не указан параметр при вызове функции TImportIdToRealIdMap.Create.');
 lSab := MakeSab(aReNumTbl);
 lSab.SelectAll;
 Create(lSab);
end;

constructor TImportIdToRealIdMap.Create(const aSab: ISab);
var
 lSab : ISab;
begin
 Assert(aSab <> nil, 'Не указан параметр при вызове функции TImportIdToRealIdMap.Create.');
 inherited Create;
 lSab := MakeSabCopy(aSab);
 f_Map := dtMakeRecListBySab(lSab,
                             [], // все поля
                             [rnImportID_fld] // сортировка по второму полю (внешний номер)
                             );
end;

function TImportIdToRealIdMap.Find(const aImportID: LongWord;
                                  out aRealId: LongWord): Boolean;
var
 lIndexExists : Integer;
 lRenumRec : record
  rIntNum : TDocID;
  rExtNum : TDocID;
 end;

begin
 lRenumRec.rExtNum := aImportID;
 Result := f_Map.Find(lRenumRec, lIndexExists);
 if Result then
  aRealId := PDocID(f_Map.ItemSlot(lIndexExists))^ //возмем первое поле
end;

procedure TImportIdToRealIdMap.Cleanup;
begin
 l3Free(f_Map);
 inherited;
end;

end.

