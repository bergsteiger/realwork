Unit dt_Record;

{ $Id: dt_Record.pas,v 1.22 2015/03/19 10:32:14 fireton Exp $ }

// $Log: dt_Record.pas,v $
// Revision 1.22  2015/03/19 10:32:14  fireton
// - доработки
//
// Revision 1.21  2015/03/13 11:55:46  voba
// - локальное автосохранение документов
//
// Revision 1.20  2015/03/04 15:26:33  voba
// - add function GetIntField
//
// Revision 1.19  2015/03/03 12:30:05  voba
// - «амена htReadRecord на htReadRecordByHandle bugfix
//
// Revision 1.18  2015/03/03 12:27:26  voba
// - «амена htReadRecord на htReadRecordByHandle bugfix
//
// Revision 1.17  2015/03/03 12:03:56  voba
// - «амена htReadRecord на htReadRecordByHandle bugfix
//
// Revision 1.16  2015/03/02 18:34:37  voba
// - «амена htReadRecord на htReadRecordByHandle bugfix
//
// Revision 1.15  2015/03/02 16:31:52  voba
// - «амена htReadRecord на htReadRecordByHandle
//
// Revision 1.14  2014/04/30 13:11:31  lulin
// - выпр€мл€ем зависимости.
//
// Revision 1.13  2014/04/30 11:24:04  lulin
// - выпр€мл€ем зависимости.
//
// Revision 1.12  2014/04/22 13:20:25  voba
// - поддержка Tk2Tag
//
// Revision 1.11  2014/03/06 17:23:23  lulin
// - избавл€емс€ от теговых обЄрток.
//
// Revision 1.10  2014/02/25 16:56:53  voba
// - bugfix
//
// Revision 1.9  2014/02/25 09:22:54  voba
// - bugfix
//
// Revision 1.8  2014/02/18 10:57:30  voba
//  k:236721575 (јтрибуты в EVD)
//
// Revision 1.7  2013/05/31 07:20:40  lulin
// - портируем под XE4.
//
// Revision 1.6  2013/04/19 13:07:39  lulin
// - портируем.
//
// Revision 1.5  2010/08/03 13:16:38  voba
// - k: 229672814
//
// Revision 1.4  2009/10/29 07:13:41  voba
// - cc
//
// Revision 1.3  2009/10/26 14:37:14  voba
// - развитие TdtRecord
//
// Revision 1.2  2009/09/15 12:34:56  voba
// - rename function WasFound
//
// Revision 1.1  2009/09/11 08:35:21  voba
// - новый объект дл€ доступа к пол€м записи
//

{$Include l3XE.inc}

interface
uses
 HT_Const,
 dt_Err,
 dtIntf;

const
 MaxRecSize = 2000;  //HT_Const.MAX_REC_LEN = $FFED;  (* ћаксимальна€ длина записи в таблице      *)

