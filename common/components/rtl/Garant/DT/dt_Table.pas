Unit dt_Table;

{ $Id: dt_Table.pas,v 1.60 2015/09/10 15:04:26 voba Exp $ }

// $Log: dt_Table.pas,v $
// Revision 1.60  2015/09/10 15:04:26  voba
// no message
//
// Revision 1.59  2015/09/09 06:15:09  lukyanets
// Не закрывалась скобка
//
// Revision 1.58  2015/08/31 08:45:46  lukyanets
// Дополнительные тестовые логи
//
// Revision 1.57  2015/08/20 13:02:18  lukyanets
// Присматриваемся к транзакциям
//
// Revision 1.55  2015/07/09 14:17:41  voba
// -bf расчет приорити
//
// Revision 1.54  2015/06/04 13:45:14  lukyanets
// Пробуем залить данные
//
// Revision 1.53  2015/05/18 13:11:34  lukyanets
// Cleanup
//
// Revision 1.52  2014/12/25 15:40:52  voba
// - функции восстановления Priority и SortDate
//
// Revision 1.51  2014/11/21 12:19:19  fireton
// - лог ошибки при закрытии таблицы
//
// Revision 1.50  2014/05/21 14:28:16  voba
// no message
//
// Revision 1.49  2014/04/17 13:04:32  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.48  2014/02/14 15:33:45  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.47  2013/04/19 13:07:39  lulin
// - портируем.
//
// Revision 1.46  2013/04/09 12:37:51  narry
// Не компилировалось
//
// Revision 1.45  2013/01/16 09:38:01  voba
// -add procedure ExportToFile
//
// Revision 1.44  2013/01/03 05:20:54  narry
// Новый метод DropTable - удаление всех файлов таблицы
//
// Revision 1.43  2012/07/16 11:17:19  voba
// no message
//
// Revision 1.42  2010/09/28 13:06:09  fireton
// - Распределяем память для PAnsiChar своими средствами
//
// Revision 1.41  2010/08/03 13:16:38  voba
// - k: 229672814
//
// Revision 1.40  2009/10/26 14:38:07  voba
// - add  procedure AddRec, UpdRec
//
// Revision 1.39  2009/09/11 08:36:43  voba
// - use DT_Record
//
// Revision 1.38  2009/08/04 11:45:32  voba
// - bug fix - вернул залочку выборки при модификации пачки записей
//
// Revision 1.37  2009/08/03 12:14:55  voba
// - bug fix - залочка выборки при модификации пачки записей
//
// Revision 1.36  2009/06/23 07:32:59  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.35  2009/05/12 14:11:09  voba
// - bug fix function TdtTable.DeleteRecsByKeys
//
// Revision 1.34  2009/05/12 08:41:38  voba
// - заменил в ISab ссылки на таблицу на интерфейсы
//
// Revision 1.33  2009/05/08 11:10:08  voba
// - заменил TblH на Handle
//
// Revision 1.32  2009/04/21 08:05:16  voba
// - отпилил от TdtTable информационную часть TdtTableInfo
//
// Revision 1.31  2009/03/23 08:32:41  voba
// - move procedure TemporalCloseTbl;ReOpenTbl; DropTblData; UpdateTbl to dt_Table
//
// Revision 1.30  2009/02/17 15:26:04  voba
// - bug fix: не освобождался Handle таблицы
//
// Revision 1.29  2009/01/26 08:06:17  fireton
// - слияние с веткой b_archi_NewSrch2 (поиск по-новому)
//
// Revision 1.28.6.1  2008/12/25 10:18:31  fireton
// - перевод спецпоисков на TdtQuery
//
// Revision 1.28  2008/05/22 13:05:53  voba
// - add  aDupIgnore to procedure ChangeValues
//
// Revision 1.27  2008/05/07 15:40:08  voba
// - Refact. function .HasRecord переехала на dt_Table
//
// Revision 1.26  2008/04/16 14:18:09  voba
// - перенес залочку таблиц на TdtTable
//
// Revision 1.25  2008/04/07 10:14:35  voba
// - add procedure ChangeValues
//
// Revision 1.24  2008/03/28 09:57:27  voba
// - ren GetRecordByUniq -> GetRecordIDByUniq
//
// Revision 1.23  2007/12/28 16:19:42  fireton
// no message
//
// Revision 1.22  2007/12/19 13:00:32  fireton
// - перенос части функционала из DT_ATbl в DT_Table
// - Ok теперь локальная переменная (l_Ok)
//
// Revision 1.21  2007/12/03 16:19:55  voba
// - cc
//
// Revision 1.20  2007/11/15 14:16:57  voba
// - add function  DeleteRecByUniq
// - add procedure DelRec
//
// Revision 1.19  2007/11/06 12:34:13  voba
// - cc
//
// Revision 1.18  2007/10/10 13:14:28  voba
// - enh procedure TdtTable.CopyRecs
//
// Revision 1.17  2007/09/19 07:57:05  voba
// no message
//
// Revision 1.16  2007/08/14 20:25:15  lulin
// - bug fix: не собиралася Архивариус.
//
// Revision 1.15  2007/08/14 19:31:56  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.14  2007/08/14 14:30:09  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.13  2007/06/20 11:48:13  voba
// - add dict dlServiceInfo
//
// Revision 1.12  2007/05/25 15:16:49  voba
// - DeleteRecsByKeys теперь возвращает количество удаленных и подывмает exception в случае ошибок
//
// Revision 1.11  2007/04/27 14:30:19  voba
// - ren  L2RecModifyProc -> L2RecAccessProc
//
// Revision 1.10  2007/04/10 10:36:11  voba
// - bug fix with htReadResults
//
// Revision 1.9  2007/03/26 09:34:03  fireton
// - изменился формат l3System.FreeLocalMem
//
// Revision 1.8  2007/03/23 08:49:53  voba
// - merge with b_archi_BigDictID (повторно)
//
// Revision 1.7.2.2  2007/03/22 14:29:51  voba
// - add function GetRecordByUniq
//
// Revision 1.7.2.1  2007/03/21 08:13:58  voba
// - add  procedure AddRecs(aRecsBuffer : Pointer; aRecsCount : Cardinal); overload;
//
// Revision 1.7  2007/03/05 08:44:13  voba
// - refact..
//
// Revision 1.6  2007/03/02 10:09:40  voba
// - bug fix htSubSearch Bug
//
// Revision 1.5  2007/03/02 09:49:36  voba
// - bug fix htSubSearch Bug
//
// Revision 1.4  2007/02/28 19:34:31  voba
// - add   function  RecordSize
//
// Revision 1.3  2007/02/22 09:26:10  voba
// - ren DelRecsOnKeys -> DeleteRecsByKeys, _move this to TdtTable
//
// Revision 1.2  2007/02/21 07:26:06  voba
// - bug fix
//
// Revision 1.1  2007/02/16 16:16:43  voba
// no message
//

