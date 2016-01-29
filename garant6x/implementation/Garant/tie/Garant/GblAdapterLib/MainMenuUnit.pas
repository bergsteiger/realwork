unit MainMenuUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/MainMenuUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::MainMenu
//
// Основное меню
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit,
  DynamicTreeUnit
  ;

type
 TSectionType = (
  {* Тип секции ОМ }
   ST_FINANCE // Налоги и финансы
 , ST_HR // Раздел для кадровиков
 , ST_LEGAL // Раздел для юристов
 , ST_BUDGET_ORGS // Бюджетные организаций
 , ST_LAW_FOR_ALL // Право для всех
 , ST_BUSINESS_REFERENCES // Бизнес-справки
 , ST_CHANGES_IN_LEGISLATION // Изменения в законодательстве
 );//TSectionType

 ISectionItem = interface(IUnknown)
  {* Элемент раздела ОМ }
   ['{257ACC4A-9B2A-4AD1-B238-0CDCE6A5406E}']
   function GetCaption: IString; stdcall;
   procedure Open(out aRet {: IUnknown}); stdcall;
     {* Получить сущность элемента (может быть IQuery, IDocument, INodeBase, IString) }
   property caption: IString
     read GetCaption;
     {* Имя }
 end;//ISectionItem

 ISectionItemList = array of ISectionItem;

 ISection = interface(IUnknown)
   ['{BBB2D3C6-226C-4A9F-AAC6-32775E30B7C7}']
   function GetCaption: IString; stdcall;
   procedure GetItems(out aRet {: ISectionItemList}); stdcall;
     {* Получить элементы раздела ОМ }
   property caption: IString
     read GetCaption;
     {* имя }
 end;//ISection

 IMainMenu = interface(IUnknown)
  {* Основное меню }
   ['{7EAB7EE0-39FB-42FD-BE38-AF667AE0466E}']
   procedure GetBaseSearchPanes(out aRet {: INodeBase}); stdcall;
     {* Получить дерево вкладок Бзового поиска }
   procedure GetSection(aType: TSectionType; out aRet {: ISection}); stdcall;
     {* Получить дерево секции ОМ по типу }
 end;//IMainMenu

implementation

end.