type
 TdtRecordAccess = {$IfDef XE4}record{$Else}object{$EndIf}
  fRecBufferPtr : pointer;
  fTable     : ITblInfo;

  procedure GetField(aField : ThtField; var aBody);
   {* - получить поле записи}

  function GetStrField(aField : ThtField) : AnsiString;
   {* - получить строковое поле записи}
  procedure GetCharArrayField(aField : ThtField; var aBody);
   {* - «аполн€ет переменную типа array of Char}

  function GetIntField(aField : ThtField) : Longint;
  {* - получить числовое поле записи}

  procedure FillField(aField: ThtField; const aValue: TVarRec);
   overload;
  procedure FillField(aField: ThtField; const aValue: array of const);
   overload;
  procedure FillRecord(const aRecordArr: array of const);
   overload;
  procedure FillRecord(aRec : pointer);
   overload;
 end;

 PdtRecord = ^TdtRecord;

 TdtRecord = {$IfDef XE4}record{$Else}object{$EndIf}
  fRecH      : RHANDLE;

  //!!следующие два строго друг за другом !! htReadRecordByHandle считывает запись с физ. номером,
  //поэтому отдаем ей указатель на fAbsNum
  fAbsNum    : Longint;
  fRecBuffer : array[0 .. Pred(MaxRecSize)] of byte;

  fBufFilled : boolean;
  fRecordAccess : TdtRecordAccess;

  function FindByUniq(aKeyFld : ThtField; const aKeyData) : boolean;
   {* -  поиск записи по уникальному ключу}

  procedure Unlock;
  procedure Get(aWithHold : Boolean = false);
   {* - получить тело записи во внутренний буфер, с захватом записи или без}
  procedure GetTo(aBuffer : Pointer);
   {* - получить тело записи в aBuffer}

  procedure Update;
   {* - сохранить изменени€ в таблицу}

  procedure GetField(aField : ThtField; var aBody);
   {* - получить поле записи}
  function GetIntField(aField : ThtField) : Longint;
   {* - получить числовое поле записи}
  function GetStrField(aField : ThtField) : AnsiString;
   {* - получить строковое поле записи}
  procedure GetCharArrayField(aField : ThtField; var aBody);
   {* - «аполн€ет переменную типа array of Char}

  procedure FillField(aField: ThtField; const aValue: TVarRec);
   overload;
  procedure FillField(aField: ThtField; const aValue: array of const);
   overload;

  procedure FillRecord(const aRecordArr: array of const);

  function WasFound : Boolean;
   {* - запись найдена}
 end;

 function InitRecordAccess(const aTable : ITblInfo; aRecBufferPtr : pointer) : TdtRecordAccess;
 function InitRecord(const aTable : ITblInfo) : TdtRecord;

implementation
uses
 SysUtils,
 HT_Dll,
 l3Chars,
 l3String,
 l3Base,
 l3Variant,
 l3MinMax,
 k2Interfaces;

function InitRecordAccess(const aTable : ITblInfo; aRecBufferPtr : pointer) : TdtRecordAccess;
begin
 with Result do
 begin
  fTable     := aTable;
  fRecBufferPtr := aRecBufferPtr;
 end;
end;

function InitRecord(const aTable : ITblInfo) : TdtRecord;
begin
 with Result do
 begin
  l3FillChar(fRecBuffer, SizeOf(fRecBuffer));
  fRecordAccess := InitRecordAccess(aTable, @fRecBuffer);
  fBufFilled := False;
  fAbsNum    := 0;
  fRecH      := 0;
 end;
 Assert(aTable.RecSize <= MaxRecSize, Format('нужно увеличить TdtRecord.MaxRecSize до %d байт', [aTable.RecSize]));
end;

function TdtRecord.FindByUniq(aKeyFld : ThtField; const aKeyData) : boolean;
begin
 fAbsNum := Ht(htRecordByUniq(nil, fRecordAccess.fTable.Handle, aKeyFld, @aKeyData, @fRecH));
 fBufFilled := False;
 Result := WasFound;
end;

function TdtRecord.WasFound : Boolean;
begin
 Result := fAbsNum > 0;
end;

procedure TdtRecord.GetTo(aBuffer : Pointer);
begin
 Get;
 l3Move(fRecBuffer, aBuffer^, fRecordAccess.fTable.RecSize);
end;

procedure TdtRecord.Get(aWithHold : Boolean = false);
begin
 if fAbsNum = 0 then raise EHtErrors.CreateInt(ecNotFound);

 fRecordAccess.fRecBufferPtr := @fRecBuffer;
 if fBufFilled then Exit;
 fRecordAccess.fTable.CheckIsOpen;
 if aWithHold and (not fRecordAccess.fTable.IsTblHeld) then
  Ht(htHoldReadRecord(fRecordAccess.fTable.Handle, fAbsNum, @fRecBuffer))
 else
  //htReadRecordByHandle считывает запись с физ. номером, поэтому отдаем ей указатель на fAbsNum
  Ht(htReadRecordByHandle(fRecordAccess.fTable.Handle, fRecH, @fAbsNum));

 fBufFilled := True;
end;

procedure TdtRecord.Update;
var
 lEditTbl : IEditTbl;
begin
 if Supports(fRecordAccess.fTable, IEditTbl, lEditTbl) then
 begin
  if WasFound then
   lEditTbl.UpdRec(fAbsNum, @fRecBuffer)
  else
   lEditTbl.AddRec(@fRecBuffer);
 end
 else
  Assert(False);  
