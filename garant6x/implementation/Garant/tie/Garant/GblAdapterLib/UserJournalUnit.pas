unit UserJournalUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/UserJournalUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::UserJournal
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
  BaseTypesUnit,
  DocumentUnit,
  DynamicTreeUnit,
  SearchUnit
  ;

type
 TJournalObjectType = (
  {* Типы элементов Журнала работы }
   JOT_BOOKMARK // Закладка
 , JOT_QUERY // Запрос
 , JOT_FOLDER // Папка
 );//TJournalObjectType

 TBookmarkJournalType = (
   BJT_BOOKMARK // Закладки
 , BJT_PHARM_BOOKMARK // Закладки Инфарма
 );//TBookmarkJournalType

 IUserJournal = interface(IUnknown)
  {* Интерфейс журанла работы }
   ['{30769E5F-13F7-406E-8E2A-2D35B8BE5192}']
   procedure Save(const aObj: IUnknown;
    aObjectType: TJournalObjectType); stdcall;
     {* Сохранить объект в журнал работы }
   procedure Remove(const aObj: INodeBase); stdcall;
     {* Удалить объект из журнала работы }
   procedure Clear; stdcall;
     {* Очистить Журнал работы (аналогичен вызову remove (рут дерева журнала работы) }
   procedure GetUserJornalTree(out aRet {: INodeBase}); stdcall;
     {* Получить дерево Журнала работы }
   procedure GetBookmarkHistory(aType: TBookmarkJournalType;
    aMaxCount: Integer; out aRet {: IJournalBookmarkList}); stdcall; // can raise CanNotFindData
     {* список закладок заданного типа }
   procedure GetQueryHistory(aQueryType: TQueryType;
    aMaxCount: Integer; out aRet {: IQueryList}); stdcall; // can raise CanNotFindData
     {* Получит список запросов заданного типа из Журнала }
 end;//IUserJournal

implementation

end.