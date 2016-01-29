unit dt_TblInfo;

{ $Id: dt_TblInfo.pas,v 1.11 2015/10/30 08:54:57 lukyanets Exp $ }

// $Log: dt_TblInfo.pas,v $
// Revision 1.11  2015/10/30 08:54:57  lukyanets
// Неинициализированные поля
//
// Revision 1.10  2015/09/10 15:02:48  voba
// no message
//
// Revision 1.9  2013/10/30 10:36:40  voba
// - отказ от fSrchList
//
// Revision 1.8  2013/04/19 13:07:39  lulin
// - портируем.
//
// Revision 1.7  2013/01/16 09:43:16  voba
// -add procedure ExportToFile
//
// Revision 1.6  2012/11/19 11:41:19  voba
// - add функции генерации строки из записи (для отладки)
//
// Revision 1.5  2009/09/11 08:33:32  voba
// - опубликовал некоторые функции
//
// Revision 1.4  2009/06/23 07:32:59  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.3  2009/05/12 08:41:09  voba
// - заменил в ISab ссылки на таблицу на интерфейсы
//
// Revision 1.2  2009/05/08 11:10:08  voba
// - заменил TblH на Handle
//
// Revision 1.1  2009/04/21 08:05:10  voba
// - отпилил от TdtTable информационную часть TdtTableInfo
//
interface
uses
 l3Base,
 HT_Const,
 dt_Types,
 dtIntf;

type
 TdtTblInfo = class(Tl3Base, ITblInfo)
 protected
  fTblName        : TTblNameStr;
  fTableName      : AnsiString;
  fIsAnsi         : Boolean;
  fPureFldCnt     : Word;
  fFieldCount     : Word;
  fFields         : LPElement;
  fFullRecSize    : Word;
  fUniqKeyElemNum : Word;
  fIsTableOpened  : Boolean;
  fTblH           : HT_Const.THANDLE;

  fDelimiter      : Char;  // for text out
  fQuote          : Char;  // for text out

 protected
  procedure InitFields; override;
  function  GetHandle: HT_Const.THANDLE;

  procedure AllocTblInfo;
  procedure CheckTblInfo;

  function  FieldName(aField: ThtField): ansistring;

  function  GetFldLength(aField : ThtField): Word;
  function  GetFldOffset(aField : ThtField): Word;

  function  CalcUniqKeyElemNum: ThtField;
  function  GetUniqKeyElemNum: ThtField;

  function  GetElement(aField: ThtField) : ThtElementInfo;
  function  GetElementName(aField: ThtField) : AnsiString;
  function  GetElementClass(aField: ThtField) : Byte;
  function  GetElementKeyKind(aField: ThtField) : Byte;
  function  GetElementType(aField: ThtField) : Byte;

  function  GetPureFldCnt : Word;
  function  GetFieldCount : Word;

  function  GetFullRecSize : Word;
  function  GetTblName : TTblNameStr;

  function  GetIsAnsi : Boolean;

  procedure CheckElementNum(aField: Word);
  procedure CheckFieldNum(aField: Word);
  function  ValueAsString(aFieldNum: Word; pValue: Pointer): AnsiString;
  procedure CheckFieldValue(aField : ThtField; pValue: Pointer);
  function  IsFieldInUniqKey(aField: ThtField) : Boolean;

  function  FirstFieldOfGroup(aField : ThtField): Word;

 public
  function  ElemNumByName(const anElemName: AnsiString): Integer;
  function  PhotoOfTable : Sab;
  procedure CheckIsOpen;
  function  FieldsInGroup(aField : ThtField) : Word;
              // кол-во ПОЛЕЙ, составляющих групповое поле
  function  IsTblHeld: Boolean; virtual; abstract;

  procedure SetTextDecor(aDelimiter: Char; aQuote : Char);
  function  GenRecStr(pRec : Pointer) : AnsiString;
     {- генерирует "Human Readable" строку из тела записи. Используется для отладки}
  function  GenRecHeaderStr : AnsiString;
  {- генерирует "Human Readable" строку из названий полей записи. Используется для отладки}

  procedure ReplaceHTStrWrongSymbols(pValue: PAnsiChar);
   {- меняет недопустимые символы на пробелы}
  function CheckHTStrWrongSymbols(pValue: PAnsiChar) : boolean; // проверяет строку на недопустимые символы
   {- проверяет строку на недопустимые символы}

 public
  property  Handle : HT_Const.THANDLE read GetHandle; // дублирует  TblH и маскирует l3Base.Handle
  property  TblName : TTblNameStr read GetTblName { write fTblName};
  property  FldCount : Word read GetPureFldCnt;
  property  ElementsCount : Word read GetFieldCount;
  property  Element[aField : ThtField] : ThtElementInfo read GetElement;
  property  ElementName[aField : ThtField] : AnsiString read GetElementName;
  property  ElementClass[aField : ThtField]: Byte read GetElementClass;
  property  ElementType[aField : ThtField]: Byte read GetElementType;
  property  ElementKeyKind[aField : ThtField]: Byte read GetElementKeyKind;
  property  FldLength[aField : ThtField] : Word read GetFldLength;
  property  FldOffset[aField : ThtField] : Word read GetFldOffset;
  property  UniqKeyElemNum : ThtField read GetUniqKeyElemNum;
  property  RecSize : Word read GetFullRecSize;
  property  IsAnsi : Boolean read GetIsAnsi;
 end;


