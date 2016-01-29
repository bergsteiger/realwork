unit AI_Query;

{ $Id: AI_Query.pas,v 1.2 2015/07/02 11:40:58 lukyanets Exp $ }
// $Log: AI_Query.pas,v $
// Revision 1.2  2015/07/02 11:40:58  lukyanets
// ќписываем словари
//
// Revision 1.1  2010/08/03 13:21:37  voba
// - k: 229672814
//
// Revision 1.18  2009/05/08 11:10:07  voba
// - заменил TblH на Handle
//
// Revision 1.17  2008/02/01 17:00:28  lulin
// - используем кошерные потоки.
//
// Revision 1.16  2007/08/14 19:31:56  lulin
// - оптимизируем очистку пам€ти.
//
// Revision 1.15  2007/08/14 14:30:08  lulin
// - оптимизируем перемещение блоков пам€ти.
//
// Revision 1.14  2007/03/06 14:51:46  fireton
// - избавление от ненужных ссылок на fSrchList
//
// Revision 1.13  2007/02/16 16:16:15  voba
// - rename type Condition ->ThtCondition
//
// Revision 1.12  2005/11/03 12:11:34  step
// слил с веткой
//
// Revision 1.11.44.1  2005/11/03 09:31:15  step
// new: property TRecordQuery.FoundRec
//
// Revision 1.11  2004/09/21 12:04:20  lulin
// - Release заменил на Cleanup.
//
// Revision 1.10  2004/09/14 15:58:15  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.9  2004/08/25 09:17:34  step
// bug fix
//
// Revision 1.8  2004/08/03 08:52:51  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.7  2004/07/13 08:02:34  step
// сли€ние с веткой b_import_filter_optimization2
//
// Revision 1.6.4.1  2004/07/09 15:07:45  step
// исправлена TSelectionQuery.GetEof
//
// Revision 1.6  2004/07/01 14:14:27  voba
// - merge newCashe
//
// Revision 1.5.2.1  2004/06/28 14:46:30  step
// убрано то, что "через неделю стереть"
//
// Revision 1.5  2004/06/10 16:53:03  step
// изменена TRecordQuery.Search
//
// Revision 1.4  2004/06/10 11:40:02  step
// изменена иерархи€ TQuery, добавлен TRecordQuery
//
// Revision 1.3  2004/06/09 12:47:05  step
// добавлены методы доступа к значени€м полей
//
// Revision 1.2  2004/06/09 09:41:00  step
// добавлены проверки и обработка ошибок
//
// Revision 1.1  2004/06/08 17:29:47  step
// добавлен новый модуль
//

{$I DtDefine.inc}

interface

uses
  Classes, Contnrs,
  l3Base,
  Dt_ATbl,
  Ht_Dll, Ht_Const,
  l3Memory
  ;

const
 c_MaxFieldAmount = 32;

