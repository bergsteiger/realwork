unit dtIntf;

{ $Id: dtIntf.pas,v 1.12 2016/05/17 11:59:35 voba Exp $ }

// $Log: dtIntf.pas,v $
// Revision 1.12  2016/05/17 11:59:35  voba
// -k:623081921
//
// Revision 1.11  2016/01/22 12:18:59  lukyanets
// Переосмысливаем мигратор
//
// Revision 1.10  2015/09/10 15:02:26  voba
// no message
//
// Revision 1.9  2014/12/25 15:40:52  voba
// - функции восстановления Priority и SortDate
//
// Revision 1.8  2014/09/04 12:13:02  dinishev
// {Requestlink:564750095}. Перенес интерфейсы листнетов в ddTypes
//
// Revision 1.7  2014/09/04 11:01:31  dinishev
// {Requestlink:564750095}
//
// Revision 1.6  2014/04/17 13:04:32  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.5  2013/04/19 13:07:39  lulin
// - портируем.
//
// Revision 1.4  2012/07/16 11:17:53  voba
// no message
//
// Revision 1.3  2009/10/26 14:39:59  voba
// - add  procedure AddRec, UpdRec
//
// Revision 1.2  2009/09/11 08:32:32  voba
// - опубликовал некоторые функции
//
// Revision 1.1  2009/05/12 08:39:57  voba
// - заменил в ISab ссылки на таблицу на интерфейсы
//

interface
uses
 HT_Const,
 l3Types,
 l3Interfaces,
 Dt_Types;

