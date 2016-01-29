unit l3CustomString;

interface

uses
 l3IntfUses
 , l3Variant
 , l3Types
 , l3Interfaces
 , l3IID
 , Classes
;

type
 Tl3CustomString = class(Tl3PrimString)
  {* Базовый класс для "строк". Определяет операции и свойства, но не способ хранения данных. }
  function Offset(Delta: Integer): Tl3CustomString;
  procedure DoSetCodePage(aValue: Integer);
  procedure CheckUnicode;
  function AssignSt(aSt: PAnsiChar;
   O1: Integer;
   O2: Integer;
   aCodePage: Integer): Tl3CustomString;
  procedure LPad(aCh: AnsiChar;
   aCodePage: Integer;
   aRepeat: Integer);
   {* добавляет к строке слева символ aCh aRepeat раз }
  procedure Append(const aSt: Tl3WString;
   aRepeat: Integer); overload;
   {* добавляет строку aSt к данной строке aRepeat раз }
  procedure Append(const aCh: Tl3Char;
   aRepeat: Integer); overload;
   {* добавляет символ aCh к данной строке aRepeat раз }
  procedure Append(aCh: AnsiChar;
   aRepeat: Integer;
   aCodePage: Integer); overload;
   {* добавляет символ aCh к данной строке aRepeat раз }
  procedure Insert(const aSt: Tl3WString;
   aPos: Integer;
   aRepeat: Integer); overload;
   {* вставляет строку aSt в позицию aPos, aRepeat раз }
  procedure Insert(aCh: AnsiChar;
   aPos: Integer;
   aRepeat: Integer); overload;
   {* вставляет символ aCh в позицию aPos, aRepeat раз }
  procedure Insert(S: Tl3CustomString;
   aPos: Integer;
   aRepeat: Integer); overload;
   {* вставляет строку S в позицию aPos, aRepeat раз }
  function Trim: Tl3CustomString;
   {* удаляет конечные и начальные пробелы }
  function TrimAll: Tl3CustomString;
   {* удаляет конечные, начальные и дублирующиеся пробелы }
  procedure LTrim;
   {* удаляет из строки ведущие пробелы }
  function RTrim: Tl3CustomString;
   {* удаляет из строки конечные пробелы }
  procedure TrimEOL;
   {* удаляет из строки конечные cc_SoftEnter и cc_HardEnter }
  function DeleteDoubleSpace: Tl3CustomString;
   {* удаляет из строки дублирующиеся пробелы }
  function DeleteAllChars(aChar: AnsiChar): Integer;
   {* удаляет из строки все символы aChar и возвращает количество удаленных }
  function ReplaceNonReadable: Tl3CustomString;
   {* заменяет "нечитаемые" символы пробелами }
  function FindChar(Pos: Integer;
   C: AnsiChar): Integer;
   {* ищет символ в строке с позиции Pos и возвращает позицию найденного символа или -1 }
  procedure FindCharEx(C: AnsiChar;
   aSt: Tl3CustomString);
  function Indent: Integer;
  procedure MakeBMTable(var BT: Tl3BMTable);
   {* создает таблицу Boyer-Moore для строки }
  function BMSearch(S: Tl3CustomString;
   BT: Tl3BMTable;
   var Pos: Cardinal): Boolean;
   {* ищет данную строку в строке S с учетом регистра }
  function BMSearchUC(S: Tl3CustomString;
   BT: Tl3BMTable;
   var Pos: Cardinal): Boolean;
   {* ищет данную строку в строке S без учета регистра
ВНИМАНИЕ! Для успешного поиска без учёта регистра подстрока (S) должна быть в ВЕРХНЕМ РЕГИСТРЕ!
И таблица (BT) должна быть построена для этой строки в верхнем регистре! }
  procedure MakeUpper;
   {* преобразует строку к верхнему регистру }
  procedure MakeLower;
   {* преобразует строку к нижнему регистру }
  function Delete(aPos: Integer;
   aCount: Integer): PAnsiChar;
   {* удаляет aCount символов с позиции aPos }
  procedure SetSt(aStr: PAnsiChar;
   aLen: Integer);
   {* присваивает новое значение строке, считая, что aStr имеет ту же кодировку, что и строка }
  function JoinWith(P: Tl3PrimString): Integer;
   {* операция объединения двух объектов }
  procedure l3SayConstString;
 end;//Tl3CustomString
 
implementation

uses
 l3ImplUses
 , l3BMSearch
 , SysUtils
 , l3Base
 , l3String
 , l3StringEx
 , l3Memory
 , l3StringAdapter
 , l3Chars
;

end.