type
 TFieldNums = array of Smallint;

 TFilterType = (ftOneFieldCondition, ftSetOfValues);

 TQueryFilter = class(Tl3Base)
 public
  procedure ApplyTo(var aRecords: Sab); virtual; abstract;
 end;

 TFilterByOneValue = class(TQueryFilter)
 private
  f_DataLen: Integer;
  f_FieldNum: Smallint;
  f_Condition: ThtCondition;
  f_Data: array of Byte;
 protected
  procedure Cleanup; override;
 public
  constructor Create(aTable: TAbsHtTbl;
                     aFieldNum: Smallint;
                     aCondition: ThtCondition;
                     const aData); reintroduce;
  procedure ApplyTo(var aRecords: Sab); override;
 end;

 (*TFilterByTwoValues = class(TQueryFilter)
 private
  f_DataLen: Integer;
  f_FieldNum: Smallint;
  f_Condition: ThtCondition;
  f_LowData,
  f_HiData: array of Byte;
 protected
  procedure Cleanup; override;
 public
  constructor Create(aTable: TAbsHtTbl;
                     aFieldNum: Smallint;
                     aCondition: ThtCondition;
                     const aLowData, aHiData); reintroduce;
  procedure ApplyTo(var aRecords: Sab); override;
 end;
*)
(* TFilterBySetOfValues = class(TQueryFilter)
 private
  f_FieldNum: Smallint;
  f_ValuesSab: Sab;
 protected
  procedure Cleanup; override;
 public
  constructor Create(aTable: TAbsHtTbl;
                     aFieldNum: Smallint;
                     aValuesSet: TStream); reintroduce;
  procedure ApplyTo(var aRecords: Sab); override;
 end;
*)
 // абстракный класс - предок всех T___Query
 TAbstrQuery = class(Tl3Base)
 end;


 TReadQuery = class(TAbstrQuery)
 private
  function  GetFieldAsByte(aFieldNum: Smallint): Byte;
  function  GetFieldAsWord(aFieldNum: Smallint): Word;
  function  GetFieldAsLongWord(aFieldNum: Smallint): LongWord;
  function  GetFieldAsSmallint(aFieldNum: Smallint): Smallint;
  function  GetFieldAsInteger(aFieldNum: Smallint): Integer;
  function  GetFieldAsString(aFieldNum: Smallint): string;
 protected
  f_Table: TAbsHtTbl;

  procedure Read(aFieldNum: Smallint; out aFieldValue); virtual; abstract;
  function  ReadAsString(aFieldNum: Smallint): string; virtual; abstract;
 public
  constructor Create(aTable: TAbsHtTbl); reintroduce;

  procedure ReadGroup(aFieldNum: Smallint; out aGroup);

  property  FieldAsByte[aFieldNum: Smallint]: Byte read GetFieldAsByte;
  property  FieldAsWord[aFieldNum: Smallint]: Word read GetFieldAsWord;
  property  FieldAsLongWord[aFieldNum: Smallint]: LongWord read GetFieldAsLongWord;
  property  FieldAsSmallint[aFieldNum: Smallint]: Smallint read GetFieldAsSmallint;
  property  FieldAsInteger[aFieldNum: Smallint]: Integer read GetFieldAsInteger;
  property  FieldAsString[aFieldNum: Smallint]: string read GetFieldAsString;
 end;



// ѕример использовани€ TSelectionQuery:
//   l_Query := TSelectionQuery.Create(DictServer.DictTbl[da_dlWarnings]);
//   with l_Query do
//   try
//    AddFilter(1, l_Stream);
//    AddFilter(1, IN_RANGE, c_ID1, c_ID2);
//    SortedBy([2]);
//    Open([1, 2]);
//    while not Eof do
//    begin
//     l_StringList.AddItem(FieldAsString[2]);
//     l_Query.Next;
//    end;
//    Close;
//   finally
//    FreeAndNil(l_Query);
//   end;

 TSelectionQuery = class(TReadQuery)
 private
  f_Filters: TObjectList;
  f_SortFields: array of Smallint;
  f_BuiltSab: Sab;
  f_RecLen: Integer;
  f_RecsBuffer: Tl3MemoryStream;
  f_BytesInRecBuf: Integer;
  f_FieldOffsetsInRecord: array[0..c_MaxFieldAmount] of Word;

  f_IsOpen: Boolean;

  function  GetEof: Boolean;
  function  GetRecordCount: Integer;
  procedure BuildSab;
  procedure CalcRecordParams(const aFieldNums: array of Smallint);
  procedure ReadRecsToBuf;
  procedure CheckFieldNums(const aFieldNums: array of Smallint); // выбрасывает исключение
  procedure CheckIsOpen; // выбрасывает исключение
  procedure CheckIsClosed; // выбрасывает исключение
  procedure CheckNotEof; // выбрасывает исключение
 protected
  procedure Cleanup; override;
  procedure Read(aFieldNum: Smallint; out aFieldValue); override;
  function  ReadAsString(aFieldNum: Smallint): string; override;
 public
  constructor Create(aTable: TAbsHtTbl);
  procedure ClearFilters;
  procedure AddFilter(aFieldNum: Smallint;
                      aCondition: ThtCondition;
                      const aValue); overload;
  //procedure AddFilter(aFieldNum: Smallint;
  //                    aCondition: ThtCondition;
  //                    const aLowValue, aHiValue); overload;
  //procedure AddFilter(aFieldNum: Smallint;
  //                    aValues: TStream); overload;
  procedure ClearSortOrder;
  procedure SortedBy(const aFieldNums: array of Smallint);
  procedure Open(const aFieldNums: array of Smallint; aDistinct: Boolean = False);
  procedure ReadRec(out aRec);
  procedure Next;
  procedure Close;
  property  RecordCount: Integer read GetRecordCount;
  property  Eof: Boolean read GetEof;
 end;

