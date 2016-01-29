unit FiltersUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/FiltersUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Filters
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	, IOUnit
	, BaseTypesUnit
	, BaseTreeSupportUnit
	//#UC START# *4423F94903C8_45EEA48F011F_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_45EEA48F011F_UNIT_FOR_Stream*
	;

type

IFilterFromQuery = interface;
{ - предварительное описание IFilterFromQuery. }

IFiltersFromQuery = interface;
{ - предварительное описание IFiltersFromQuery. }

IFiltersManager = interface;
{ - предварительное описание IFiltersManager. }


// Не все атрибуты поискового запроса восстановлны из базы
ENotAllAttributesRestored = class (Exception);

// Интерфейс фильтруемости. Должен поддерживаться объектами, желающими предоставлять сервис
// фильтров. Сейчас используется для списков.
IFilterable = interface (IInterface) ['{4C08EC41-3957-462B-B9C1-FB91B86469BA}']
	function DontUseMe: Pointer;
	procedure GetActiveFilters (out aRet {: IFiltersFromQuery}); stdcall;

	// Добавляет INode (из дерева папок) как фильтр.
	// Если auto_refresh = true (значение по умолчанию), то
	// операция приводит к перефильтрации объекта.
	procedure AddFilter (
		const aFilter: IFilterFromQuery;
		aAutoRefresh: Bytebool
	); stdcall; // can raise EAllContentIsFiltered, ENotAllAttributesRestored

	// Добавляет пачку фильтров с одновременным их применением. При этом эта пачка либо целиком
	// применяется, либо (в случае, если все документы отфильтрованы) целиком отклоняется.
	// 
	// Если выясняется, что на сервере нет данных для построения списка, т.е. списка как такового нет
	// (см. К244711732), летит CanNotFindData.
	procedure ApplyFilters (
		const aFilters: IFiltersFromQuery
	); stdcall; // can raise ECanNotFindData, EAllContentIsFiltered

	// Удаляет все фильтры. В результате операции объект переходит в состояние, соответвующее
	// отсутствию фильтров
	procedure ClearFilters (); stdcall; // can raise ECanNotFindData

	// Удаляет фильтр из списка активных фильтров объекта. Если auto_refresh = true (значение по
	// умолчанию), то операция приводит к перефильтрации объекта.
	procedure DeleteFilter (
		const aFilter: IFilterFromQuery;
		aAutoRefresh: Bytebool
	); stdcall; // can raise ECanNotFindData, EAllContentIsFiltered

	function GetHasActiveFilters (): Bytebool; stdcall;

	procedure RefreshFilters (); stdcall; // can raise ECanNotFindData, EAllContentIsFiltered
end;

IFilterNotifier = interface (IInterface) ['{F41C0D69-A5BC-4836-9F33-85807FCAC1A7}']
	procedure FilterNameChanged (); stdcall;

	procedure FilterPermanenceChanged (); stdcall;

	procedure FiltersChanged (); stdcall;
end;

IFilterFromQuery = interface (IInterface) ['{A81EFF04-FAB6-4D1B-846B-66C301594470}']
	function DontUseMe: Pointer;
	function GetChangeable (): Bytebool; stdcall;

	// идентификатор нужен оболочке, чтобы идентифицировать установленные фильтры (К274848126)
	function GetId (): Longword; stdcall;

	// возвращает true, если оригинальный и переданный фильтры совпадают
	function IsSame (
		const aOther: IFilterFromQuery
	): Bytebool; stdcall;

	// наложен ли фильтр
	function IsUsed (): Bytebool; stdcall;

	// удалить фильтр после того, как он перестанет использоваться
	procedure MarkToErase (); stdcall;

	function MarkedToErase (): Bytebool; stdcall;

	procedure GetName (out aRet {: IString}); stdcall;
	procedure SetName (const aName: IString); stdcall;

	function GetPermanent (): Bytebool; stdcall;
	procedure SetPermanent (aPermanent: Bytebool); stdcall;

	// если делать query Search::Query, каковым он и является, на модели получается дофига циклических
	// связей, которые небыстро будет развязать
	procedure GetQuery (out aRet {: IEntityBase}); stdcall;
end;

IFiltersFromQuery = interface(IInterface)
['{85F5B5FA-3FFE-470E-9F0B-157765264E5D}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - методы для доступа к свойству Count. }
    procedure Clear; stdcall;
      {* очистить список. }
    procedure Delete(anIndex: Integer); stdcall;
      {* удаляет элемент по индексу Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* число элементов в хранилище. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: IFilterFromQuery); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IFilterFromQuery); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IFilterFromQuery): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: IFilterFromQuery); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IFiltersFromQuery

IFiltersManager = interface (IInterface) ['{854B1550-A048-4551-AB1C-6FD08FDAF723}']
	function DontUseMe: Pointer;
	// создать новый фильтр
	procedure CreateFilter (
		const aQuery: IEntityBase;
		const aName: IString
	); stdcall;

	// получить список фильтров для правовых документов
	procedure GetLegalFilters (
		out aRet {: IFiltersFromQuery}
	); stdcall;

	procedure GetPharmFilters (
		out aRet {: IFiltersFromQuery}
	); stdcall;

	procedure SetLegalNotifier (
		const aNotifier: IFilterNotifier
	); stdcall;

	procedure SetPharmNotifier (
		const aNotifier: IFilterNotifier
	); stdcall;
end;

implementation
end.