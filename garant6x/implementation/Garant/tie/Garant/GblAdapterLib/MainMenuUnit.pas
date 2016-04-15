unit MainMenuUnit;
 {* Основное меню }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\MainMenuUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "MainMenu" MUID: (4DD24BD40021)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , DynamicTreeUnit
;

type
 TSectionType = (
  {* Тип секции ОМ }
  ST_FINANCE
   {* Налоги и финансы }
  , ST_HR
   {* Раздел для кадровиков }
  , ST_LEGAL
   {* Раздел для юристов }
  , ST_BUDGET_ORGS
   {* Бюджетные организаций }
  , ST_GOS_ZAKUPKI
   {* Госзакупки }
  , ST_LAW_FOR_ALL
   {* Право для всех }
  , ST_BUSINESS_REFERENCES
   {* Бизнес-справки }
  , ST_CHANGES_IN_LEGISLATION
   {* Изменения в законодательстве }
 );//TSectionType

 ISectionItem = interface
  {* Элемент раздела ОМ }
  ['{257ACC4A-9B2A-4AD1-B238-0CDCE6A5406E}']
  function GetCaption: IString; stdcall;
  function Open: IUnknown; stdcall;
   {* Получить сущность элемента (может быть IQuery, IDocument, INodeBase, IString, IBookmark) }
  property Caption: IString
   read GetCaption;
   {* Имя }
 end;//ISectionItem

 ISectionItemList = array of ISectionItem;

 ISection = interface
  ['{BBB2D3C6-226C-4A9F-AAC6-32775E30B7C7}']
  function GetCaption: IString; stdcall;
  function GetItems: ISectionItemList; stdcall;
   {* Получить элементы раздела ОМ }
  property Caption: IString
   read GetCaption;
   {* имя }
 end;//ISection

 IMainMenuSection = interface
  ['{9B596AAB-BF7B-41A0-978D-3FAD93DC180C}']
  function GetCaption: IString; stdcall;
  function GetItems: ISectionItemList; stdcall;
   {* Получить элементы раздела ОМ }
  function GetNewsSectionIndex: Integer; stdcall;
   {* получить для проф. секции индекс в новостной секции }
  property Caption: IString
   read GetCaption;
   {* имя }
 end;//IMainMenuSection

 IMainMenuSectionList = array of IMainMenuSection;

 IMainMenu = interface
  {* Основное меню }
  ['{7EAB7EE0-39FB-42FD-BE38-AF667AE0466E}']
  function GetBaseSearchPanes: INodeBase; stdcall;
   {* Получить дерево вкладок Бзового поиска }
  function GetSection(type: TSectionType): ISection; stdcall;
   {* Получить дерево секции ОМ по типу }
  function GetProfessionSectionList: IMainMenuSectionList; stdcall;
   {* список секций проф. меню }
  function GetNewsSectionList: IMainMenuSectionList; stdcall;
   {* список новостных секций ОМ }
  function GetBusinessReferenceSection: IMainMenuSection; stdcall;
   {* раздел бизнес-справки }
  function GetChangesInLegislationSection: IMainMenuSection; stdcall;
   {* раздел изменения в  законодательстве }
  procedure Customize; stdcall;
   {* настройка основного меню в зависимости от дополнительных параметров
 желательно сделать сразу после логина и до загрузки кеша настроек }
 end;//IMainMenu

implementation

uses
 l3ImplUses
;

end.
