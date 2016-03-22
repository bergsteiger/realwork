unit NOT_FINISHED_l3Types;
 {* Базовые родные типы библиотеки L3. }

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3Types.pas"
// Стереотип: "Interfaces"
// Элемент модели: "l3Types" MUID: (4678193C009C)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3Core
;

const
 {* Индексы. }
 l3MinIndex = Low(Tl3Index);
  {* минимальный индекс элемента. }
 l3MaxIndex = High(Tl3Index);
  {* максимальный индекс элемента. }
 ntNone = 0;
  {* пустая операция. }
 ntInsert = 1;
  {* вставка элемента. }
 ntDelete = 3;
  {* удаление элемента. Вызывается до уничтожения ссылки }
 ntDeleteDone = 4;
  {* удаление элемента. Вызывается после уничтожения ссылки }
 ntDataChange = 5;
  {* изменились элемента. }
 ntMoveBegin = 6;
  {* началось движение элемента. }
 ntMoveEnd = 7;
  {* закончилось движение элемента. }
 ntClear = 8;
  {* очистили структуру данных. }
 ntClearItem = 9;
  {* очистили элемент. }
 ntChildClear = 10;
  {* очистили дочерний элемент. }
 ntChildInsert = 11;
  {* вставлен дочерний элемент. }
 ntFree = 12;
  {* освобождение элемента. }
 ntCountChange = 13;
  {* изменилось количество элементов. }
 ntChangeItemData = 14;
  {* изменились данные элемента. }
 ntChanging = 15;
  {* началось изменение. }
 ntChanged = 16;
  {* закончилось изменение. }
 ntResortChild = 17;
  {* Дочерние элементы изменили взаимное расположение. }
 l3GlyphFontName = '__Glyph__';
 l3_siNative = ;

type
 PIUnknown = ^IUnknown;
  {* Указатель на IUnknown. }

 PObject = ^TObject;

 Tl3ItemFlag = (
  {* Флаг элемента. }
  l3_ifNone
  , l3_ifNew
  , l3_ifDeleted
  , l3_ifModified
 );//Tl3ItemFlag

 TLongArray = array of Integer;
  {* Динамический массив целых чисел. }

 PLong = Integer;
  {* Указатель на long. }

 Tl3Rgn = hRgn;
  {* Регион. }

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
  const aMsg: AnsiString = '') of object;

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