end;

procedure TdtRecord.Unlock;
begin
 if fAbsNum = 0 then raise EHtErrors.CreateInt(ecNotFound);
 Ht(htReleaseRecord(fRecordAccess.fTable.Handle, fAbsNum));
end;

function TdtRecord.GetStrField(aField : ThtField) : AnsiString;
begin
 Get;
 Result := fRecordAccess.GetStrField(aField);
end;

function TdtRecord.GetIntField(aField : ThtField) : Longint;
begin
 Get;
 Result := fRecordAccess.GetIntField(aField);
end;

procedure TdtRecord.GetCharArrayField(aField : ThtField; var aBody);
begin
 Get;
 fRecordAccess.GetCharArrayField(aField, aBody);
end;

procedure TdtRecord.GetField(aField : ThtField; var aBody);
begin
 Get;
 fRecordAccess.GetField(aField, aBody);
end;

procedure TdtRecord.FillField(aField: ThtField; const aValue: array of const);
begin
 fRecordAccess.FillField(aField, aValue);
end;

procedure TdtRecord.FillField(aField: ThtField; const aValue: TVarRec);
begin
 fRecordAccess.FillField(aField, aValue);
end;

procedure TdtRecord.FillRecord(const aRecordArr: array of const);
begin
 fRecordAccess.FillRecord(aRecordArr);
end;

{TdtRecordAccess}

function TdtRecordAccess.GetIntField(aField : ThtField) : Longint;
begin
 Result := 0; // зачистим все 4 байта
 GetField(aField, Result);
end;

function TdtRecordAccess.GetStrField(aField : ThtField) : AnsiString;
begin
 Assert(fTable.ElementType[aField] = ET_CHAR, Format('“аблица %s поле %d не строка', [fTable.TblName, aField]));
 GetField(aField, Result);
end;

procedure TdtRecordAccess.GetCharArrayField(aField : ThtField; var aBody);
begin
 Assert(fTable.ElementType[aField] = ET_CHAR, Format('“аблица %s поле %d не строка', [fTable.TblName, aField]));
 with fTable.Element[aField] do
  l3Move(PAnsiChar(fRecBufferPtr)[wOffset], aBody, wLength);
end;

procedure TdtRecordAccess.GetField(aField : ThtField; var aBody);
begin
 with fTable do
 begin
  with Element[aField] do
  case cType of
   ET_CHAR :
    AnsiString(aBody) := l3ArrayToString(PAnsiChar(fRecBufferPtr)[wOffset], wLength);

   ET_ARRA :
    Assert(false, 'TdtRecordAccess.GetField ET_ARRA!!!');
    //begin
    // Assert(false, 'TdtRecordAccess.GetField ET_ARRA!!!');
    // l3System.GetLocalMem(Pointer(aBody),PElemArr(fFields)^[aField].wLength);
    // l3Move(aRecord[PElemArr(fFields)^[aField].wOffset], Pointer(aBody)^, PElemArr(fFields)^[aField].wLength);
    //end;

   ET_BYTE,
   ET_INTR,
   ET_WORD,
   ET_DATE,
   ET_NMBR,
   ET_LONG,
   ET_DWRD,
   ET_FLOA,
   ET_CURR,
   ET_DFLT :
    l3Move(PAnsiChar(fRecBufferPtr)[wOffset], aBody, wLength);
  end;
 end;
end;

procedure TdtRecordAccess.FillField(aField: ThtField; const aValue: array of const);
begin
 Assert(High(aValue) = 0, 'procedure TdtRecordAccess.FillField:  только одно поле можно подать');

 FillField(aField, aValue[0]);
end;

procedure TdtRecordAccess.FillField(aField: ThtField; const aValue: TVarRec);
var
 lFieldLen : Integer;
 lRecPtr   : Pointer;

 procedure AddStrToData(aStr : PAnsiChar; aStrLen : Integer);
 begin
  if aStrLen > 0 then
   l3Move(aStr^, lRecPtr^, Min(aStrLen, lFieldLen));
  if lFieldLen > aStrLen then
   l3FillChar((PAnsiChar(lRecPtr) + aStrLen)^, lFieldLen - aStrLen, 32);
 end;

