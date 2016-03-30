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
  function RevisionCheckEnabled: ByteBool; stdcall;
   {* Разрешена ли онлайн проверка ревизий документов (для супермобильной версии) }
  function GetUrlForDocument(doc_id: Cardinal;
   para_id: Cardinal): IString; stdcall;
   {* получить URL для заданного документа }
  function IsInternetAgentEnabled: ByteBool; stdcall;
   {* Разрешен ли Интернет-Агент. }
  function GetUrlForInternetVersion: IString; stdcall;
   {* получить URL для интранет версии }
  function ShowWarning: ByteBool; stdcall;
   {* Нужно ли показывать блямбу об отключении онлайн проверки }
 end;//IInternetSupport

 IDecisionsArchiveSupport = interface
  {* Интерфейс доступа к архивам судебных решений }
  ['{CD81011E-549D-406A-964C-9FE291552EB4}']
  function GetArchiveUrl: IString; stdcall;
   {* получить ссылку для перехода на архив судебных решений }
  function ArchiveAvailable: ByteBool; stdcall;
   {* архив судебных решений доступен }
  function SearchServerAvailable: ByteBool; stdcall;
   {* проверка доступности сервера поиска в архивах }
  function GetSearchServerUrl(const query: IString): IString; stdcall;
 end;//IDecisionsArchiveSupport

implementation

uses
 l3ImplUses
;

end.
