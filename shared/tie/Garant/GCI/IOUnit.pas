unit IOUnit;
 {* пакет интерфейсов ввода-вывода }

// Модуль: "w:\shared\tie\Garant\GCI\IOUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "IO" MUID: (4423F94903C8)

interface

uses
 l3IntfUses
;

type
 OperationError = class
  {* Во время выполнения операции copy_to один из потоков, участвовавших в операции перешёл в некорректное состояние. }
 end;//OperationError

 NotImplemented = class
  {* функция не реализована }
 end;//NotImplemented

 IString = interface
  {* Интерфейс для работы со строками. Предпочтительно использовать именно этот тип для работы со всеми строковыми данными. }
  ['{952E8D0E-1685-49D2-BFDB-D854F4BF0156}']
  function GetLength: Cardinal; stdcall;
  function GetMaximum: Cardinal; stdcall;
  procedure SetMaximum(aValue: Cardinal); stdcall;
  function GetData: PAnsiChar; stdcall;
  function GetCodePage: short; stdcall;
  procedure SetCodePage(aValue: short); stdcall;
  procedure Reset(var str: PAnsiChar;
   maximum: Cardinal); overload; stdcall;
   {* Захватывает переданную строку. Если аргумент, задающий длину, меньше чем strlen(str) + 1, то длина строки принимается равной длине строки + 1. Память под передаваемый аргумент str ДОЛЖНА БЫТЬ ВЫДЕЛЕНА оператором new[], так как в деструкторе вызывается оператор delete[]. }
  procedure Reset(str: PAnsiChar); overload; stdcall;
   {* устанавливает значение строки равное переданному (переданная строка копируеться) }
  procedure Strdup(out aRet
   {* IString }); stdcall;
   {* возвращает бинарную копию строки }
  function Add(str: PAnsiChar): PAnsiChar; overload; stdcall;
   {* добавляет к строке переданную подстроку, возвращает указатель на свой буфер }
  function Add(const str: IString): PAnsiChar; overload; stdcall;
   {* добавляет к строке переданную подстроку, возвращает указатель на свой буфер }
  function Join(str: PAnsiChar): PAnsiChar; overload; stdcall;
   {* возвращает новую строку равную объединению текущей и переданной }
  function Join(const str: IString): PAnsiChar; overload; stdcall;
   {* возвращает новую строку равную объединению текущей и переданной }
  property Length: Cardinal
   read GetLength;
   {* длинна текстовой строки }
  property Maximum: Cardinal
   read GetMaximum
   write SetMaximum;
   {* размер аллоцированого буфера, для хранения текстовой строки }
  property Data: PAnsiChar
   read GetData;
   {* указатель на начало аллоцированного буфера (строки) }
  property CodePage: short
   read GetCodePage
   write SetCodePage;
   {* кодовая страница }
 end;//IString

 TStreamSeekDirection = (
  {* точка от которой считается смещение. Константы должны совпадать по значению с MSDN-овскими }
  SSD_BEGIN
   {* смещение относительно начала потока }
  , SSD_CURRENT
   {* смещение относительнотекущей позиции в потоке }
  , SSD_END
   {* смещение относительно конца потока }
 );//TStreamSeekDirection

 IStream = interface
  {* Интерфейс для работы с потоком }
  ['{D99F458B-CF9F-4286-AD02-59ABA1662465}']
  function Read(var buffer: pointer;
   size: Cardinal): Cardinal; stdcall; { can raise OperationError }
   {* Прочесть данные из потока, возвращает количество прочитанных байтов. }
  function Write(buffer: pointer;
   size: Cardinal): Cardinal; stdcall;
   {* Записать данные в поток. Возвращает количество записанных байтов. }
  function Seek(offset: Integer;
   whence: Cardinal): Cardinal; stdcall; { can raise OperationError, NotImplemented }
   {* Переместить маркер потока. Возвращает число байт от начала потока. }
  procedure CopyTo(var dst: IStream;
   size: Cardinal;
   out actually_read: unsigned long long;
   out actually_written: unsigned long long); stdcall; { can raise OperationError }
   {* Копирует данные из одного потока в другой. }
  function Eof: ByteBool; stdcall;
   {* Функция возвращает true если достигнут конец потока. }
  function Bad: ByteBool; stdcall;
   {* Если возвращается true, дальнейшая работа с потоком невозможна }
  procedure Clear; stdcall;
   {* Чистит флаги потока }
 end;//IStream

 TDateTimeBox = record
  {* для универсальной передачи времени между разными языками, платформами. }
  day: short;
   {* день в месяце (1-31) }
  mounth: short;
   {* месяц в году (1-12) }
  year: short;
   {* год }
  hour: short;
   {* час (0-23) }
  minute: short;
   {* минута в часе (0-59) }
  second: short;
   {* секунда в минуте (0-59) }
  millisecond: short;
   {* миллисекунды (0-999) }
 end;//TDateTimeBox

implementation

uses
 l3ImplUses
;

end.