(* TRecordQuery = class(TReadQuery)
 private
  f_IsEmpty: Boolean;
  f_Record: Pointer;
  procedure CheckIsUniqKeyField(aFieldNum: Smallint); // выбрасывает исключение
  procedure CheckIsNotEmpty; // выбрасывает исключение
 protected
  procedure Cleanup; override;
  procedure Read(aFieldNum: Smallint; out aFieldValue); override;
  function  ReadAsString(aFieldNum: Smallint): string; override;
 public
  constructor Create(aTable: TAbsHtTbl);
  function  Search(aUniqKeyFieldNum: Smallint;
                   const aValue): Boolean;
  function  IsEmpty: Boolean;
  property  FoundRec: Pointer read f_Record;
 end;
*)

implementation

uses
  SysUtils,
  Math,

  l3String,
  
  Dt_Const,
  Dt_Err
  ;

{ TSelectionQuery }

procedure TSelectionQuery.AddFilter(aFieldNum: Smallint;
                                    aCondition: ThtCondition;
                                    const aValue);
begin
 CheckIsClosed;
 f_Filters.Add(TFilterByOneValue.Create(f_Table,
                                        aFieldNum,
                                        aCondition,
                                        aValue));
end;

(*procedure TSelectionQuery.AddFilter(aFieldNum: Smallint;
                                    aValues: TStream);
begin
 CheckIsClosed;
 f_Filters.Add(TFilterBySetOfValues.Create(f_Table,
                                           aFieldNum,
                                           aValues));
end;

procedure TSelectionQuery.AddFilter(aFieldNum: Smallint;
                                    aCondition: ThtCondition;
                                    const aLowValue, aHiValue);
begin
 CheckIsClosed;
 f_Filters.Add(TFilterByTwoValues.Create(f_Table,
                                         aFieldNum,
                                         aCondition,
                                         aLowValue, aHiValue));
end;
*)
procedure TSelectionQuery.BuildSab;
var
 I: Integer;
 l_UnsortedSab: Sab;
begin
 // полный список
 f_Table.RefreshSrchList;
 htCopyResults(f_BuiltSab, f_Table.fSrchList);
 try
  // фильтраци€
  if f_Filters.Count > 0 then
   for I := 0 to f_Filters.Count - 1 do
    TQueryFilter(f_Filters[I]).ApplyTo(f_BuiltSab);

  // сортировка
  if Length(f_SortFields) > 0 then
  begin
   l_UnsortedSab := f_BuiltSab;
   Ht(htSortResults(f_BuiltSab, l_UnsortedSab, @f_SortFields[0], Length(f_SortFields)));
   htClearResults(l_UnsortedSab);
  end;
 except
  htClearResults(f_BuiltSab);
  raise;
 end;
end;

procedure TSelectionQuery.CalcRecordParams(const aFieldNums: array of Smallint);
var
 I: Integer;
 l_CumulativeOffset: Word;
begin
 l3FillChar(f_FieldOffsetsInRecord, SizeOf(f_FieldOffsetsInRecord), 0);
 l_CumulativeOffset := 0;
 for I := 0 to Length(aFieldNums) - 1 do
 begin
  f_FieldOffsetsInRecord[aFieldNums[I]] := l_CumulativeOffset;
  Inc(l_CumulativeOffset, f_Table.fldLength[aFieldNums[I]]);
 end;
end;

procedure TSelectionQuery.CheckFieldNums(const aFieldNums: array of Smallint);
var
 I: Integer;
 l_TableElementsCount: Smallint;
begin
 l_TableElementsCount := f_Table.ElementsCount;
 for I := 0 to Length(aFieldNums) - 1 do
  if (aFieldNums[I] < 1) or (aFieldNums[I] > l_TableElementsCount) then
   raise Exception.Create('Ќеверный номер элемента таблицы');
end;

