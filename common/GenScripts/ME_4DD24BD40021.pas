unit MainMenuUnit;
 {* Основное меню }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\MainMenuUnit.pas"
// Стереотип: "Interfaces"

{$Include nsDefine.inc}

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
  function Get_caption: IString;
  function open: IUnknown;
   {* Получить сущность элемента (может быть IQuery, IDocument, INodeBase, IString) }
  property caption: IString
   read Get_caption;
   {* Имя }
 end;//ISectionItem

 ISectionItemList = array of ISectionItem;

 ISection = interface
  ['{BBB2D3C6-226C-4A9F-AAC6-32775E30B7C7}']
  function Get_caption: IString;
  class function make: BadFactoryType;
  function get_items: ISectionItemList;
   {* Получить элементы раздела ОМ }
  property caption: IString
   read Get_caption;
   {* имя }
 end;//ISection

 IMainMenu = interface
  {* Основное меню }
  ['{7EAB7EE0-39FB-42FD-BE38-AF667AE0466E}']
  function get_base_search_panes: INodeBase;
   {* Получить дерево вкладок Бзового поиска }
  function get_section(type: TSectionType): ISection;
   {* Получить дерево секции ОМ по типу }
 end;//IMainMenu

class function make(section_item): BadFactoryType;
class function make: BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make(section_item): BadFactoryType;
var
 l_Inst : ISectionItem;
begin
 l_Inst := Create(section_item);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IMainMenu;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