interface
uses
 Classes,
 SysUtils,
 l3Base,
 HT_Const,
 dtIntf,
 DT_Types, DT_Const,
 dt_TblInfo,
 DT_Record,
 dt_Sab;

const
 cMaxAddTime = 1800; (* 30 минут *)
 cMaxModTime =  600; (* 10 минут *)

type
 TdtTable = class(TdtTblInfo, IEditTbl)
  private
   f_TblFullName   : TPathStr;
   f_TblPass       : AnsiString;
   f_TblShareFlag: SmallInt;

   function GetInTransaction: Boolean;
  protected

   fTblLckCount : integer;

   f_TransID   : HT_Const.TRID;
   f_InOwnTransaction: Boolean;  // таблица находится в "своей собственной" транзакции,
                                  // т.е. в транзакции запущенной методом Self.StartTA (только так)

   fIsTemporalClose : Integer;

   function  StartTA(aTransTime: Word = DefaultTransTime): Boolean; virtual;
   procedure SuccessTA; virtual;
   procedure RollBackTA; virtual;

   procedure Cleanup; override;

   function    IsTblHeld: Boolean; override;
   function    TblHold(var Res : LongInt) : Boolean;

   procedure LockSab(var aSab : Sab);
   procedure UnlockSab(var aSab : Sab);

  public
   constructor Create(aPath : TPathStr; aPass : TPassStr; aName : TTblNameStr; aShare : SmallInt); reintroduce;
   constructor CreateWithOpen(aPath : TPathStr; aPass : TPassStr; aName : TTblNameStr; aShare : SmallInt);
   constructor CreateDup(aTable: TdtTable);

   procedure LockTbl;
   procedure UnlockTbl;

   procedure   TemporalCloseTbl; virtual;
     {* - "временное" закрытие таблицы для использования операций HyTech
           применимых только к закрытым таблицам. После проведения таких
           операций используйте ReOpenTbl. }
   procedure   ReOpenTbl; virtual;
    {* - Переоткрытие таблицы после TemporalCloseTbl. Если перед применением
          TemporalCloseTbl таблица не была открыта - реального открытия таблиц
          не происходит. }

   procedure DropTblData; virtual;
   procedure UpdateTbl; virtual;

   function  GetRecordIDByUniq(aField : ThtField; const aKeyValue; aRecHandle : pRHandle = nil; aPhoto: LPSAB = nil): Longint;
   function  GetRecordByUniq(const aKeyValue) : TdtRecord;

   function  HasRecord(aField: ThtField; const aFieldValue): Boolean;
   function  HasUniqRec(var aFieldValue): Boolean;

   procedure GetFieldFromRecord(aRecord : PAnsiChar; aField : ThtField; var aBody); virtual; //overload;
   //procedure GetFieldFromRecord(const aRecHandle : RHandle; aField : Word; var aBody); overload;

   procedure PutFieldToRecord(aRecord : PAnsiChar; aField : ThtField; const aBody); virtual;
   procedure ClearTransId;

   procedure AddRec(aRec: Pointer); virtual;
   procedure UpdRec(aAbsNum  : LongInt; aRec : Pointer); virtual;

   procedure AddRecs(aRecsBuffer : TStream); overload;
   procedure AddRecs(aRecCount : Cardinal; aFillBuffProc : TFillBufferProc); overload;
   procedure AddRecs(aRecsBuffer : Pointer; aRecsCount : Cardinal); overload;
    {* - добавляет записи aRecs в таблицу, проблемные игнорирует}

   procedure CopyRecs(aRecs : ISabCursor; aModifyProc : TdtRecAccessProc); overload;
    {* - добавляет в таблицу копии записи aRecs, предварительно модифицированные в aModifyProc}
   procedure CopyRecs(aRecs : Sab; aModifyProc : TdtRecAccessProc); overload;
    {* - добавляет в таблицу копии записи aRecs, предварительно модифицированные в aModifyProc}
   procedure CopyRecs(aRecs : ISab; aModifyProc : TdtRecAccessProc); overload;
    {* - добавляет в таблицу копии записи aRecs, предварительно модифицированные в aModifyProc}

   procedure ModifyRecs(aRecs : Sab; aField : ThtField; aValue : Pointer; aDupIgnore : Boolean = False); overload;
   procedure ModifyRecs(aRecs : Sab; aModifyProc : Pointer; aDupIgnore : Boolean = False; aNeedLock : boolean = True); overload;

   procedure ChangeValues(aField : ThtField; var aOldValue;  var aNewValue; aDupIgnore : Boolean = False);

   procedure DelRec(aAbsNum  : Longint); virtual;
   function  DeleteRecByUniq(aUniqFld : ThtField; var aValue): Boolean;
   function  DeleteRecsByKeys(aSabOfKeyValues : Sab; aKeyFld : ThtField): Integer; overload;
   function  DeleteRecsByKeys(const aSabOfKeyValues : ISab; aKeyFld : ThtField): Integer;  overload;

   procedure OpenTbl; virtual;
   procedure CloseTbl; virtual;

   procedure DropTable; virtual;

   function  RecordAsString(aRecord: PAnsiChar): AnsiString;

   procedure ExportToFile(const aFileName : AnsiString; aQuote : Char = '"'; aDelimiter : Char = #9);
   function  PhotoOfTable : Sab;

   property  IsTableOpened : Boolean read fIsTableOpened write fIsTableOpened;
   property  TransID : HT_Const.TRID read f_TransID write f_TransID;
   property  InTransaction: Boolean read GetInTransaction;
   property  TblFullName: TPathStr read f_TblFullName;
   property  TblPass: AnsiString read f_TblPass;
   property  TblShareFlag: SmallInt read f_TblShareFlag;
 end;

 function MakeITbl(aPath : TPathStr; aPass : TPassStr; aName : TTblNameStr; aShare : SmallInt) : ITblInfo;
 function MakeITblWithOpen(aPath : TPathStr; aPass : TPassStr; aName : TTblNameStr; aShare : SmallInt) : ITblInfo;

 procedure SignalStartTransaction;
 procedure SignalEndTransaction;

implementation
 uses
  l3FileUtils,
  l3MinMax, l3String,
  l3Types, l3Stream,
  l3Interlocked,
  DT_SabHelp,
  HT_Dll,
  DT_Err, DT_Misc{, l3Filer};

const
 cRecordsAdditionCriteria = 100;

 c_EmptyTrId: HT_Const.TRID = (mTrID:((0),(0),(0),(0),(0),(0)));

var
 g_TransactionCounter: Integer;

{ TAbsHtTbl }
constructor TdtTable.Create(aPath : TPathStr; aPass : TPassStr; aName : TTblNameStr; aShare : SmallInt);
begin
 inherited Create;
 ClearTransId;
 fTblName:=aName;
 f_TblFullName := ConcatDirName(aPath, aName) + #0;
 f_TblPass:=aPass+#0;
 f_TblShareFlag:=aShare;
end;

constructor TdtTable.CreateDup(aTable: TdtTable);
begin
 Assert(aTable <> nil);
 inherited Create;
 ClearTransId;
 fTblName := aTable.TblName;
 f_TblFullName := aTable.TblFullName;
 f_TblPass := aTable.TblPass;
 f_TblShareFlag := aTable.TblShareFlag;
 OpenTbl;
 AllocTblInfo;
end;

constructor TdtTable.CreateWithOpen(aPath : TPathStr; aPass : TPassStr; aName : TTblNameStr; aShare : SmallInt);
begin
 Create(aPath, aPass, aName, aShare);
 OpenTbl;
 AllocTblInfo;
end;

procedure TdtTable.AddRec(aRec: Pointer);
begin
 HT(htRecordAdd(Handle, aRec));
end;

procedure TdtTable.UpdRec(aAbsNum : LongInt; aRec : Pointer);
begin
 HT(htRecordModify(Handle, aAbsNum, aRec));
end;

procedure TdtTable.AddRecs(aRecsBuffer : Pointer; aRecsCount : Cardinal);
var
 lOffs : Integer;
 lRecsBufSize : Longint;

 function lFillBufferProc(aBuffer : Pointer; aBufSize : Longint): Longint;
 begin
  Result := Min(aBufSize, lRecsBufSize - lOffs);
  l3Move((PAnsiChar(aRecsBuffer) + lOffs)^, aBuffer^,  Result);
  Inc(lOffs, Result);
 end;

var
 lFillBufferProcStub : TFillBufferProc;

begin
 if (aRecsBuffer = nil) or (aRecsCount = 0) then Exit;

 lRecsBufSize := aRecsCount * RecSize;
 lOffs := 0;

 lFillBufferProcStub := L2FillBufferProc(@lFillBufferProc);
 try
  AddRecs(aRecsCount, lFillBufferProcStub);
 finally
  FreeFillBufferProc(lFillBufferProcStub);
 end;
end;

procedure TdtTable.AddRecs(aRecsBuffer : TStream);

 function lFillBufferProc(aBuffer: Pointer; aBufSize: Longint): Longint;
 begin
  Result := aRecsBuffer.Read(aBuffer^, aBufSize);
 end;

var
 lRecCount : Cardinal;
 lFillBufferProcStub : TFillBufferProc;
begin
 if (aRecsBuffer = nil) or (aRecsBuffer.Size = 0) then Exit;
 lRecCount := aRecsBuffer.Size div RecSize;
 aRecsBuffer.Seek(0,soBeginning);

 lFillBufferProcStub := L2FillBufferProc(@lFillBufferProc);
 try
  AddRecs(lRecCount, lFillBufferProcStub);
 finally
  FreeFillBufferProc(lFillBufferProcStub);
 end;
end;

procedure TdtTable.AddRecs(aRecCount : Cardinal; aFillBuffProc : TFillBufferProc);

 function lAddBufferedData(nOrder : Add_Mode; fpParm : LPAPARM): Cardinal;
  begin
   try
    if nOrder = Add_Last then
     Result := 0
    else
     Result := aFillBuffProc(fpParm^.fpBuf, fpParm^.wBufLen);
   except
    Result := High(Cardinal);
   end;
  end;

 function lHTErrorHandlerWrapper(nErrCode: SmallInt; fpRecord: Pointer): ERROR_MODE;
  begin
   //if IgnoreDuplicates then
    Result := ERROR_DELETE
   // else
   // Result := ERROR_ABORT;
  end;

var
 lCurRec   : Pointer;
 I         : Cardinal;
 lHTStub   : Pointer;
 lHTStubErr : Pointer;
 {$IfDef DEBUGOUT2}
   lStartTime : Cardinal;
  {$EndIf}
begin
 if aRecCount > cRecordsAdditionCriteria then  // при большом количестве записей добавлять по одной весьма накладно
 begin
  if StartTA(cMaxAddTime) then
  try
   lHTStub := HTStub3(@lAddBufferedData);
   try
    lHTStubErr := HTStub3(@lHTErrorHandlerWrapper);
    try
     {$IfDef DEBUGOUT2}
     lStartTime := dbgStartTimeCounter;
     {$EndIf}
     dtCheckErr(htAddRecords(Handle, aRecCount, lHTStub, lHTStubErr, Self, False));
     {$IfDef DEBUGOUT2}
     l3System.Msg2Log('AddRecs Batch (Table = %s) RecCount = %d : %s', [TblName, aRecCount, dbgFinishTimeCounter(lStartTime)]);
     {$EndIf}
    finally
     HTStubFree(lHTStubErr);
    end;
   finally
    HTStubFree(lHTStub);
   end;
   SuccessTA;
  except
   RollBackTA;
   raise;
  end;
 end
 else // if aRecCount > RecordsAdditionCriteria then
 begin
  l3System.GetLocalMemZ(lCurRec, RecSize);
  try
  {$IfDef DEBUGOUT2}
  lStartTime := dbgStartTimeCounter;
  {$EndIf}
   for I := 1 to aRecCount do
   begin
    if aFillBuffProc(lCurRec, RecSize) = RecSize then
     dtCheckErr(htRecordAdd(Handle, lCurRec));
   end;
  {$IfDef DEBUGOUT2}
  l3System.Msg2Log('AddRecs Singl (Table = %s) RecCount=%d : %s', [TblName, aRecCount, dbgFinishTimeCounter(lStartTime)]);
  {$EndIf}
  finally
   l3System.FreeLocalMem(lCurRec);
  end;
 end;
end;

{TdtTable}
procedure TdtTable.Cleanup;
begin
 CloseTbl;
 if Assigned(fFields) then
  l3System.FreeLocalMem(fFields);
 inherited;
end;

procedure TdtTable.TemporalCloseTbl;
begin
 if IsTableOpened then
 begin
  CloseTbl;
  fIsTemporalClose := 1;
 end
 else
  if fIsTemporalClose > 0 then
   Inc(fIsTemporalClose);
end;

procedure TdtTable.ReOpenTbl;
begin
 if fIsTemporalClose = 1 then OpenTbl;
 if fIsTemporalClose > 0 then Dec(fIsTemporalClose);
end;

procedure TdtTable.DropTblData;
var
 hTable : HT_Const.THANDLE;
 l_Ok : Longint;
begin
 TemporalCloseTbl;
 try
  l_Ok:=htTableHandleByName(@TblFullName[1],hTable);
  if l_Ok < 0 then
   Ht(htDropTableData(@TblFullName[1],@TblPass[1],@TblPass[1]));
 finally
  ReOpenTbl;
 end;
end;

procedure TdtTable.UpdateTbl;
var
 hTable : HT_Const.THANDLE;
 l_Ok : Longint;
begin
 TemporalCloseTbl;
 try
  l_Ok:=htTableHandleByName(@TblFullName[1],hTable);
  if l_Ok < 0 then
   Ht(htUpdateTable(@TblFullName[1],@TblPass[1],@TblPass[1],True,False));
 finally
  ReOpenTbl;
 end;
end;

procedure TdtTable.ClearTransId;
begin
 f_TransID := c_EmptyTrId;
end;

procedure TdtTable.CloseTbl;
var
 l_S: AnsiString;
begin
 if IsTableOpened then
 begin
  try
   Ht(htTableClose(Handle));
   IsTableOpened := False;
  except
   if Assigned(Self) then
    l_S := 'валиден'
   else
    l_S := 'невалиден';
   l3System.Msg2Log('Ошибка при закрытии таблицы. Handle = %d. Объект %s.', [Handle, l_S]);
   raise;
  end;
 end;
end;

function TdtTable.StartTA(aTransTime: Word = DefaultTransTime): Boolean;
begin
 Result := False;
 CheckIsOpen;
 if not InTransaction then
 begin
  htSetTransTimeOut(aTransTime);
  Ht(htStartTransaction(@fTblH, 1, f_TransID));
  SignalStartTransaction;
  f_InOwnTransaction := True;
 end;
 Result := True;
end;

procedure TdtTable.SuccessTA;
begin
 CheckIsOpen;
 if f_InOwnTransaction then
 begin
  Ht(htCommitTransaction(f_TransID));
  SignalEndTransaction;
  f_InOwnTransaction := False;
  ClearTransId;
  htSetTransTimeOut(DefaultTransTime);
 end;
end;

procedure TdtTable.RollBackTA;
begin
 CheckIsOpen;
 if f_InOwnTransaction then
 begin
  Ht(htRollBackTransaction(f_TransID));
  SignalEndTransaction;
  f_InOwnTransaction := False;
  ClearTransId;
  htSetTransTimeOut(DefaultTransTime);
 end;
end;

procedure TdtTable.CopyRecs(aRecs : ISabCursor; aModifyProc : TdtRecAccessProc);

 function lFillBufferProc(aBuffer: Pointer; aBufSize: Longint): Longint;
 var
  lCount    : Integer;
  I         : Integer;
  lRecSize  : Integer;
  lResult   : Boolean;
  lReadSize : Cardinal;
  lBuffer   : Pointer;
 begin
  Result := aRecs.ReadBuffer(aBuffer, aBufSize);

  if Assigned(aModifyProc) then
   for I := 0 to Pred(lCount) do
   begin
    if not aModifyProc(lBuffer) then
     raise EHtErrors.CreateInt(ecUserRejectedOperation);
    Inc(PAnsiChar(lBuffer), lRecSize);
   end;
 end;

var
 lFillBufferProcStub : TFillBufferProc;

begin
 if StartTA(cMaxModTime) then
 try
  lFillBufferProcStub := L2FillBufferProc(@lFillBufferProc);
  try
   AddRecs(aRecs.Count, lFillBufferProcStub);
  finally
   FreeFillBufferProc(lFillBufferProcStub);
  end;
 SuccessTA;
 except
  RollBackTA;
  raise;
 end;
end;

procedure TdtTable.CopyRecs(aRecs : ISab; aModifyProc : TdtRecAccessProc);
begin
 CopyRecs(aRecs.HTSab, aModifyProc);
end;

procedure TdtTable.CopyRecs(aRecs : Sab; aModifyProc : TdtRecAccessProc);

 function lFillBufferProc(aBuffer: Pointer; aBufSize: Longint): Longint;
 var
  lCount    : Integer;
  I         : Integer;
  lRecSize  : Integer;
  lResult   : Boolean;
  lReadSize : Cardinal;
  lBuffer   : Pointer;
 begin
  Result := 0;
  lRecSize := RecSize;

  while Result < aBufSize do
  begin
   lBuffer := aBuffer;
   lReadSize := htReadResults(aRecs, aBuffer, aBufSize - Result);
   if lReadSize > ht_MaxBufLen then
    HT(Longint(lReadSize));
   Inc(Result, lReadSize);
   lCount := lReadSize div lRecSize; //посчитать сколько элеметов в буфере

   if Assigned(aModifyProc) then
    for I := 0 to Pred(lCount) do
    begin
     if not aModifyProc(lBuffer) then
      raise EHtErrors.CreateInt(ecUserRejectedOperation);
     Inc(PAnsiChar(lBuffer), lRecSize);
    end;
  end;
 end;

var
 lFillBufferProcStub : TFillBufferProc;

begin
 if StartTA(cMaxModTime) then
 try
  Ht(htOpenResults(aRecs, ROPEN_BODY {ROPEN_READ}, nil, 0));
  try
   lFillBufferProcStub := L2FillBufferProc(@lFillBufferProc);
   try
    AddRecs(aRecs.gFoundCnt, lFillBufferProcStub);
   finally
    FreeFillBufferProc(lFillBufferProcStub);
   end;
  finally
   htCloseResults(aRecs);
  end;
  SuccessTA;
 except
  RollBackTA;
  raise;
 end;
end;

procedure TdtTable.DelRec(aAbsNum  : Longint);
begin
 CheckIsOpen;
 Ht(htRecordDelete(Handle, aAbsNum));
end;

function TdtTable.DeleteRecByUniq(aUniqFld : ThtField; var aValue): Boolean;
var
 lAbsNum : Longint;
 lRecH   : RHandle;
begin
 lAbsNum := Ht(htRecordByUniq(nil, Handle, aUniqFld, @aValue, @lRecH));
 Result := lAbsNum <> 0;
 if Result then
  DelRec(lAbsNum);
end;

function TdtTable.DeleteRecsByKeys(aSabOfKeyValues : Sab; aKeyFld : ThtField): Integer;
var
 lDelRecs : ISab;
begin
 lDelRecs := MakeSab(Self, aSabOfKeyValues);
 Result := DeleteRecsByKeys(lDelRecs, aKeyFld);
end;

function TdtTable.DeleteRecsByKeys(const aSabOfKeyValues : ISab; aKeyFld : ThtField): Integer;
var
 lSab : ISab;
begin
 CheckIsOpen;

 if aSabOfKeyValues.IsEmpty then
  Result := 0
 else
 begin
  lSab := MakeSabCopy(aSabOfKeyValues);
  lSab.TransferToPhoto(aKeyFld, Self);
  lSab.RecordsByKey;
  Result := lSab.Count;
  lSab.DeleteFromTable;
 end;
end;

(*
procedure TdtTable.GetFieldFromRecord(const aRecHandle : RHandle; aField : Word; var aBody);
begin
 HT(htReadRecordByHandle(Handle, aRecHandle,{Запись с суррогатом});

end;
*)
procedure TdtTable.GetFieldFromRecord(aRecord : PAnsiChar; aField : ThtField; var aBody);
Var
 TmpSize,
 I        : Word;
begin
 if (aRecord = nil) then
  raise EHtErrors.CreateInt(ecNotAssigned);

 CheckFieldNum(aField);

 case PElemArr(fFields)^[aField].cType of
  ET_CHAR : begin
             I := PElemArr(fFields)^[aField].wOffset + PElemArr(fFields)^[aField].wLength;
             repeat
              if aRecord[I - 1] <> ' ' then Break;
              if I > PElemArr(fFields)^[aField].wOffset then Dec(I);
             until I = PElemArr(fFields)^[aField].wOffset;
             TmpSize := I - PElemArr(fFields)^[aField].wOffset;
             PAnsiChar(aBody) := l3StrAlloc(TmpSize+1);
             l3FillChar(PAnsiChar(aBody)^,TmpSize+1);
             l3Move(aRecord[PElemArr(fFields)^[aField].wOffset], PAnsiChar(aBody)^, TmpSize);
            end;
  ET_ARRA : begin
             l3System.GetLocalMem(Pointer(aBody),PElemArr(fFields)^[aField].wLength);
             l3Move(aRecord[PElemArr(fFields)^[aField].wOffset], Pointer(aBody)^, PElemArr(fFields)^[aField].wLength);
            end;
  ET_BYTE,
  ET_INTR,
  ET_WORD,
  ET_DATE,
  ET_NMBR,
  ET_LONG,
  ET_DWRD,
  ET_FLOA,
  ET_CURR,
  ET_DFLT : begin
             l3Move(aRecord[PElemArr(fFields)^[aField].wOffset], aBody, PElemArr(fFields)^[aField].wLength);
            end;
 end;
end;

function TdtTable.GetInTransaction: Boolean;
begin
 Result := not CompareMem(@f_TransID,
                          @c_EmptyTrId,
                          SizeOf(HT_Const.TRID));
end;

procedure TdtTable.ModifyRecs(aRecs : Sab; aField : ThtField; aValue : Pointer;
    aDupIgnore : Boolean = False);

 function lModifyRec(gRecNo : LongInt;fpRecord : Pointer) : MFUNC_RET;
 begin
  case ElementType[aField] of
   ET_CHAR,
   ET_ARRA : PutFieldToRecord(fpRecord, aField, aValue);

   ET_BYTE,
   ET_INTR,
   ET_WORD,
   ET_DATE,
   ET_NMBR,
   ET_LONG,
   ET_DWRD,
   ET_FLOA,
   ET_CURR,
   ET_DFLT : PutFieldToRecord(fpRecord, aField, aValue^);
  end;
  Result := MFUNC_SUCCESS;
 end;

var
 lHTStub    : Pointer;
begin
 lHTStub := HTStub3(@lModifyRec);
 try
  aDupIgnore := aDupIgnore and IsFieldInUniqKey(aField); // если поле не UK, то дубликатов быть не может
  ModifyRecs(aRecs, lHTStub, aDupIgnore);
 finally
  HTStubFree(lHTStub);
 end;
end;

procedure TdtTable.ModifyRecs(aRecs : Sab; aModifyProc : Pointer; aDupIgnore : Boolean = False; aNeedLock : boolean = True);
// TModifyMode
//     mmDupIgnore - "Delete/Insert" Надежная схема. Дубликаты уникального ключа будут удалены (если IgnoreDuplicates = True),
//     mmFast - "htModifyRecords" Быстрая схема. Может использоваться только если есть уверенность что модификация не приведет к дублированию ключей
//            (обычно модификация неключевых полей)

 function lRecModifyProc(aBuffer : Pointer) : Boolean;
 begin
  Result := MFUNC(aModifyProc)(0, aBuffer, nil) = MFUNC_SUCCESS;
 end;

var
 lRecs2 : Sab;
 lRecModifyProcStub : TdtRecAccessProc;

begin
 if aNeedLock then LockSab(aRecs);
 try
  if StartTA(cMaxModTime) then
   try
    if aDupIgnore then
    begin
     lRecs2 := dtMakeSabCopy(aRecs);
     HT(htDeleteRecords(lRecs2));
     //aRecs - на старом снимке! Можно почитать записи которые мы только что удалили

     lRecModifyProcStub := L2RecAccessProc(@lRecModifyProc);
     try
      CopyRecs(aRecs, lRecModifyProcStub);
     finally
      FreeRecAccessProc(lRecModifyProcStub);
     end;
    end
    else //if aDupIgnore
     Ht(htPureModifyRecords(aRecs, aModifyProc, nil));

    SuccessTA;
   except
    RollBackTA;
    raise;
   end;

 finally
  if aNeedLock then UnLockSab(aRecs);
 end;
end;

procedure TdtTable.ChangeValues(aField : ThtField; var aOldValue;  var aNewValue; aDupIgnore : Boolean = False);
var
 lSab : ISAB;
begin
 lSab := MakeSab(Self);
 lSab.Select(aField, aOldValue);
 lSab.ModifyRecs(aField, aNewValue, aDupIgnore);
end;

procedure TdtTable.DropTable;
var
 hTable : HT_Const.THANDLE;
 l_Ok : Longint;
begin
 CloseTbl;
 l_Ok:=htTableHandleByName(@TblFullName[1],hTable);
 if l_Ok < 0 then
  Ht(htDropTable(@TblFullName[1],@TblPass[1],@TblPass[1]));
end;

procedure TdtTable.PutFieldToRecord(aRecord : PAnsiChar; aField : ThtField; const aBody);
var
 lByte : Byte;
 lStrLen : Integer;
begin
 if (aRecord = nil) then
  raise EHtErrors.CreateInt(ecNotAssigned);

 CheckFieldNum(aField);

 case PElemArr(fFields)^[aField].cType of
  ET_CHAR :
   begin
    with PElemArr(fFields)^[aField] do
    begin
     lStrLen := Min(l3StrLen(PAnsiChar(aBody)), wLength);
     if lStrLen > 0 then
      l3Move(PAnsiChar(aBody)^, aRecord[wOffset], lStrLen);
     if wLength > lStrLen then
      l3FillChar(aRecord[wOffset + lStrLen], wLength - lStrLen, 32);
    end;
   end;
  ET_ARRA :
   begin
    with PElemArr(fFields)^[aField] do
     if Pointer(aBody) <> nil then
      l3Move(Pointer(aBody)^, aRecord[wOffset], wLength)
     else
      l3FillChar(aRecord[wOffset], wLength);
   end;
  ET_BYTE :
   begin
    lByte := Byte(aBody);
    if lByte = 255 then lByte := 1;

    with PElemArr(fFields)^[aField] do
     l3Move(lByte, aRecord[wOffset], wLength);
   end;
  ET_INTR,
  ET_WORD,
  ET_DATE,
  ET_NMBR,
  ET_LONG,
  ET_DWRD,
  ET_FLOA,
  ET_CURR,
  ET_DFLT :
   begin
    with PElemArr(fFields)^[aField] do
    l3Move(aBody, aRecord[wOffset], wLength);
   end;
 end;
end;

function TdtTable.GetRecordIDByUniq(aField : ThtField; const aKeyValue; aRecHandle : pRHandle = nil; aPhoto: LPSAB = nil): Longint;
begin
 Result := Ht(htRecordByUniq(aPhoto, Handle, aField, @aKeyValue, aRecHandle));
end;

function  TdtTable.GetRecordByUniq(const aKeyValue) : TdtRecord;
begin
 Result := InitRecord(Self);
 Result.FindByUniq(UniqKeyElemNum, aKeyValue);
end;

function TdtTable.HasRecord(aField: ThtField; const aFieldValue): Boolean;
begin
 CheckIsOpen;
 CheckElementNum(aField);

 if (ElementKeyKind[aField] <> EK_UNIQUE) then
  raise EHtErrors.CreateInt(ecNotKeyField);

 Result := GetRecordIDByUniq(aField, aFieldValue) > 0;
end;

function TdtTable.HasUniqRec(var aFieldValue): Boolean;
begin
 CheckIsOpen;
 Result := GetRecordIDByUniq(UniqKeyElemNum, aFieldValue) > 0;
end;

procedure TdtTable.OpenTbl;
var
 hTable : HT_Const.THANDLE;
 l_Ok   : Longint;
begin
 if not IsTableOpened then
 begin
  l_Ok := htTableHandleByName(@TblFullName[1],hTable);
  try
   if l_Ok < 0 then
    Ht(htTableOpen(@TblFullName[1],@TblPass[1],@TblPass[1], TblShareFlag, fTblH))
   else
    Ht(htDupTableHandle(hTable, fTblH));
   IsTableOpened := True;
   fIsTemporalClose := 0;
  except
   IsTableOpened := False;
   raise;
  end;
 end;
end;

function TdtTable.RecordAsString(aRecord: PAnsiChar): AnsiString;

const
 c_FieldDelim = ', ';
var
 I: Integer;
begin
 CheckTblInfo;

 Result := '';
 for I := 1 to fldCount do
  if Result = '' then
   Result := ValueAsString(I, aRecord + FldOffset[I])
  else
   Result := Result + c_FieldDelim + ValueAsString(I, aRecord + FldOffset[I]);
end;

function TdtTable.PhotoOfTable : Sab;
begin
 htMakePhoto(Result, Handle);
end;

function TdtTable.TblHold(var Res : LongInt) : Boolean;
var
 I  : Byte;
begin
 Result := False;
 for I := 1 to 10 do
  begin
   Res := htHoldTable(Handle);
   if Res=ecOk then
   begin
    Result := True;
    Break;
   end
   else
    Sleep(500);
  end;

 if not Result then
  fTblLckCount := 0;
end;

function TdtTable.IsTblHeld: Boolean;
begin
 Result := fTblLckCount > 0;
end;

procedure TdtTable.LockTbl;
var
 l_Ok : Longint;
begin
 CheckIsOpen;
 if fTblLckCount = 0 then
 begin
  if TblHold(l_Ok) then
  begin
   fTblLckCount := 1;
   exit;
  end;
  raise EHtErrors_LockTblError.Create(SysUtils.Format('Не удалось захватить таблицу %s.', [TblName]));
 end
 else
  Inc(fTblLckCount);
end;

procedure TdtTable.UnlockTbl;
begin
 CheckIsOpen;
 if fTblLckCount > 0 then
  Dec(fTblLckCount)
 else
  raise EHtErrors.CreateInt(ecNotEnable);

 if fTblLckCount = 0 then
  Ht(htReleaseTable(Handle));
end;

procedure TdtTable.LockSab(var aSab : Sab);
var
 I : integer;
 lRes : Longint;
 lOwner : ThtLockOwner;
 lWLRes : Longint;

begin
 if IsTblHeld then Exit;
 for I := 1 to 10 do
  begin
   lRes := htHoldResults(aSab);
   if lRes = ecOk then
    Break
   else
    Sleep(500);
  end;
 if lRes = HT_ERR_RECORD_LOCKED then
 begin
  lWLRes := htWhoLockSet(aSab, lOwner);
  if lWLRes = ecOk then
   l3System.Msg2Log('Record locked by "%s"', [l3ArrayToString(lOwner.szUser, SizeOf(lOwner.szUser))]);
 end;
 Ht(lRes);
end;

procedure TdtTable.UnlockSab(var aSab : Sab);
begin
 if not IsTblHeld then
  htReleaseResults(aSab);
end;

procedure TdtTable.ExportToFile(const aFileName : AnsiString; aQuote : Char = '"'; aDelimiter : Char = #9);
var
 lRecs : ISab;
begin
 lRecs := MakeAllRecords(Self);
 OutRecSabToFile(lRecs, aFileName, aQuote, aDelimiter);
end;

function MakeITbl(aPath : TPathStr; aPass : TPassStr; aName : TTblNameStr; aShare : SmallInt) : ITblInfo;
var
 lTable : TdtTable;
begin
 lTable := TdtTable.Create(aPath, aPass, aName, aShare);
 try
  Result := lTable;
 finally
  l3Free(lTable);
 end;
end;

function MakeITblWithOpen(aPath : TPathStr; aPass : TPassStr; aName : TTblNameStr; aShare : SmallInt) : ITblInfo;
var
 lTable : TdtTable;
begin
 lTable := TdtTable.CreateWithOpen(aPath, aPass, aName, aShare);
 try
  Result := lTable;
 finally
  l3Free(lTable);
 end;
end;

procedure SignalStartTransaction;
begin
 l3InterlockedIncrement(g_TransactionCounter);
 if g_TransactionCounter > 1 then
  l3System.Stack2Log('WARNING - inner transaction detected');
end;

procedure SignalEndTransaction;
begin
 l3InterlockedDecrement(g_TransactionCounter);
end;

end.