procedure TSelectionQuery.CheckIsClosed;
begin
 if f_IsOpen then
  raise Exception.Create('ѕопытка выполнени€ действи€, недопустимого при открытом запросе.');
end;

procedure TSelectionQuery.CheckIsOpen;
begin
 if not f_IsOpen then
  raise Exception.Create('ѕопытка выполнени€ действи€, недопустимого при закрытом запросе.');
end;

procedure TSelectionQuery.CheckNotEof;
begin
 if Eof then
  raise Exception.Create('«аписей больше нет.');
end;

procedure TSelectionQuery.ClearFilters;
begin
 CheckIsClosed;
 if f_Filters <> nil then
  f_Filters.Clear;
end;

procedure TSelectionQuery.ClearSortOrder;
begin
 CheckIsClosed;
 f_SortFields := nil;
end;

procedure TSelectionQuery.Close;
begin
 if not f_IsOpen then
  Exit;

 htCloseResults(f_BuiltSab);
 htClearResults(f_BuiltSab);
 f_RecsBuffer.Size := 0;
 f_IsOpen := False;
end;

constructor TSelectionQuery.Create(aTable: TAbsHtTbl);
begin
 inherited;

 f_Filters := TObjectList.Create(True);
 f_RecsBuffer := Tl3MemoryStream.Make;
end;

function TSelectionQuery.GetEof: Boolean;
begin
 CheckIsOpen;
 Result := f_RecsBuffer.Position >= f_BytesInRecBuf;
end;

function TSelectionQuery.GetRecordCount: Integer;
begin
 CheckIsOpen;
 Result := f_BuiltSab.gFoundCnt;
end;

procedure TSelectionQuery.Next;
begin
 CheckIsOpen;
 if f_RecsBuffer.Position + 2 * f_RecLen > f_BytesInRecBuf then
  ReadRecsToBuf
 else
  f_RecsBuffer.Seek(f_RecLen, soFromCurrent);
end;

procedure TSelectionQuery.Open(const aFieldNums: array of Smallint;
                               aDistinct: Boolean = False);
var
 l_RecLen: Cardinal;
 l_UniqueRecs: Sab;
begin
 CheckIsClosed;
 CheckFieldNums(aFieldNums);
 CalcRecordParams(aFieldNums);

 BuildSab;
 try
  // уникализаци€ по заданным пол€м
  if aDistinct then
  begin
   Ht(htDistinctResults(l_UniqueRecs, f_BuiltSab, @aFieldNums[0], Length(aFieldNums)));
   htClearResults(f_BuiltSab);
   f_BuiltSab := l_UniqueRecs;
  end;

  Ht(htOpenResults(f_BuiltSab, ROPEN_READ, @aFieldNums[0], Length(aFieldNums)));
 except
  htClearResults(f_BuiltSab);
  raise;
 end;

 Ht(htResultsItemLen(f_BuiltSab, l_RecLen));
 f_RecLen := l_RecLen;

 f_IsOpen := True;

 Next; // курсор на первую запись
end;

procedure TSelectionQuery.Read(aFieldNum: Smallint; out aFieldValue);
begin
 CheckIsOpen;
 CheckNotEof;

 l3Move((f_RecsBuffer.MemoryPool.AsPointer + f_RecsBuffer.Position + f_FieldOffsetsInRecord[aFieldNum])^,
      aFieldValue,
      f_Table.fldLength[aFieldNum]);
end;

function TSelectionQuery.ReadAsString(aFieldNum: Smallint): string;
begin
 CheckIsOpen;
 CheckNotEof;

 Result := l3ArrayToString((f_RecsBuffer.MemoryPool.AsPointer
                           + f_RecsBuffer.Position
                           + f_FieldOffsetsInRecord[aFieldNum])^,
                         f_Table.fldLength[aFieldNum]);
end;

procedure TSelectionQuery.ReadRec(out aRec);
begin
 CheckIsOpen;
 CheckNotEof;

 l3Move((f_RecsBuffer.MemoryPool.AsPointer + f_RecsBuffer.Position)^, aRec, f_RecLen);
end;

