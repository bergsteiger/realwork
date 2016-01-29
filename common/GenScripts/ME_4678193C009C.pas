unit l3Types;

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3Core
;

type
 Tl3ItemFlag = (
  {* Флаг элемента. }
  l3_ifNone
  , l3_ifNew
  , l3_ifDeleted
  , l3_ifModified
 );//Tl3ItemFlag
 
 Tl3PCharLenBase = object(Tl3PCharLenPrim)
 end;//Tl3PCharLenBase
 
 Tl3PCharLen = object(Tl3PCharLenBase)
 end;//Tl3PCharLen
 
 Tl3PCharLenConst = object(Tl3PCharLenBase)
 end;//Tl3PCharLenConst
 
 TLongArray = array of Integer;
  {* Динамический массив целых чисел. }
 
 PLong = Integer;
  {* Указатель на long. }
 
 Tl3Rgn = hRgn;
  {* Регион. }
 
 PIUnknown = ^IUnknown;
  {* Указатель на IUnknown. }
 
 Tl3IteratorAction = function(Data: Pointer;
  Index: Integer): Boolean;
  {* Подитеративная функция. }
 
 TByteSet = set of byte;
  {* Множество байт. }
 
 Tl3Duplicates = (
  {* Операция применимая к совпадающим элементам списка }
  l3_dupIgnore
   {* игнорировать новый элемент. }
  , l3_dupAccept
   {* принять новый элемент. }
  , l3_dupError
   {* выдать сообщение об ошибке. }
  , l3_dupAssign
   {* присвоить новый элемент старому. }
  , l3_dupChange
   {* заменить старый элемент новым. }
 );//Tl3Duplicates
 
 Tl3Index = l3Interfaces.Tl3Index;
  {* Индекс элементов. }
 
 Tl3FreeAction = function(Data: Pointer): Boolean;
  {* Функция для итераторов и нотификаций об освобождении объекта. }
 
 Tl3SortIndex = type SmallInt;
  {* Индекс сортировки. }
 
 Tl3Handle = Integer;
  {* Тип целочисленных идентификаторов. Знаковый. Размер не фиксирован. }
 
 TSmallIntArray = array of SmallInt;
  {* Динамический массив коротких целых чисел. }
 
 PInteger = l3Interfaces.PInteger;
 
 Large = l3Interfaces.Large;
 
 EDoChangedAlreadyDone = class
 end;//EDoChangedAlreadyDone
 
 PObject = ^TObject;
 
 Tl3Operation = (
  {* Операция }
  l3_opDelete
   {* удаление }
  , l3_opInsert
   {* вставка }
 );//Tl3Operation
 
 Tl3FileMode = (
  {* Режим работы с файлами:
* l3_fmRead</b> - чтение.
* l3_fmWrite</b> - запись.
* l3_fmReadWrite</b> - чтение-запись.
* l3_fmAppend - добавление в конец. }
  l3_fmRead
  , l3_fmWrite
  , l3_fmReadWrite
  , l3_fmAppend
  , l3_fmExclusiveReadWrite
  , l3_fmExclusiveWrite
  , l3_fmExclusiveAppend
  , l3_fmCreateReadWrite
  , l3_fmFullShareReadWrite
  , l3_fmFullShareCreateReadWrite
 );//Tl3FileMode
 
 Tl3Bool = (
 );//Tl3Bool
 
 Tl3ProgressProc = procedure(aState: Byte;
  aValue: Integer;
  const aMsg: AnsiString) of object;
 
 PWord = ;
 
 Tl3BMTable = ;
 
 Tl3Char = record
 end;//Tl3Char
 
 Tl3PathStr = AnsiString;
 
 Tl3Method = ;
 
implementation

uses
 l3ImplUses
;

end.
