unit IOUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GCI"
// Модуль: "w:/shared/GCI/IOUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::IO
//
// пакет интерфейсов ввода-вывода
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	;

type

IString = interface;
{ - предварительное описание IString. }


// Во время выполнения операции copy_to один из потоков, участвовавших в операции перешёл в
// некорректное состояние.
EOperationError = class (Exception);

// функция не реализована
ENotImplemented = class (Exception);

// точка от которой считается смещение. Константы должны совпадать по значению с MSDN-овскими
PStreamSeekDirection = ^TStreamSeekDirection;
TStreamSeekDirection = (
	SSD_BEGIN // смещение относительно начала потока
	, SSD_CURRENT // смещение относительнотекущей позиции в потоке
	, SSD_END // смещение относительно конца потока
);

// для универсальной передачи времени между разными языками, платформами.
PDateTimeBox = ^TDateTimeBox;
TDateTimeBox = packed record
	rDay: Smallint; // день в месяце (1-31)
	rMounth: Smallint; // месяц в году (1-12)
	rYear: Smallint; // год
	rHour: Smallint; // час (0-23)
	rMinute: Smallint; // минута в часе (0-59)
	rSecond: Smallint; // секунда в минуте (0-59)
	rMillisecond: Smallint; // миллисекунды (0-999)
end;

// Интерфейс для работы со строками. Предпочтительно использовать именно этот тип для работы со
// всеми строковыми данными.
IString = interface (IInterface) ['{952E8D0E-1685-49D2-BFDB-D854F4BF0156}']
	function DontUseMe: Pointer;
	// добавляет к строке переданную подстроку, возвращает указатель на свой буфер
	function Add (
		const aStr: PAnsiChar
	): PAnsiChar; overload; stdcall;

	// добавляет к строке переданную подстроку, возвращает указатель на свой буфер
	function Add (
		const aStr: IString
	): PAnsiChar; overload; stdcall;

	// кодовая страница
	function GetCodePage (): Smallint; stdcall;
	procedure SetCodePage (aCodePage: Smallint); stdcall;

	// указатель на начало аллоцированного буфера (строки)
	function GetData (): PAnsiChar; stdcall;

	// длинна текстовой строки
	function GetLength (): Longword; stdcall;

	// размер аллоцированого буфера, для хранения текстовой строки
	function GetMaximum (): Longword; stdcall;
	procedure SetMaximum (aMaximum: Longword); stdcall;

	// устанавливает значение строки равное переданному (переданная строка копируеться)
	procedure Reset (
		const aStr: PAnsiChar
	); overload; stdcall;

	// возвращает бинарную копию строки
	procedure Strdup (
		out aRet {: IString}
	); stdcall;
end;

// Интерфейс для работы с потоком
// Stream - must be native for DLL outside


implementation
end.