unit DynamicDocListUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DynamicDocListUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DynamicDocList
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
	, FiltersUnit
	, DynamicTreeDefinesUnit
	, SearchProgressIndicatorUnit
	//#UC START# *4423F94903C8_45700BFD0251_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_45700BFD0251_UNIT_FOR_Stream*
	;

type

ISortTypes = interface;
{ - предварительное описание ISortTypes. }

IListEntryInfo = interface;
{ - предварительное описание IListEntryInfo. }

IDynList = interface;
{ - предварительное описание IDynList. }

ISearchDynList = interface;
{ - предварительное описание ISearchDynList. }

IDocListFactory = interface;
{ - предварительное описание IDocListFactory. }

IDynListNode = interface;
{ - предварительное описание IDynListNode. }


PDynListType = ^TDynListType;
TDynListType = (
	T_RESPONDENT
	, T_CORRESPONDENT
	, T_RESPONDENT_TO_PART
	, T_CORRESPONDENT_TO_PART
	, T_SAME_DOCUMENTS // Похожие документы
);

// задаёт вид списка
PDynListContent = ^TDynListContent;
TDynListContent = (
	DLC_LEGAL_DOCUMENTS // юридические документы
	, DLC_MEDICAL_DOCUMENTS // документы инфарма
);

PSpecialListKey = ^TSpecialListKey;
TSpecialListKey = (
	SLK_ALL_ALLOWED_DRUGS // Все неаннулированные препараты
);

PDynListFlags = ^TDynListFlags;
TDynListFlags = (
	DLF_ANALYSIS_NODE_HAS_DATA // может быть построен список
	, DLF_ANALYSIS_NODE_EMPTY
);

ISortTypes = interface(IInterface)
['{A4E750C6-5513-44B2-ABE0-67CC2D4C503E}']
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
    function  pm_GetItem(anIndex: Integer): TSortType; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TSortType); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TSortType): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TSortType); stdcall;
      {* - вставляет элемент Item по индексу Index. }
  // public properties
    property  Items[anIndex: Integer]: TSortType
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - элементы списка. }
end;//ISortTypes

IListEntryInfo = interface (IEntityBase) ['{5B3CE8D5-3CB9-4EA6-B3AC-37EADA8FDF9C}']
	procedure GetDoc (out aRet {: IDocument}); stdcall;

	procedure GetPid (out a: TPId); stdcall;

	function GetPosition (): Longword; stdcall;

	// Релевантность. Для списков без релевантности всегда 0.
	function GetRelevance (): Smallint; stdcall;

	function GetType (): TPositionType; stdcall;
end;

IDynList = interface (ICatalogBase) ['{00B91ACF-6CDD-437F-935A-07287C0E2DF0}']
	procedure AsEvd (
		aStyle: TEVDGeneratorStyle;
		out aRet {: IStream}
	); stdcall;

	procedure GetAvailableSortTypes (out aRet {: ISortTypes}); stdcall;

	function GetContentType (): TDynListContent; stdcall;

	procedure GetCurrentSortParams (out a: TSortParams); stdcall;

	// получить дерево анализа для списка
	procedure GetAnalysisTree (
		out aRet {: INodeBase}
	); stdcall; // can raise ECanNotFindData

	// Получить полный список
	procedure GetFullList (
		const aProgress: IProgressIndicatorForSearch;
		out aCancelProcess {: ICancelSearch}
	); stdcall; // can raise ECanNotFindData

	// Получить длину полного для базового списка
	function GetFullListSize (): Longword; stdcall;

	// получить "короткое" имя списка, используется при выводе на печать
	procedure GetShortName (
		out aRet {: IString}
	); stdcall;

	procedure GetHistory (out aRet {: IString}); stdcall;

	function GetIsFiltered (): Bytebool; stdcall;

	// Это короткий список (сниппеты)
	function GetIsShort (): Bytebool; stdcall;

	// Признак, является ли список сниппетом
	function GetIsSnippet (): Bytebool; stdcall;

	// Сохранить список или его выделенные элементы в файл.
	procedure SaveToFile (
		const aPath: PAnsiChar;
		const aNodes: INodesClipboard
	); stdcall;

	procedure SetContextFilter (
		const aContext: IContextFilter
	); stdcall;

	procedure Sort (
		const aParams: TSortParams
	); stdcall;
end;

// Список - результат поиска
ISearchDynList = interface (ISearchEntity) ['{DB91FE90-832B-4753-9222-4313AB5CA667}']
	procedure GetDynList (
		out aRet {: IDynList}
	); stdcall;
end;

// фабрика для создания списков
IDocListFactory = interface (IInterface) ['{C894D5B5-37CF-4463-A426-E30550F408F8}']
	function DontUseMe: Pointer;
	// построить список по данным из файла file_name.
	// inner_numbers - флаг указывающий какие номера документов используются (если inner_numbers=true
	// - внутренние)
	// 
	// Формат файла (К195757811):
	// <номер топика>{.<номер саба/блока>}{<пробел или табуляция><любые символы>}
	// <номер топика>{.<номер саба/блока>}{<пробел или табуляция><любые символы>}
	// <номер топика>{.<номер саба/блока>}{<пробел или табуляция><любые символы>}
	// ...
	// 
	// Исключения:
	// AccessDenied - не смогли прочитать данные из файла
	// InvalidType - в файле некорректные данные
	procedure MakeList (
		const aFileName: PAnsiChar;
		aInnerNumbers: Bytebool;
		out aRet {: IDynList}
	); stdcall; // can raise EAccessDenied, EInvalidType
end;

IDynListNode = interface (IInterface) ['{FAE957F6-A5EA-4AB6-9EC2-8514B696A1C1}']
	function DontUseMe: Pointer;
	// Получить идентифкатор документа из ноды списка
	function GetDocumentId (): TObjectId; stdcall;

	procedure GetSnippetText (
		out aRet {: IString}
	); stdcall;
end;

implementation
end.