var
 lTag : Il3TagRef;
 lInt : Integer;
begin
 lRecPtr := PAnsiChar(fRecBufferPtr) + fTable.FldOffset[aField];
 lFieldLen := fTable.FldLength[aField];

 with aValue do
  case VType of
   vtInteger :
    l3Move(VInteger, lRecPtr^, lFieldLen);

   vtPChar :
    AddStrToData(VPChar, l3StrLen(VPChar));

   vtAnsiString :
    AddStrToData(PAnsiChar(AnsiString(VAnsiString)), Length(AnsiString(VAnsiString)));

   vtObject :
    if VObject = nil then
     AddStrToData(nil, 0)
    else
     if VObject is Tl3CustomString then
      with Tl3CustomString(VObject).AsWStr do
       AddStrToData(S, SLen)
    else
     if VObject is Tl3Tag then
      with Tl3Tag(VObject).AsWStr do
       AddStrToData(S, SLen)
    else
     Assert(False,'TCacheDiffAttrData.AddRecord данные левого типа');

   vtInterface:
    if Supports(IInterface(VInterface), Il3TagRef, lTag) then
     with lTag.AsObject.AsWStr do
      AddStrToData(S, SLen)
    else
     Assert(False,'TCacheDiffAttrData.AddRecord данные левого типа');
    //else
    // AddStrToData(nil, 0);

   vtBoolean :
    begin
     lInt := Ord(VBoolean);
     l3Move(lInt, lRecPtr^, lFieldLen);
    end
   else
     Assert(False,'TCacheDiffAttrData.AddRecord данные левого типа');

  end; //case VType of
end;

procedure TdtRecordAccess.FillRecord(const aRecordArr: array of const);
var
 I : Integer; // номер пол€ в рекорде = номер пол€ в таблице - 1 (суррогатный ключ не передаем)
begin
 Assert(High(aRecordArr) = fTable.FldCount, Format('“аблица %s Ќеверное количество полей', [fTable.TblName]));
 for I := 0 to High(aRecordArr) do
  FillField(Succ(I), aRecordArr[I]);
end;

procedure TdtRecordAccess.FillRecord(aRec : pointer);
begin
 l3Move(aRec^, fRecBufferPtr^, fTable.RecSize);
end;

end.


(*
procedure TdtTblInfo.CheckFieldValue(aField: ThtField; pValue: Pointer);

 procedure CheckValue(aTestResult: Boolean);
 begin
  if not aTestResult then
   raise EHtErrors.CreateInt(ecWrongFieldValue,
                             [ValueAsString(aField, pValue),
                              FieldName(aField),
                              fTableName]);
 end;

 procedure ReplaceWrongSymbols; // мен€ет недопустимые символы на пробелы (только на коротких символьных пол€х (длина < 255))
 var
  lWrongChar : array[boolean] of Char = [#255, #160];
 begin
  if (pValue = nil)
   or (PElemArr(fFields)^[aField].wLength > 255) // на длинных пол€х все символы допустимы (из док. по HT)
  then
   Exit;

   lWrongChar[fTable.IsAnsi]

 end;

begin
 CheckFieldNum(aField);

 with Ftable.ElementInfo[aField]
 case cType of
  ET_CHAR,
  ET_ARRA:
   if (wLength <= 255) then // на длинных пол€х все символы допустимы (из док. по HT)
    l3Replace(var aString   : String; lWrongChar[fTable.IsAnsi], cc_HardSpace);

   begin

   end;
  ET_BYTE: CheckValue(PByte(pValue)^ <> 255);
  ET_INTR: CheckValue(PSmallInt(pValue)^ <> -32768);
  ET_WORD,
  ET_DATE: CheckValue(PWord(pValue)^ <> 65535);
  ET_LONG: CheckValue(PLongInt(pValue)^ >= -2147483647);
  ET_DWRD: CheckValue(PLongWord(pValue)^ <> 4294967295);
//  ET_NMBR:
//  ET_FLOA:
//  ET_CURR:
//  ET_DFLT:
 end;
end;
*)