procedure TSelectionQuery.ReadRecsToBuf;
begin
 if f_RecsBuffer.Size = 0 then
 begin
  f_RecsBuffer.Size := (Min(f_BuiltSab.gFoundCnt * f_RecLen, HT_Const.MAX_BUF_LEN));
 end;

 f_BytesInRecBuf := htReadResults(f_BuiltSab,
                                  f_RecsBuffer.MemoryPool.AsPointer,
                                  f_RecsBuffer.Size);
 if f_BytesInRecBuf > MAX_BUF_LEN then
  raise EHtErrors.CreateInt(ecCanNotRead);

 f_RecsBuffer.Position := 0;
end;

procedure TSelectionQuery.Cleanup;
begin
 if f_IsOpen then
  Close;

 FreeAndNil(f_Filters);
 FreeAndNil(f_RecsBuffer);
 f_SortFields := nil;
 
 inherited;
end;

(*procedure TFilterBySetOfValues.ApplyTo(var aRecords: Sab);
var
 l_CopyOfRecords: Sab;
 l_FilterRecs: Sab;
begin
 htTransferToPhoto(f_ValuesSab, aRecords, f_FieldNum);
 htRecordsByKey(l_FilterRecs, f_ValuesSab);
 try
  l_CopyOfRecords := aRecords;
  htAndResults(aRecords, l_CopyOfRecords, l_FilterRecs);
  htClearResults(l_CopyOfRecords);
 finally
  htClearResults(l_FilterRecs);
 end;
end;

constructor TFilterBySetOfValues.Create(aTable: TAbsHtTbl;
                                        aFieldNum: Smallint;
                                        aValuesSet: TStream);
const
 c_MaxBufLen = MAX_BUF_LEN;
var
 l_FieldLen: Integer;
 l_BufSize: Integer;
 l_Buf: Pointer;
 l_BytesInBuf: Cardinal;
 l_ValuesSab: Sab;
 l_IncludePos: Integer;
begin
 f_FieldNum := aFieldNum;
 htCreateEmptySAB(nil, l_ValuesSab, aTable.Handle, aFieldNum, RES_VALUE);
 try
  // наполнение
  l_FieldLen := aTable.fldLength[aFieldNum];
  l_BufSize := Min(aValuesSet.Size, (c_MaxBufLen div l_FieldLen) * l_FieldLen);
  l3System.GetLocalMem(l_Buf, l_BufSize);
  try
   Ht(htOpenResults(l_ValuesSab, ROPEN_READ, nil, 0));
   try
    aValuesSet.Position := 0;
    while aValuesSet.Position < aValuesSet.Size do
    begin
     l_IncludePos := aValuesSet.Position div l_FieldLen;
     l_BytesInBuf := aValuesSet.Read(l_Buf^, l_BufSize);
     Ht(htIncludeResultsBlock(l_ValuesSab,
                              l_IncludePos,
                              l_Buf,
                              l_BytesInBuf));
    end; // while
   finally
    htCloseResults(l_ValuesSab);
   end;
  finally
   l3System.FreeLocalMem(l_Buf);
  end;
  // сортировка
  Ht(htSortResults(f_ValuesSab, l_ValuesSab, @aFieldNum, 1));
 finally
  htClearResults(l_ValuesSab);
 end;
end;

procedure TFilterBySetOfValues.Cleanup;
begin
 htClearResults(f_ValuesSab);

 inherited;
end;
*)

procedure TSelectionQuery.SortedBy(const aFieldNums: array of Smallint);
var
 l_FieldNums: array of Smallint;
 I: Integer;
begin
 CheckIsClosed;

 // дл€ проверки правильности номеров полей надо отбросить минусы
 SetLength(l_FieldNums, Length(aFieldNums));
 for I := 0 to Length(l_FieldNums) - 1 do
  l_FieldNums[I] := Abs(aFieldNums[I]);
 CheckFieldNums(l_FieldNums);
 l_FieldNums := nil;

 SetLength(f_SortFields, Length(aFieldNums));
 l3Move(aFieldNums[0], f_SortFields[0], Length(aFieldNums) * SizeOf(Smallint));
end;

{ TFilterByOneValue }

procedure TFilterByOneValue.ApplyTo(var aRecords: Sab);
var
 l_PrevSab: Sab;
 l_TableHandle: Ht_Const.THANDLE;