type
 ISab = interface;

 ITblInfo = interface(Il3Base)
  ['{473BFC63-AECB-4A27-B61A-7A6C17C68BA1}']

  function  GetHandle: HT_Const.THANDLE;
  function  GetFldLength(aField : ThtField): Word;
  function  GetFldOffset(aField : ThtField): Word;
  function  CalcUniqKeyElemNum : ThtField;
  function  GetUniqKeyElemNum : ThtField;
  function  GetElement(aField: ThtField) : ThtElementInfo;
  function  GetElementClass(aField : ThtField): Byte;
  function  GetElementKeyKind(aField : ThtField): Byte;
  function  GetElementType(aField : ThtField): Byte;
  function  GetPureFldCnt : Word;
  function  GetFieldCount : Word;
  function  GetFullRecSize : Word;
  function  GetTblName : TTblNameStr;
  function  GetIsAnsi : Boolean;

  function  ElemNumByName(const anElemName : AnsiString): Integer;
  function  PhotoOfTable : Sab;
  function  IsTblHeld: Boolean;
  procedure CheckIsOpen;
  procedure CheckFieldNum(aField: Word);

  procedure SetTextDecor(aDelimiter: Char; aQuote : Char);
  function  GenRecStr(pRec : Pointer; AddEmtryTailColumnCount: Integer = 0) : AnsiString;
     {- генерирует "Human Readable" строку из тела записи. Используется для отладки}
  function  GenRecHeaderStr : AnsiString;
  {- генерирует "Human Readable" строку из названий полей записи. Используется для отладки}


  property  Handle : HT_Const.THANDLE read GetHandle;
  property  TblName : TTblNameStr read GetTblName;
  property  fldCount : Word read GetPureFldCnt;
  property  ElementsCount : Word read GetFieldCount;
  property  Element[aField : ThtField] : ThtElementInfo read GetElement;
  property  ElementClass[aField : ThtField] : Byte read GetElementClass;
  property  ElementType[aField : ThtField] : Byte read GetElementType;
  property  ElementKeyKind[aField : ThtField] : Byte read GetElementKeyKind;
  property  FldLength[aField : ThtField] : Word read GetFldLength;
  property  FldOffset[aField : ThtField] : Word read GetFldOffset;
  property  UniqKeyElemNum : ThtField read GetUniqKeyElemNum;
  property  RecSize : Word read GetFullRecSize;
  property  IsAnsi : Boolean read GetIsAnsi;
 end;


 IEditTbl = interface(Il3Base)
  ['{B3B5AFFC-233C-4E2F-85B1-5B8E6D99326A}']
  procedure AddRec(aRec: Pointer);
  procedure UpdRec(aAbsNum  : LongInt; aRec : Pointer);

  procedure ModifyRecs(aRecs : Sab; aField : ThtField; aValue : Pointer; aDupIgnore : Boolean = False); overload;
  procedure ModifyRecs(aRecs : Sab; aModifyProc : Pointer; aDupIgnore : Boolean = False; aNeedLock : boolean = True); overload;
  //procedure AddRecs(aRecsBuffer : TStream); overload;
  procedure AddRecs(aRecCount : Cardinal; aFillBuffProc : TFillBufferProc); overload;
  procedure AddRecs(aRecsBuffer : Pointer; aRecsCount : Cardinal); overload;
   {* - добавляет записи aRecs в таблицу, проблемные игнорирует}
  procedure CopyRecs(aRecs : ISab; aModifyProc : TdtRecAccessProc); overload;
   {* - добавляет в таблицу копии записи aRecs, предварительно модифицированные в aModifyProc}

 end;

 TCacheMethod = (cmForward, cmBalanced);

 TFieldArray = TSmallIntArray; //array of ThtField;

 TJoinFieldRec = record
  rTable : ITblInfo;
  rField : ThtField;
 end;

 TJoinFieldArray = array of TJoinFieldRec;

 IValueSetFiller = interface(Il3Base)
   ['{7FBD6592-1B32-425C-9EAF-A0A4891C7C81}']
   //function GetBuffLen : Integer;
   //function GetBuffer : Pointer;
   procedure AddValue(var aValue);

   //property  Buffer : Pointer read GetBuffer;
   //property  BuffLen : Integer read GetBuffLen;
 end;

 ISabCursor = interface(Il3Base)
   ['{9A4FD38A-4571-47C7-81E5-1353C81A5423}']

  function Count : Integer;

  function ReadBuffer(aBuffer : Pointer; aBuffSize : integer) : Cardinal;
   {* - Считывает пачку записей в буффер aBuffer. Курсор переставляется на конец пачки}
  function GetItem(aIndex : Cardinal) : Pointer;
   {* - возвращает указатель на тело записи }
  function AddItem(aAbsNum : Cardinal) : Cardinal; overload;
   {* - возвращает индекс вставленного элемента }
  procedure AddItem(aData : Pointer); overload;
   {* - вставляет данные в список значений }
  function DelItem(aIndex : Cardinal) : Cardinal;
   {* - возвращает Abs номер удаленного элемента }
  function GetRecHandle(aIndex : Cardinal): RHandle;
   {* - возвращает Handle элемента }
  function GetIndex(aAbsNum : Cardinal) : Cardinal;
   {* - возвращает Index элемента по AbsNum}
  function ItemSize : Cardinal;
   {* - возвращает размер элемента}
  function Find(const aCompareProc : Tl3PtrCompareProc;
                      aCompareData : Pointer;
                         aLow, aHi : Longint;
                     out theIndex  : Longint;
                         aNeedLast : boolean = false): Boolean;
   {* - ищет элемент методом дихотомии, адаптированной к использованию на буфере.
        Данные должны быть сортированы!!! Сортировка не проверяется!!!}

  procedure Sort(const aElemNum : array of ThtField);
   overload;
  procedure SortJoin(const aElemNum : array of TJoinFieldRec);
   //overload;
  procedure Sort(aSortProc : TUserSortProc; const aElemNum : array of ThtField);
   overload;
  procedure Sort(aSortProc : TUserSortProc; const aElemNum : array of TJoinFieldRec);
   overload;

  procedure Sort;
   overload;
 end;

 ISab = interface(Il3Base)
    ['{3EBA4F01-0C61-4A92-BB03-5EEA630F9FBA}']

    function  Get_HTSab : Sab;
    function  Get_HTSabAddr : PSab;
    function  Get_Table : ITblInfo;
    function  Get_TypeOfSab : SmallInt;
    function  Get_SizeOfItem : Cardinal;

    function GetFieldSizeArray : TSmallIntArray;
     overload;
    function GetFieldSizeArray(const aFldArr : array of ThtField) : TSmallIntArray;
     overload;

    procedure Refresh;
    procedure Clear;
    function  IsEmpty : Boolean;
    function  IsValid : Boolean;
    function  Count : Integer;

    function  MakeSabCursor(const aFields :  array of ThtField;
                            aCacheMethod : TCacheMethod = cmForward;
                            aOpenMode : SmallInt = ROPEN_BODY) : ISabCursor;

    function  MakeValueSetFiller(aField : ThtField; const aPhoto : ISab = nil) : IValueSetFiller;

    procedure RecordsByKey(aKeyFld : ThtField; const aPhoto : ISab = nil);
     overload;
    procedure RecordsByKey;
     overload;
    procedure ValuesOfKey(aKeyFld : ThtField);

    procedure ValuesOfKeyByCount(aKeyFld : ThtField; aMinRepeat : Longint = 2);
    {* - значения поля с заданным (не меньше aMinRepeat) количеством упоминаний}

    procedure TransferToPhoto(aKeyFld : ThtField; const aPhoto : ISab = nil);
     overload;
    procedure TransferToPhoto(aKeyFld : ThtField; const aTable : ITblInfo);
     overload;
    procedure TransferToPhoto(const aPhoto : ISab = nil);
     overload;

    procedure SyncWith(const aPhoto : ISab);
    function  Age : Int64;

    procedure Select(aElemNum : ThtField; const aValue; aCond : ThtCondition = EQUAL; const aPhoto : ISab = nil);
     overload;
    procedure Select(aElemNum : ThtField; const aLoValue; const aHiValue; const aPhoto : ISab = nil);
     overload;

    procedure SelectByMask(aElemNum : ThtField; aMask : Integer; const  aPhoto : ISab = nil);
    {* - Функция предназначена для получения подмножества записей, cо значениями aElemNum в которых выставлены биты как в aMask}
    procedure SubSelectByMask(aElemNum : ThtField; aMask : Integer);

    // ФУНКЦИЯ НЕ ТЕСТИРОВАЛАСЬ
    procedure SelectUserDefined(aElemNum : ThtField; const aUserSearchProc: TdtRecAccessProc; const aPhoto : ISab = nil);

    procedure SelectAll(const aPhoto : ISab = nil);

    procedure SubSelect(aElemNum : ThtField; const aValue; aCond : ThtCondition = EQUAL);
     overload;
    procedure SubSelect(aElemNum : ThtField; const aLoValue; const aHiValue);
     overload;

    procedure SubSelectUserDefined(aElemNum : ThtField; const aUserSearchProc: TdtRecAccessProc);

    procedure SubSelectTwoFldEq(aElemNum1 : ThtField; aElemNum2 : ThtField);
     {* - Функция предназначена для получения подмножества записей, c одинаковыми значениями полей aElemNum1 и aElemNum2}

    procedure Histogram(aElemNum : ThtField; aMinRepeat : Longint = 2);

    procedure DeleteFromTable;
    procedure Sort(const aElemNum : array of ThtField);
     overload;
    procedure Sort(aSortProc : TUserSortProc; const aElemNum : array of ThtField);
     overload;
    procedure Sort;
     overload;
    procedure UnSort;

    procedure Distinct(const aElemNum : array of ThtField);

    procedure AndSab(const aSab: ISab);
    procedure OrSab(const aSab: ISab);
    procedure XorSab(const aSab: ISab);
    procedure SubtractSab(const aSab: ISab);
    procedure InvertSab;

    procedure RecFilter(aCheckRecProc : Pointer);
      {-}

    function  GetMaxValue(aElemNum : ThtField) : Longint;
    function  GetMinValue(aElemNum : ThtField) : Longint;

    procedure Flush; //выместить на диск

    procedure ModifyRecs(aModifyProc : Pointer; aDupIgnore : Boolean = False);
     overload;
    procedure ModifyRecs(aField : ThtField; var aValue; aDupIgnore : Boolean = False);
     overload;

    procedure IterateRecords(aRecProc : TdtRecAccessProc);
     overload;
    procedure IterateRecords(aRecProc : TdtRecAccessProc; const aFldArr : array of ThtField; aOpenMode : SmallInt = ROPEN_BODY);
     overload;

    procedure IterateBlockOfRecords(aRecProc : TdtBlockAccessProc);
     overload;
    procedure IterateBlockOfRecords(aRecBlockProc : TdtBlockAccessProc; const aFldArr : array of ThtField);
     overload;

    procedure CopyRecordsToBuffer(aBuffer : Pointer);
     overload;
     {* - копирует все записи в буфер. Буфер длиной не менее Count*SizeOfItem должен быть выделен заранее }
    procedure CopyRecordsToBuffer(aBuffer : Pointer; const aFldArr : array of ThtField);
     overload;
     {* - копирует выбранные поля записей в буфер. Буфер длиной не менее Count*SizeOfItem должен быть выделен заранее }

    function IsOpened : Boolean;
    procedure OpenSab;
    procedure CloseSab;

    function  ExtractHTSab : Sab;
   {- "Извлекает" HTSab из объекта. При этом объект перестает владеть им и HTSab не будет уничтожен вместе с объектом
       !!Функция переходного периода, для сопряжения с ранее написанным кодом}

    property HTSab : Sab read Get_HTSab;
    property HTSabAddr : PSab read Get_HTSabAddr;
    property Table : ITblInfo read Get_Table;
    property TypeOfSab : SmallInt read Get_TypeOfSab;
    property SizeOfItem : Cardinal read Get_SizeOfItem;
 end;//ISab

 IJoinSab = interface(ISab)
  ['{2DEC691B-6CCB-4AD0-AE12-932156D53ED8}']
   function    MakeJoinSabCursor(const aFields : array of TJoinFieldRec;
                                       aCacheMethod : TCacheMethod = cmForward;
                                       aOpenMode : SmallInt = ROPEN_BODY) : ISabCursor;

   procedure   IterateJoinRecords(aRecProc : TdtRecAccessProc; const aFldArr : array of TJoinFieldRec);

   procedure   CopyJoinRecordsToBuffer(aBuffer : Pointer; const aFldArr : array of TJoinFieldRec);

   procedure   SortJoin(aElemNum : array of TJoinFieldRec);
    overload;
   procedure   SortJoin(aSortProc : TUserSortProc; aElemNum : array of TJoinFieldRec);
    overload;
   function    TranslateFieldNumber(const aFields : array of TJoinFieldRec) : TFieldArray;
    overload;
   function    TranslateFieldNumber(const aField : TJoinFieldRec) : ThtField;
    overload;

 end; //IJoinSab

implementation
end.