implementation
 uses
  SysUtils,
  l3String,
  HT_Dll,
  dt_Err;

procedure TdtTblInfo.InitFields;
begin
 Inherited;
 SetTextDecor(#9, '"');
end;

procedure TdtTblInfo.SetTextDecor(aDelimiter: Char; aQuote : Char);
begin
 fDelimiter := aDelimiter;
 fQuote     := aQuote;
end;

function TdtTblInfo.GetHandle: HT_Const.THANDLE;
begin
 Result := fTblH;
end;

function TdtTblInfo.GetFullRecSize : Word;
begin
 Result := fFullRecSize;
end;

function TdtTblInfo.GetTblName : TTblNameStr;
begin
 Result := fTblName;
end;

function TdtTblInfo.GetIsAnsi : Boolean;
begin
 Result := fIsAnsi;
end;

procedure TdtTblInfo.CheckIsOpen;
begin
 if not fIsTableOpened then
  raise EHtErrors.CreateInt(ecTblNotOpen);
end;

function TdtTblInfo.FieldName(aField: ThtField): ansistring;
begin
 CheckElementNum(aField);

 Result := StrPas(PAnsiChar(@(PElemArr(fFields)^[aField].mName)));
end;

procedure TdtTblInfo.AllocTblInfo;
var
 sTbl : ThtTableInfoRec;
begin
 CheckIsOpen;
 Ht(htTableInfo(fTblH, sTbl));
 with sTbl do
 begin
  fTableName := StrPas(PAnsiChar(@mName));
  fIsAnsi := (nFlags and TAB_ANSI) <> 0;
  fFullRecSize := wRecordLen;
  fFieldCount := nFieldCnt + nGroupCnt + nSubstrCnt;
  fPureFldCnt := nFieldCnt;
 end;

 l3System.GetLocalMem(fFields, fFieldCount * SizeOf(ThtElementInfo));
 Ht(htTableElementList(fTblH, fFields));
end;

procedure TdtTblInfo.CheckTblInfo;
begin
 if fFields = nil then
  AllocTblInfo;
end;

procedure TdtTblInfo.CheckElementNum(aField: Word);
begin
 CheckTblInfo;

 if (aField < 1) or (aField > fFieldCount) then
  raise EHtErrors.CreateInt(ecWrongFieldNumber);
end;

procedure TdtTblInfo.CheckFieldNum(aField: Word);
begin
 CheckTblInfo;
 if (aField < 1) or (aField > fPureFldCnt) then
  raise EHtErrors.CreateInt(ecWrongFieldNumber);
end;

function TdtTblInfo.ElemNumByName(const anElemName: AnsiString): Integer;
var
 I: Integer;
begin
 CheckTblInfo;

 Result := -1;
 for I := 1 to fFieldCount do
 begin
  if StrIComp(PAnsiChar(anElemName),
              @(PElemArr(fFields)^[I].mName)) = 0 then
  begin
   Result := I;
   Break;
  end;
 end;
 if Result = -1 then
  raise EHtErrors.CreateInt(ecNotFound);
end;

function TdtTblInfo.PhotoOfTable : Sab;
begin
 htMakePhoto(Result, Handle);
end;

function TdtTblInfo.GetElement(aField: ThtField) : ThtElementInfo;
begin
 //CheckTblInfo; call in CheckElementNum
 CheckElementNum(aField);
 Result := PElemArr(fFields)^[aField];
end;

function TdtTblInfo.GetElementName(aField: ThtField) : AnsiString;
begin
 //CheckTblInfo; call in CheckElementNum
 CheckElementNum(aField);
 with PElemArr(fFields)^[aField] do
  Result := l3ArrayToString(mName, SizeOf(mName));
end;

function TdtTblInfo.GetElementClass(aField: ThtField): Byte;
begin
 Result := Element[aField].cClass;
end;

function TdtTblInfo.GetElementKeyKind(aField: ThtField): Byte;
begin
 Result := Element[aField].cKey;
end;

function TdtTblInfo.GetElementType(aField: ThtField): Byte;
begin
 Result := Element[aField].cType;
end;

function TdtTblInfo.GetPureFldCnt : Word;
begin
 CheckTblInfo;
 Result := fPureFldCnt;
end;

function TdtTblInfo.GetFieldCount : Word;
begin
 CheckTblInfo;
 Result := fFieldCount;
end;

function TdtTblInfo.GetFldLength(aField : ThtField): Word;
begin
 if aField = 0 then
  Result := SizeOf(LongWord)
 else
  with Element[aField] do
   if cClass = EC_GROUP then
    Result := cType // см. документацию, и "ты все поймешь и все увидишь там"
   else
    Result := wLength;
end;

function TdtTblInfo.GetFldOffset(aField : ThtField): Word;
begin
 with Element[aField] do
 begin
  Result := wOffset;
  if cClass = EC_GROUP then
   Result := fldOffset[Result]; // см. документацию

  Assert(cClass <> EC_SUBSTR, 'TdtTblInfo.GetFldOffset(EC_SUBSTR)');
  (* чиво-то тут намудрено с EC_SUBSTR, но пока такого нет в базе
      Result := PElemArr(fTbl.fFields)^[PElemArr(fTbl.fFields)^[I].wOffset].wOffset +
                PElemArr(fTbl.fFields)^[PElemArr(fTbl.fFields)^[I].wOffset].wLength - 1;
  *)
 end;
end;

function TdtTblInfo.GetUniqKeyElemNum: ThtField;
begin
 if fUniqKeyElemNum = 0 then
  fUniqKeyElemNum := CalcUniqKeyElemNum;
 Result := fUniqKeyElemNum;
end;

function TdtTblInfo.IsFieldInUniqKey(aField: ThtField) : boolean;
var
 I: Word;
 lFirstFieldOfGroup : Word;
 lNumFieldsInGroup  : Word;
begin
 CheckTblInfo;

 Result := False;
 for I := 1 to ElementsCount do
 begin
  with PElemArr(fFields)^[I] do
  if cKey = EK_UNIQUE then
  begin
   if cClass = EC_GROUP then
   begin
    lFirstFieldOfGroup := wOffset; // см FirstFieldOfGroup(I);
    lNumFieldsInGroup  := wLength; // см FieldsInGroup(I);

    if (lFirstFieldOfGroup <= aField) and (aField < lFirstFieldOfGroup + lNumFieldsInGroup) then
    begin
     Result := True;
     Break;
    end;
   end
   else
    if I = aField then
    begin
     Result := True;
     Break;
    end;
  end;
 end;
end;

function TdtTblInfo.CalcUniqKeyElemNum: ThtField;
var
 I: Word;
begin
 CheckTblInfo;

 Result := High(ThtField);
 for I := 1 to ElementsCount do
 begin
  if PElemArr(fFields)^[I].cKey = EK_UNIQUE then
  begin
   Result := I;
   Break;
  (*
   if Result <> 0 then
   begin
    //if (CompareText(Copy(TblName, 1, 4), 'DT#B') = 0) then // таблица DT#B имеет 2 уник. ключа - вернем первый из них и на этом успокоимся.
     Break
    else
     raise ETableError(Format('Таблица %s имеет более одного уникального ключа.', [TblName]));
   end
   else
    Result := I;
   *)
  end; // if
 end; // for

 if Result = High(ThtField) then
  raise ETableError(Format('Таблица %s не имеет ни одного уникального ключа.', [TblName]));
end;

function TdtTblInfo.ValueAsString(aFieldNum: Word; pValue: Pointer): AnsiString;

 function CharsToStr(aChars: PAnsiChar; aAmount: Integer): AnsiString;
 var
  l_Buffer: AnsiString;
 begin
  SetLength(l_Buffer, aAmount + 1);
  l3FillChar(l_Buffer[1], aAmount + 1);

  StrLCopy(@l_Buffer[1], aChars, aAmount);
  Result := StrPas(PAnsiChar(@l_Buffer[1]));
 end;

 function BytesToStr(aBytes: PAnsiChar; aAmount: Integer): AnsiString;
 var
  I: Integer;
 begin
  for I := 0 to aAmount - 1 do
   Result := Result + '#' + IntToStr(PByte(aBytes + I)^);
 end;

 function lReplaceSpecialSymbols(const aStr : AnsiString) : AnsiString;
 var
  I : Integer;
 begin
  Result := aStr;
  for I := Length(Result) downto 1 do
   case Result[I] of
    #9 :
     Result[I] := ' ';
    #10 :
      Delete(Result, I, 1);
    #13 :
     begin
      Result[I] := 'n';
      Insert('\', Result, I);
     end;
    '\' :
     Insert('\', Result, I);
    else
     if Ord(Result[I]) < Ord(' ') then
      Result[I] := ' ';
   end;
 end;

begin
 CheckFieldNum(aFieldNum);

 case PElemArr(fFields)^[aFieldNum].cType of
  ET_CHAR:
   begin
    Result := lReplaceSpecialSymbols(l3RTrim(CharsToStr(pValue, fldLength[aFieldNum]), [#0, ' ', #13, #10, #9]));
    if fQuote <> #0 then
     Result := fQuote + Result + fQuote;
   end;
  ET_ARRA: Result := BytesToStr(pValue, fldLength[aFieldNum]);
  ET_BYTE: Result := IntToStr(PByte(pValue)^);
  ET_INTR: Result := IntToStr(PSmallint(pValue)^);
  ET_DATE,
  ET_WORD: Result := IntToStr(PWord(pValue)^);
  ET_NMBR: Result := '????';          // 3-х байтовое целое без знака - черт знает как его обрабатывать.
  ET_LONG: Result := IntToStr(PInteger(pValue)^);
  ET_DWRD: Result := IntToStr(PLongWord(pValue)^);
  ET_FLOA: Result := FloatToStr(PSingle(pValue)^);
  ET_CURR,
  ET_DFLT: Result := FloatToStr(PDouble(pValue)^);
 end;
end;

function TdtTblInfo.CheckHTStrWrongSymbols(pValue: PAnsiChar) : boolean; // проверяет строку на недопустимые символы
const
 lWrongChar : array[False..True] of AnsiChar = (#255, #160);
begin
 Result := (pValue <> nil) and (pValue[0] <> lWrongChar[fIsAnsi]);
end;

procedure TdtTblInfo.ReplaceHTStrWrongSymbols(pValue: PAnsiChar); // меняет недопустимые символы на пробелы
const
 c_Space: AnsiChar = ' ';
//var
// l_WrongChar: Char;
// I: Integer;
// l_Len: LongInt;
// l_Str: PAnsiChar;
// l_Found: PAnsiChar;
begin
 if (pValue = nil) then
  Exit;

 if not CheckHTStrWrongSymbols(pValue) then
  pValue[0] := c_Space;
end;


procedure TdtTblInfo.CheckFieldValue(aField: ThtField; pValue: Pointer);

 procedure CheckValue(aTestResult: Boolean);
 begin
  if not aTestResult then
   raise EHtErrors.CreateInt(ecWrongFieldValue,
                             [ValueAsString(aField, pValue),
                              FieldName(aField),
                              fTableName]);
 end;

begin
 CheckFieldNum(aField);

 case PElemArr(fFields)^[aField].cType of
  ET_CHAR,
  ET_ARRA: ReplaceHTStrWrongSymbols(pValue);

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

function TdtTblInfo.FieldsInGroup(aField : ThtField) : Word;
begin
 CheckElementNum(aField);
 if ElementClass[aField] = EC_GROUP then
  Result := PElemArr(fFields)^[aField].wLength // это не длина в байтах!!!
 else
  Result := 1;
end;

function TdtTblInfo.FirstFieldOfGroup(aField : ThtField): Word;
begin
 CheckElementNum(aField);

 if PElemArr(fFields)^[aField].cClass = EC_GROUP then
  Result := PElemArr(fFields)^[aField].wOffset // см. документацию
 else
  Result := aField;
end;

function TdtTblInfo.GenRecStr(pRec : Pointer) : AnsiString;
var
 I : Word;
begin
 Result := ValueAsString(1, PAnsiChar(pRec) + FldOffset[1]);
 for I := 2 to FldCount do
  Result := Result + fDelimiter + ValueAsString(I, PAnsiChar(pRec) + FldOffset[I]);
end;

function TdtTblInfo.GenRecHeaderStr : AnsiString;
var
 I : Word;
begin
 Result := ElementName[1];
 for I := 2 to FldCount do
  Result := Result + fDelimiter + ElementName[I];
end;



end.