begin
 Ht(htResultsTable(aRecords, l_TableHandle));
 l_PrevSab := aRecords;
 htSubSearch(l_PrevSab,
             aRecords,
             l_TableHandle,
             f_FieldNum,
             f_Condition,
             @f_Data[0],
             nil);
 htClearResults(l_PrevSab);
end;

constructor TFilterByOneValue.Create(aTable: TAbsHtTbl;
                                     aFieldNum: Smallint;
                                     aCondition: ThtCondition;
                                     const aData);
begin
 if not (aCondition in [EQUAL,
                        GREAT,
                        GREAT_EQUAL,
                        LESS,
                        LESS_EQUAL,
                        NOT_EQUAL,
                        NOT_GREAT,
                        NOT_LESS,
                        WILDCARD,
                        WILDCASE])
 then
  raise Exception.Create('Ќеверное условие фильтрации.');


 f_FieldNum := aFieldNum;
 f_DataLen := aTable.fldLength[aFieldNum];
 f_Condition := aCondition;
 SetLength(f_Data, f_DataLen);
 l3Move(aData, f_Data[0], f_DataLen);
end;

procedure TFilterByOneValue.Cleanup;
begin
 f_Data := nil;

 inherited;
end;

{ TFilterByTwoValues }
(*
procedure TFilterByTwoValues.ApplyTo(var aRecords: Sab);
var
 l_PrevSab: Sab;
 l_TableHandle: Ht_Const.THANDLE;
begin
 Ht(htResultsTable(aRecords, l_TableHandle));
 l_PrevSab := aRecords;
 htSubSearch(l_PrevSab,
             aRecords,
             l_TableHandle,
             f_FieldNum,
             f_Condition,
             @f_LowData[0],
             @f_HiData[0]);
 htClearResults(l_PrevSab);
end;

constructor TFilterByTwoValues.Create(aTable: TAbsHtTbl;
                                      aFieldNum: Smallint;
                                      aCondition: ThtCondition;
                                      const aLowData, aHiData);
begin
 if not (aCondition in [BETWEEN,
                        IN_RANGE,
                        NOT_BETWEEN,
                        NOT_IN_RANGE])
 then
  raise Exception.Create('Ќеверное условие фильтрации.');

 f_FieldNum := aFieldNum;
 f_DataLen := aTable.fldLength[aFieldNum];
 f_Condition := aCondition;
 SetLength(f_LowData, f_DataLen);
 l3Move(aLowData, f_LowData[0], f_DataLen);
 SetLength(f_HiData, f_DataLen);
 l3Move(aHiData, f_HiData[0], f_DataLen);
end;

procedure TFilterByTwoValues.Cleanup;
begin
 f_LowData := nil;
 f_HiData := nil;

 inherited;
end;
*)
{ TReadQuery }

constructor TReadQuery.Create(aTable: TAbsHtTbl);
begin
 f_Table := aTable;
end;

function TReadQuery.GetFieldAsByte(aFieldNum: Smallint): Byte;
begin
 if (f_Table.ElementClass[aFieldNum] = EC_FIELD) then
 begin
  if f_Table.ElementType[aFieldNum] = ET_BYTE then
   Read(aFieldNum, Result)
  else
   raise Exception.Create('“ип пол€ отличен от типа Byte.');
 end
 else
  raise Exception.Create('Ќеверный номер пол€.');
end;

function TReadQuery.GetFieldAsInteger(aFieldNum: Smallint): Integer;
begin
 if (f_Table.ElementClass[aFieldNum] = EC_FIELD) then
  case f_Table.ElementType[aFieldNum] of
   ET_INTR: Result := FieldAsSmallint[aFieldNum];
   ET_LONG: Read(aFieldNum, Result);
  else
   raise Exception.Create('“ип пол€ отличен от типа Integer.');
  end
 else
  raise Exception.Create('Ќеверный номер пол€.');
end;

