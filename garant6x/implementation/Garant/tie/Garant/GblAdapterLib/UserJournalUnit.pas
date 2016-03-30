unit UserJournalUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\UserJournalUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "UserJournal" MUID: (4A7FF5F301B2)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , DocumentUnit
 , DynamicTreeUnit
 , SearchUnit
;

type
 TJournalObjectType = (
  {* Типы элементов Журнала работы }
  JOT_BOOKMARK
   {* Закладка }
  , JOT_QUERY
   {* Запрос }
  , JOT_FOLDER
   {* Папка }
 );//TJournalObjectType

 TBookmarkJournalType = (
  BJT_BOOKMARK
   {* Закладки }
  , BJT_PHARM_BOOKMARK
   {* Закладки Инфарма }
 );//TBookmarkJournalType

 IUserJournal = interface
  {* Интерфейс журанла работы }
  ['{30769E5F-13F7-406E-8E2A-2D35B8BE5192}']
  procedure Save(const obj: IUnknown;
   object_type: TJournalObjectType); stdcall;
   {* Сохранить объект в журнал работы }
  procedure Remove(const obj: INodeBase); stdcall;
   {* Удалить объект из журнала работы }
  procedure Clear; stdcall;
   {* Очистить Журнал работы (аналогичен вызову remove (рут дерева журнала работы) }
  function GetUserJornalTree: INodeBase; stdcall;
   {* Получить дерево Журнала работы }
  function GetBookmarkHistory(type: TBookmarkJournalType;
   max_count: Integer): IJournalBookmarkList; stdcall; { can raise CanNotFindData }
   {* список закладок заданного типа }
  function GetQueryHistory(query_type: TQueryType;
   max_count: Integer): IQueryList; stdcall; { can raise CanNotFindData }
   {* Получит список запросов заданного типа из Журнала }
 end;//IUserJournal

implementation

uses
 l3ImplUses
;

end.
