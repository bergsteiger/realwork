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
 , BaseTypesUnit
 , DynamicTreeUnit
 , BannerUnit
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
  procedure GetCaption; stdcall;
  procedure Open(out aRet
   {* IUnknown }); stdcall;
   {* Получить сущность элемента (может быть IQuery, IDocument, INodeBase, IString, IBookmark) }
  property Caption: 
   read GetCaption;
   {* Имя }
 end;//ISectionItem

 ISectionItemList = array of ISectionItem;

 ISection = interface
  ['{BBB2D3C6-226C-4A9F-AAC6-32775E30B7C7}']
  procedure GetCaption; stdcall;
  procedure GetItems(out aRet
   {* ISectionItemList }); stdcall;
   {* Получить элементы раздела ОМ }
  property Caption: 
   read GetCaption;
   {* имя }
 end;//ISection

 IMainMenuSection = interface
  ['{9B596AAB-BF7B-41A0-978D-3FAD93DC180C}']
  procedure GetCaption; stdcall;
  procedure GetItems(out aRet
   {* ISectionItemList }); stdcall;
   {* Получить элементы раздела ОМ }
  function GetNewsSectionIndex: Integer; stdcall;
   {* получить для проф. секции индекс в новостной секции }
  procedure GetBanner(out aRet
   {* IBanner }); stdcall;
  property Caption: 
   read GetCaption;
   {* имя }
 end;//IMainMenuSection

 IMainMenuSectionList = array of IMainMenuSection;

 IMainMenu = interface
  {* Основное меню }
  ['{7EAB7EE0-39FB-42FD-BE38-AF667AE0466E}']
  procedure GetBaseSearchPanes(out aRet
   {* INodeBase }); stdcall;
   {* Получить дерево вкладок Бзового поиска }
  procedure GetSection(type: TSectionType;
   out aRet
   {* ISection }); stdcall;
   {* Получить дерево секции ОМ по типу }
  procedure GetProfessionSectionList(out aRet
   {* IMainMenuSectionList }); stdcall;
   {* список секций проф. меню }
  procedure GetNewsSectionList(out aRet
   {* IMainMenuSectionList }); stdcall;
   {* список новостных секций ОМ }
  procedure GetBusinessReferenceSection(out aRet
   {* IMainMenuSection }); stdcall;
   {* раздел бизнес-справки }
  procedure GetChangesInLegislationSection(out aRet
   {* IMainMenuSection }); stdcall;
   {* раздел изменения в  законодательстве }
 end;//IMainMenu

implementation

uses
 l3ImplUses
;

end.
