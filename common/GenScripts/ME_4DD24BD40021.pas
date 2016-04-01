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
   {* Получить сущность элемента (может быть IQuery, IDocument, INodeBase, IString) }
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

 IMainMenu = interface
  {* Основное меню }
  ['{7EAB7EE0-39FB-42FD-BE38-AF667AE0466E}']
  function GetBaseSearchPanes: INodeBase; stdcall;
   {* Получить дерево вкладок Бзового поиска }
  function GetSection(type: TSectionType): ISection; stdcall;
   {* Получить дерево секции ОМ по типу }
  function GetProfessionalSection(index: Cardinal): ISection; stdcall;
   {* получить секцию меню для профессии }
  function GetProfessionalSectionCount: Cardinal; stdcall;
   {* количество проф. секций в меню }
  function GetNewsSection(index: Cardinal): ISection; stdcall;
   {* получить раздел новостей для профессии }
  function GetNewsSectionCount: Cardinal; stdcall;
   {* количество новостных секций по профессиям }
 end;//IMainMenu

implementation

uses
 l3ImplUses
;

end.
