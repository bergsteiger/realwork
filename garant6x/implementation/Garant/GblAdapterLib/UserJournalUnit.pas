unit UserJournalUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/UserJournalUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::UserJournal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	IOUnit
	, BaseTypesUnit
	, DocumentUnit
	, DynamicTreeUnit
	, SearchUnit
	//#UC START# *4423F94903C8_4A7FF5F301B2_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_4A7FF5F301B2_UNIT_FOR_Stream*
	;

type

IUserJournal = interface;
{ - предварительное описание IUserJournal. }


// Типы элементов Журнала работы
PJournalObjectType = ^TJournalObjectType;
TJournalObjectType = (
	JOT_BOOKMARK // Закладка
	, JOT_QUERY // Запрос
	, JOT_FOLDER // Папка
);

PBookmarkJournalType = ^TBookmarkJournalType;
TBookmarkJournalType = (
	BJT_BOOKMARK // Закладки
	, BJT_PHARM_BOOKMARK // Закладки Инфарма
);

// Интерфейс журанла работы
IUserJournal = interface (IInterface) ['{30769E5F-13F7-406E-8E2A-2D35B8BE5192}']
	function DontUseMe: Pointer;
	// Очистить Журнал работы (аналогичен вызову remove (рут дерева журнала работы)
	procedure Clear (); stdcall;

	// список закладок заданного типа
	procedure GetBookmarkHistory (
		aType: TBookmarkJournalType;
		aMaxCount: Longint;
		out aRet {: IJournalBookmarkList}
	); stdcall; // can raise ECanNotFindData

	// Получит список запросов заданного типа из Журнала
	procedure GetQueryHistory (
		aQueryType: TQueryType;
		aMaxCount: Longint;
		out aRet {: IQueryList}
	); stdcall; // can raise ECanNotFindData

	// Получить дерево Журнала работы
	procedure GetUserJornalTree (
		out aRet {: INodeBase}
	); stdcall;

	// Удалить объект из журнала работы
	procedure Remove (
		const aObj: INodeBase
	); stdcall;

	// Сохранить объект в журнал работы
	procedure Save (
		const aObj: IUnknown;
		aObjectType: TJournalObjectType
	); stdcall;
end;

implementation
end.