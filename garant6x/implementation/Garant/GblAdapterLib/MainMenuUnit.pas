unit MainMenuUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/MainMenuUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::MainMenu
//
// Основное меню
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	IOUnit
	, BaseTypesUnit
	, DynamicTreeUnit
	, BannerUnit
	//#UC START# *4423F94903C8_4DD24BD40021_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_4DD24BD40021_UNIT_FOR_Stream*
	;

type

ISectionItem = interface;
{ - предварительное описание ISectionItem. }

ISectionItemList = interface;
{ - предварительное описание ISectionItemList. }

ISection = interface;
{ - предварительное описание ISection. }

IMainMenuSection = interface;
{ - предварительное описание IMainMenuSection. }

IMainMenuSectionList = interface;
{ - предварительное описание IMainMenuSectionList. }

IMainMenu = interface;
{ - предварительное описание IMainMenu. }


// Тип секции ОМ
PSectionType = ^TSectionType;
TSectionType = (
	ST_FINANCE // Налоги и финансы
	, ST_HR // Раздел для кадровиков
	, ST_LEGAL // Раздел для юристов
	, ST_BUDGET_ORGS // Бюджетные организаций
	, ST_GOS_ZAKUPKI // Госзакупки
	, ST_LAW_FOR_ALL // Право для всех
	, ST_BUSINESS_REFERENCES // Бизнес-справки
	, ST_CHANGES_IN_LEGISLATION // Изменения в законодательстве
);

// Элемент раздела ОМ
ISectionItem = interface (IInterface) ['{257ACC4A-9B2A-4AD1-B238-0CDCE6A5406E}']
	function DontUseMe: Pointer;
	// Имя
	procedure GetCaption (out aRet {: IString}); stdcall;

	// Получить сущность элемента (может быть IQuery, IDocument, INodeBase, IString, IBookmark)
	procedure Open (
		out aRet {: IUnknown}
	); stdcall;
end;

ISectionItemList = interface(IInterface)
['{F4314383-3A43-4E2F-908F-257AE0A67C62}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: ISectionItem); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: ISectionItem); stdcall;
      {-}
  // public methods
    function  Add(const anItem: ISectionItem): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: ISectionItem); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//ISectionItemList

ISection = interface (IInterface) ['{BBB2D3C6-226C-4A9F-AAC6-32775E30B7C7}']
	function DontUseMe: Pointer;
	// имя
	procedure GetCaption (out aRet {: IString}); stdcall;

	// Получить элементы раздела ОМ
	procedure GetItems (
		out aRet {: ISectionItemList}
	); stdcall;
end;

IMainMenuSection = interface (IInterface) ['{9B596AAB-BF7B-41A0-978D-3FAD93DC180C}']
	function DontUseMe: Pointer;
	// имя
	procedure GetCaption (out aRet {: IString}); stdcall;

	procedure GetBanner (
		out aRet {: IBanner}
	); stdcall;

	// Получить элементы раздела ОМ
	procedure GetItems (
		out aRet {: ISectionItemList}
	); stdcall;

	// получить для проф. секции индекс в новостной секции
	function GetNewsSectionIndex (): Longint; stdcall;
end;

IMainMenuSectionList = interface(IInterface)
['{13190B9C-78CA-4B8A-8562-7A83F2BD4EC0}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: IMainMenuSection); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IMainMenuSection); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IMainMenuSection): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: IMainMenuSection); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IMainMenuSectionList

// Основное меню
IMainMenu = interface (IInterface) ['{7EAB7EE0-39FB-42FD-BE38-AF667AE0466E}']
	function DontUseMe: Pointer;
	// Получить дерево вкладок Бзового поиска
	procedure GetBaseSearchPanes (
		out aRet {: INodeBase}
	); stdcall;

	// раздел бизнес-справки
	procedure GetBusinessReferenceSection (
		out aRet {: IMainMenuSection}
	); stdcall;

	// раздел изменения в  законодательстве
	procedure GetChangesInLegislationSection (
		out aRet {: IMainMenuSection}
	); stdcall;

	// список новостных секций ОМ
	procedure GetNewsSectionList (
		out aRet {: IMainMenuSectionList}
	); stdcall;

	// список секций проф. меню
	procedure GetProfessionSectionList (
		out aRet {: IMainMenuSectionList}
	); stdcall;

	// Получить дерево секции ОМ по типу
	procedure GetSection (
		aType: TSectionType;
		out aRet {: ISection}
	); stdcall;
end;

implementation
end.