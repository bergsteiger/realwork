unit InternetSupportUnit;
 {* Возможности, доступные через интернет }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\InternetSupportUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "InternetSupport" MUID: (4BD132D103B9)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
;

type
 IInternetSupport = interface
  {* поддержка работы пользователей через internet }
  ['{7DF56131-CBD6-47F5-B8B1-495409AFE6E4}']
  function revision_check_enabled: Boolean;
   {* Разрешена ли онлайн проверка ревизий документов (для супермобильной версии) }
  function get_url_for_document(doc_id: Cardinal;
   para_id: Cardinal): IString;
   {* получить URL для заданного документа }
  function is_internet_agent_enabled: Boolean;
   {* Разрешен ли Интернет-Агент. }
  function get_url_for_internet_version: IString;
   {* получить URL для интранет версии }
  function show_warning: Boolean;
   {* Нужно ли показывать блямбу об отключении онлайн проверки }
 end;//IInternetSupport

 IDecisionsArchiveSupport = interface
  {* Интерфейс доступа к архивам судебных решений }
  ['{CD81011E-549D-406A-964C-9FE291552EB4}']
  function get_archive_url: IString;
   {* получить ссылку для перехода на архив судебных решений }
  function archive_available: Boolean;
   {* архив судебных решений доступен }
 end;//IDecisionsArchiveSupport

class function make: BadFactoryType;
 {* фабрика }
class function make: BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType;
 {* фабрика }
var
 l_Inst : IInternetSupport;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IDecisionsArchiveSupport;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
