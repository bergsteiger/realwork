unit DefUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "MorphoAdapterLib"
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/MorphoAdapterLib/DefUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garantCore::MorphoAdapterLib::Def
//
// Интерфейсы и типы морфо-адаптера
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface



type

IMorphoAdapter = interface;
{ - предварительное описание IMorphoAdapter. }

IMlmaRu = interface;
{ - предварительное описание IMlmaRu. }

IMorphoManager = interface;
{ - предварительное описание IMorphoManager. }



// Адаптер для морфо-алгоритмов
IMorphoAdapter = interface (IInterface) ['{2261F9E6-0615-4910-8D58-098D1EA2CE2C}']
	function DontUseMe: Pointer;
	// нормализация
	function Normalize (
		const aWord: PAnsiChar;
		var aOut: PAnsiChar
	): Cardinal; stdcall;
end;

// API библиотеки mlma
IMlmaRu = interface (IInterface) ['{A835EF81-9A98-422C-9454-C4F9C14848F5}']
	function DontUseMe: Pointer;
	// mlmaruBuildForm
	function BuildForm (
		const aWord: PAnsiChar;
		aId: Longword;
		aOptions: Word;
		aForm: AnsiChar;
		var aRes: PAnsiChar;
		aLen: Word
	): Smallint; stdcall;

	// mlmaruBuildFormGI
	function BuildFormGi (
		const aWord: PAnsiChar;
		aLexId: Longword;
		aOptions: Word;
		aGrInfo: Word;
		aFlags: AnsiChar;
		var aDest: PAnsiChar;
		aCcDest: Word
	): Smallint; stdcall;

	// mlmaruCheckHelp
	function CheckHelp (
		const aWord: PAnsiChar;
		var aList: PAnsiChar
	): Smallint; stdcall;

	// mlmaruCheckWord
	function CheckWord (
		const aWord: PAnsiChar;
		aOptions: Word
	): Smallint; stdcall;

	// mlmaruLemmatize
	function Lemmatize (
		const aWord: PAnsiChar;
		aOptions: Word;
		var aLemm: PAnsiChar;
		var aLIDs: Pointer;
		var aGram: PAnsiChar;
		aNlemm: Word;
		aNLID: Word;
		aNgram: Word
	): Smallint; stdcall;
end;

// Интерфейс для инициализации/деинициализации морфологии
IMorphoManager = interface (IInterface) ['{4B31F9B1-ECFE-4C7F-B82A-0F93D4C488BE}']
	function DontUseMe: Pointer;
	// деинициализация
	procedure Done (); stdcall;

	// инициализация
	procedure Init (
		const aBasePath: PAnsiChar
	); stdcall;
end;

implementation
end.