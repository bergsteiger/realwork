unit UserJournalUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\UserJournalUnit.pas"
// Стереотип: "Interfaces"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , DynamicTreeUnit
 , DocumentUnit
 , SearchUnit
 , BaseTypesUnit
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
  procedure save(const obj: IUnknown;
   object_type: TJournalObjectType);
   {* Сохранить объект в журнал работы }
  procedure remove(const obj: INodeBase);
   {* Удалить объект из журнала работы }
  procedure clear;
   {* Очистить Журнал работы (аналогичен вызову remove (рут дерева журнала работы) }
  function get_user_jornal_tree: INodeBase;
   {* Получить дерево Журнала работы }
  function get_bookmark_history(type: TBookmarkJournalType;
   max_count: Integer): IJournalBookmarkList; { can raise CanNotFindData }
   {* список закладок заданного типа }
  function get_query_history(query_type: TQueryType;
   max_count: Integer): IQueryList; { can raise CanNotFindData }
   {* Получит список запросов заданного типа из Журнала }
 end;//IUserJournal

class function make: BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType;
var
 l_Inst : IUserJournal;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