function TReadQuery.GetFieldAsLongWord(aFieldNum: Smallint): LongWord;
begin
 if (f_Table.ElementClass[aFieldNum] = EC_FIELD) then
  case f_Table.ElementType[aFieldNum] of
   ET_BYTE: Result := FieldAsByte[aFieldNum];
   ET_WORD: Result := FieldAsWord[aFieldNum];
   ET_DWRD: Read(aFieldNum, Result);
  else
   raise Exception.Create('“ип пол€ отличен от типа LongWord.');
  end
 else
  raise Exception.Create('Ќеверный номер пол€.');
end;

function TReadQuery.GetFieldAsSmallint(aFieldNum: Smallint): Smallint;
begin
 if (f_Table.ElementClass[aFieldNum] = EC_FIELD) then
 begin
  if f_Table.ElementType[aFieldNum] = ET_INTR then
   Read(aFieldNum, Result)
  else
   raise Exception.Create('“ип пол€ отличен от типа Smallint.');
 end
 else
  raise Exception.Create('Ќеверный номер пол€.');
end;

function TReadQuery.GetFieldAsString(aFieldNum: Smallint): string;
begin
 if (f_Table.ElementClass[aFieldNum] = EC_FIELD) then
 begin
  if f_Table.ElementType[aFieldNum] = ET_CHAR then
   Result := ReadAsString(aFieldNum)
  else
   raise Exception.Create('“ип пол€ отличен от типа string.');
 end
 else
  raise Exception.Create('Ќеверный номер пол€.');
end;

function TReadQuery.GetFieldAsWord(aFieldNum: Smallint): Word;
begin
 if (f_Table.ElementClass[aFieldNum] = EC_FIELD) then
  case f_Table.ElementType[aFieldNum] of
   ET_BYTE: Result := FieldAsByte[aFieldNum];
   ET_WORD: Read(aFieldNum, Result);
  else
   raise Exception.Create('“ип пол€ отличен от типа Word.');
  end
 else
  raise Exception.Create('Ќеверный номер пол€.');
end;

procedure TReadQuery.ReadGroup(aFieldNum: Smallint; out aGroup);
begin
 if (f_Table.ElementClass[aFieldNum] = EC_GROUP) then
  Read(aFieldNum, aGroup)
 else
  raise Exception.Create('Ќеверный номер пол€.');
end;

{ TRecordQuery }
(*
procedure TRecordQuery.CheckIsNotEmpty;
begin
 if f_IsEmpty then
  raise Exception.Create('–езультаты поиска пусты.');
end;

procedure TRecordQuery.CheckIsUniqKeyField(aFieldNum: Smallint);
begin
 if f_Table.ElementKeyKind[aFieldNum] <> EK_UNIQUE then
  raise Exception.Create('ѕопытка выполнени€ поиска по неуникальному полю.');
end;

constructor TRecordQuery.Create(aTable: TAbsHtTbl);
begin
 inherited;
 
 l3System.GetLocalMem(f_Record, f_Table.RecSize);
end;

function TRecordQuery.IsEmpty: Boolean;
begin
 Result := f_IsEmpty;
end;

procedure TRecordQuery.Read(aFieldNum: Smallint; out aFieldValue);
begin
 CheckIsNotEmpty;

 l3Move((PChar(f_Record) + f_Table.fldOffset[aFieldNum])^,
      aFieldValue,
      f_Table.fldLength[aFieldNum]);
end;

function TRecordQuery.ReadAsString(aFieldNum: Smallint): string;
begin
 CheckIsNotEmpty;

 Result := l3ArrayToString((PChar(f_Record) + f_Table.fldOffset[aFieldNum])^,
                         f_Table.fldLength[aFieldNum]);
end;

procedure TRecordQuery.Cleanup;
begin
 l3System.FreeLocalMem(f_Record);
 inherited;
end;

function TRecordQuery.Search(aUniqKeyFieldNum: Smallint; const aValue): Boolean;
var
 l_RecNo: LongInt;
begin
 CheckIsUniqKeyField(aUniqKeyFieldNum);
 l_RecNo := Ht(htRecordByUniq(nil,
                              f_Table.Handle,
                              aUniqKeyFieldNum,
                              @aValue,
                              nil));
 Result := l_RecNo > 0;
 if Result then
  Ht(htReadRecord(nil,
                  f_Table.Handle,
                  l_RecNo,
                  f_Record));

 f_IsEmpty := not Result;
end;
*)
end.

