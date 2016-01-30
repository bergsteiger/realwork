unit IOUnit;
 {* пакет интерфейсов ввода-вывода }

// Модуль: "w:\shared\tie\Garant\GCI\IOUnit.pas"
// Стереотип: "Interfaces"

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
  function Get_length: Cardinal;
  function Get_maximum: Cardinal;
  procedure Set_maximum(aValue: Cardinal);
  function Get_data: PAnsiChar;
  function Get_code_page: short;
  procedure Set_code_page(aValue: short);
  procedure reset(var str: PAnsiChar;
   maximum: Cardinal); overload;
   {* Захватывает переданную строку. Если аргумент, задающий длину, меньше чем strlen(str) + 1, то длина строки принимается равной длине строки + 1. Память под передаваемый аргумент str ДОЛЖНА БЫТЬ ВЫДЕЛЕНА оператором new[], так как в деструкторе вызывается оператор delete[]. }
  procedure reset(str: PAnsiChar); overload;
   {* устанавливает значение строки равное переданному (переданная строка копируеться) }
  function strdup: IString;
   {* возвращает бинарную копию строки }
  function add(str: PAnsiChar): PAnsiChar; overload;
   {* добавляет к строке переданную подстроку, возвращает указатель на свой буфер }
  function add(const str: IString): PAnsiChar; overload;
   {* добавляет к строке переданную подстроку, возвращает указатель на свой буфер }
  function join(str: PAnsiChar): PAnsiChar; overload;
   {* возвращает новую строку равную объединению текущей и переданной }
  function join(const str: IString): PAnsiChar; overload;
   {* возвращает новую строку равную объединению текущей и переданной }
  property length: Cardinal
   read Get_length;
   {* длинна текстовой строки }
  property maximum: Cardinal
   read Get_maximum
   write Set_maximum;
   {* размер аллоцированого буфера, для хранения текстовой строки }
  property data: PAnsiChar
   read Get_data;
   {* указатель на начало аллоцированного буфера (строки) }
  property code_page: short
   read Get_code_page
   write Set_code_page;
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
  function read(var buffer: pointer;
   size: Cardinal): Cardinal; { can raise OperationError }
   {* Прочесть данные из потока, возвращает количество прочитанных байтов. }
  function write(buffer: pointer;
   size: Cardinal): Cardinal;
   {* Записать данные в поток. Возвращает количество записанных байтов. }
  function seek(offset: Integer;
   whence: Cardinal): Cardinal; { can raise OperationError, NotImplemented }
   {* Переместить маркер потока. Возвращает число байт от начала потока. }
  procedure copy_to(var dst: IStream;
   size: Cardinal;
   out actually_read: unsigned long long;
   out actually_written: unsigned long long); { can raise OperationError }
   {* Копирует данные из одного потока в другой. }
  function eof: Boolean;
   {* Функция возвращает true если достигнут конец потока. }
  function bad: Boolean;
   {* Если возвращается true, дальнейшая работа с потоком невозможна }
  procedure clear;
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

class function make(str: PAnsiChar): BadFactoryType;
 {* фабрика, копирует строку }
class function create(str: PAnsiChar;
 code_page: short): BadFactoryType;
 {* фабрика, копирует строку }
class function take(var str: PAnsiChar;
 code_page: short): BadFactoryType;
 {* Захватывает переданную строку. Память под передаваемый аргумент str ДОЛЖНА БЫТЬ ВЫДЕЛЕНА оператором new[], так как в деструкторе вызывается оператор delete[]. }
class function alloc(maximum: Cardinal): BadFactoryType;
 {* создает пустую строку, с преалоцированным буфером указанного размера }
class function make: BadFactoryType; overload;
 {* Создает пустой поток }
class function make(path: PAnsiChar): BadFactoryType; overload;
 {* Создает поток связанный с файлом }

implementation

uses
 l3ImplUses
;

class function make(str: PAnsiChar): BadFactoryType;
 {* фабрика, копирует строку }
var
 l_Inst : IString;
begin
 l_Inst := Create(str);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function create(str: PAnsiChar;
 code_page: short): BadFactoryType;
 {* фабрика, копирует строку }
var
 l_Inst : IString;
begin
 l_Inst := Create(str, code_page);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//create

class function take(var str: PAnsiChar;
 code_page: short): BadFactoryType;
 {* Захватывает переданную строку. Память под передаваемый аргумент str ДОЛЖНА БЫТЬ ВЫДЕЛЕНА оператором new[], так как в деструкторе вызывается оператор delete[]. }
var
 l_Inst : IString;
begin
 l_Inst := Create(str, code_page);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//take

class function alloc(maximum: Cardinal): BadFactoryType;
 {* создает пустую строку, с преалоцированным буфером указанного размера }
var
 l_Inst : IString;
begin
 l_Inst := Create(maximum);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//alloc

class function make: BadFactoryType;
 {* Создает пустой поток }
var
 l_Inst : IStream;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(path: PAnsiChar): BadFactoryType;
 {* Создает поток связанный с файлом }
var
 l_Inst : IStream;
begin
 l_Inst := Create(path);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
